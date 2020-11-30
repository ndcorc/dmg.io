const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const handlebars = require("handlebars");
const sgMail = require("@sendgrid/mail");

const emailTemplate = require("./utils/testEmailTemplate");
/* const transport = require("./utils/mailerConfig"); */

dotenv.config();
const { NO_REPLY, API_KEY } = process.env;
sgMail.setApiKey(API_KEY);

const app = express();
app.use(cors({ origin: true }));
app.post("/", async (req, res) => {
  const { toEmail, subject, message } = req.body;
  console.log("executing testEmail ...");
  let template = handlebars.compile(emailTemplate);
  let replacements = { fromEmail: NO_REPLY, toEmail, message };
  let html = template(replacements);
  let mailOptions = {
    from: NO_REPLY,
    to: toEmail,
    subject: subject,
    text: html,
    html: html,
  };
  sgMail.send(mailOptions);
});

exports.sendTestEmail = functions.https.onRequest(app);
