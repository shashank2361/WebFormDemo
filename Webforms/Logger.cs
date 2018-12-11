using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace Webforms
{
    public class Logger
    {
        public static void Log(Exception exception)
        {
            Log(exception, EventLogEntryType.Error);
        }
        public static void Log(Exception exception, EventLogEntryType eventLogEntryType)
        {
            StringBuilder sbExceptionMessage = new StringBuilder();

            do
            {
                sbExceptionMessage.Append("Exception Type" + Environment.NewLine);
                sbExceptionMessage.Append(exception.GetType().Name);
                sbExceptionMessage.Append(Environment.NewLine + Environment.NewLine);
                sbExceptionMessage.Append("Message" + Environment.NewLine);
                sbExceptionMessage.Append(exception.Message + Environment.NewLine + Environment.NewLine);
                sbExceptionMessage.Append("Stack Trace" + Environment.NewLine);
                sbExceptionMessage.Append(exception.StackTrace + Environment.NewLine + Environment.NewLine);

                exception = exception.InnerException;
            }
            while (exception != null);

            string logProvider = ConfigurationManager.AppSettings["LogProvider"];
            if (logProvider.ToLower() == "both")
            {
                LogToDb(sbExceptionMessage.ToString());
                LogToEventViewer(sbExceptionMessage.ToString());
            }
            else if (logProvider.ToLower() == "database")
            {
                LogToDb(sbExceptionMessage.ToString());
            }
            else if (logProvider.ToLower() == "eventviewer")
            {
                LogToEventViewer(sbExceptionMessage.ToString());
            }

            string sendEmail = ConfigurationManager.AppSettings["SendEmail"];
            if (sendEmail.ToLower() == "true")
            {
                SendEmail(sbExceptionMessage.ToString());
            }


            // This is for Event logging 
            // If the Event log source exists
            //if (EventLog.SourceExists("ShashankCustom Event Log Source"))
            //{
            //    EventLog log = new EventLog("ShashankCustom Event Log");
            //    log.Source = "ShashankCustom Event Log Source";
            //    log.WriteEntry(sbExceptionMessage.ToString(), eventLogEntryType);
            //}

        }
        private static void LogToDb(string log)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("spInsertLog", con);
                // CommandType is in System.Data namespace
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter parameter = new SqlParameter("@ExceptionMessage", log);
                cmd.Parameters.Add(parameter);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        private static void LogToEventViewer(string log)
        {
            if (EventLog.SourceExists("ShashankCustom Event Log Source"))
            {
                // Create an instance of the eventlog
                EventLog eventLog = new EventLog("ShashankCustom Event Log");
                // set the source for the eventlog
                eventLog.Source = "ShashankCustom Event Log Source";
                // Write the exception details to the event log as an error
                eventLog.WriteEntry(log, EventLogEntryType.Error);
            }
             


        }
        public static void SendEmail(string emailbody)
        {
            // Specify the from and to email address
            MailMessage mailMessage = new MailMessage("shashank.shekhar.m@gmail.com", "shashank.shekhar.m@gmail.com");
            // Specify the email body
            mailMessage.Body = emailbody;
            // Specify the email Subject
            mailMessage.Subject = "Exception";

            // Now details are on webconfig           
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Send(mailMessage);

            // Specify the SMTP server name and post number
            //SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            //// Specify your gmail address and password
            //smtpClient.Credentials = new System.Net.NetworkCredential()
            //{
            //    UserName = "shashank.shekhar.m@gmail.com",
            //    Password = "Computer100%"
            //};
            // Gmail works on SSL, so set this property to true
            smtpClient.EnableSsl = true;
            // Finall send the email message using Send() method
            smtpClient.Send(mailMessage);
        }




    }
}


//public static void Log(Exception exception)
//{
//    // Create an instance of StringBuilder. This class is in System.Text namespace
//    StringBuilder sbExceptionMessage = new StringBuilder();
//    sbExceptionMessage.Append("Exception Type" + Environment.NewLine);
//    // Get the exception type
//    sbExceptionMessage.Append(exception.GetType().Name);
//    // Environment.NewLine writes new line character - \n
//    sbExceptionMessage.Append(Environment.NewLine + Environment.NewLine);
//    sbExceptionMessage.Append("Message" + Environment.NewLine);
//    // Get the exception message
//    sbExceptionMessage.Append(exception.Message + Environment.NewLine + Environment.NewLine);
//    sbExceptionMessage.Append("Stack Trace" + Environment.NewLine);
//    // Get the exception stack trace
//    sbExceptionMessage.Append(exception.StackTrace + Environment.NewLine + Environment.NewLine);

//    // Retrieve inner exception if any
//    Exception innerException = exception.InnerException;
//    // If inner exception exists
//    while (innerException != null)
//    {
//        sbExceptionMessage.Append("Exception Type" + Environment.NewLine);
//        sbExceptionMessage.Append(innerException.GetType().Name);
//        sbExceptionMessage.Append(Environment.NewLine + Environment.NewLine);
//        sbExceptionMessage.Append("Message" + Environment.NewLine);
//        sbExceptionMessage.Append(innerException.Message + Environment.NewLine + Environment.NewLine);
//        sbExceptionMessage.Append("Stack Trace" + Environment.NewLine);
//        sbExceptionMessage.Append(innerException.StackTrace + Environment.NewLine + Environment.NewLine);

//        // Retrieve inner exception if any
//        innerException = innerException.InnerException;
//    }

//    // If the Event log source exists
//    if (EventLog.SourceExists("ShashankCustom Event Log Source"))
//    {
//        // Create an instance of the eventlog
//        EventLog log = new EventLog("ShashankCustom Event Log");
//        // set the source for the eventlog
//        log.Source = "ShashankCustom Event Log";
//        // Write the exception details to the event log as an error
//        log.WriteEntry(sbExceptionMessage.ToString(), EventLogEntryType.Error);
//    }