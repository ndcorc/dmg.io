const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");
const app = express();

require("sexy-require");
const EmailService = require("$models/EmailService");
const emailService = new EmailService();

admin.initializeApp();

app.use(cors({ origin: true }));
app.post("/", emailService.sendMail);

exports.sendVerificationEmail = functions.https.onRequest(app);
