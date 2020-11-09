const functions = require("firebase-functions");
const admin = require("firebase-admin");
const dotenv = require("dotenv");
const handlebars = require("handlebars");
const path = require("path");
const appDir = path.dirname(__filename);
console.log(appDir);
require("sexy-require");
const emailTemplate = require("$utils/emailTemplate");
const { APP_BUCKET, APP_ICON, MOBILE_ICON } = process.env;
const appIcon = `${APP_BUCKET}/${APP_ICON}`;
const mobileIcon = `${APP_BUCKET}/${MOBILE_ICON}`;
console.log(appIcon);

class EmailService {
  constructor() {}

  async sendMail(req, res) {
    const { fullName, email, actionCode } = req.body;
    const template = handlebars.compile(emailTemplate);
    let dynamicLink = await admin
      .auth()
      .generateSignInWithEmailLink(email, actionCode);
    let replacements = { email, fullName, dynamicLink, appIcon, mobileIcon };
    let subject = `Confirm ${email} on DMG.io`;
    let html = template(replacements),
      text = html;
    let mailOptions = {
      to: email,
      message: { subject, text, html },
    };
    try {
      let msg = await admin.firestore().collection("mail").add(mailOptions);
      return res.send(`Success: ${msg}`);
    } catch (e) {
      return res.send(`Error: ${e}`);
    }
  }
}

module.exports = EmailService;
