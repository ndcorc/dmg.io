const nodemailer = require("nodemailer");
const mandrillTransport = require("nodemailer-mandrill-transport");
const dotenv = require("dotenv");

dotenv.config();
const apiKey = process.env.API_KEY;
const auth = { apiKey };

module.exports = nodemailer.createTransport(mandrillTransport({ auth }));
