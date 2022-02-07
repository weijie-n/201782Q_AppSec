using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using static PracticalAssignment.Login;

namespace PracticalAssignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string MYDBConnectionString =
        System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private int checkPassword(string password)
        {
            int score = 0;
            // include your implementation here

            // score 0 very weak!
            // if length of password is less than 8 characters
            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }
            // Score 2 Weak
            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }
            // Score 3 Medium
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
            }
            // Score 4 Strong
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
            }
            // Score 5 Excellent
            if (Regex.IsMatch(password, "[^ a - zA - Z0 - 9]"))
            {
                score++;
            }


            return score;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (ValidateCaptcha())
            {
                //string pwd = get value from your Textbox
                string pwd = tb_password.Text.ToString().Trim(); ;

                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];

                //Fills array of bytes with a cryptographically strong sequence of random values.
                rng.GetBytes(saltByte);
                salt = Convert.ToBase64String(saltByte);

                SHA512Managed hashing = new SHA512Managed();
                string pwdWithSalt = pwd + salt;

                byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
                byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

                finalHash = Convert.ToBase64String(hashWithSalt);

                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;

                createAccount();
                Response.Redirect("Homepage.aspx", false);
            }

            
        }
        protected void createAccount()
        {
            
            using (SqlConnection con = new SqlConnection(MYDBConnectionString))
            {
                int imgFileLength = photo.PostedFile.ContentLength;
                byte[] imageBytes = new byte[imgFileLength];
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@FirstName,@LastName,@CreditCardInfo,@Email,@PasswordHash, @PasswordSalt, @DateofBirth, @Photo, @IV,@KEY)"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                            
                        cmd.Parameters.AddWithValue("@FirstName", tb_firstname.Text.Trim());
                        cmd.Parameters.AddWithValue("@LastName", tb_lastname.Text.Trim());
                        //cmd.Parameters.AddWithValue("@Nric", Convert.ToString(encryptData(tb_nric.Text.Trim())));
                        //cmd.Parameters.AddWithValue("@CreditCardInfo", tb_creditcard.Text.Trim());
                        cmd.Parameters.AddWithValue("@CreditCardInfo", Convert.ToBase64String( encryptData(tb_creditcard.Text.Trim())));
                        cmd.Parameters.AddWithValue("@Email", tb_email.Text.Trim());
                        cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                        cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                        cmd.Parameters.AddWithValue("@DateofBirth", tb_dateofbirth.Text.Trim());
                        cmd.Parameters.AddWithValue("@Photo", imageBytes); ;
                        cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                        cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                        cmd.Connection = con;
                            
                    //con.Close();
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        //throw new Exception(ex.ToString());
                        lbl_error1.Text = ex.ToString();
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                }
            }

        }
            
        
        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        public bool ValidateCaptcha()
        {
            bool results = true;
            string captchaResponse = Request.Form["g-recaptcha-response"];
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
                ("https://www.google.com/recaptcha/api/siteverify?secret=6Lf-q2EeAAAAAI7ynhc-q27CNoSnzCvlw4pyHT9Q &response=" + captchaResponse);

            try
            {
                using (WebResponse wResponse = req.GetResponse())
                {
                    using(StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();
                        lbl_gScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();
                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);
                        results = Convert.ToBoolean(jsonObject.success);
                    }
                }
                return results;
            }
            catch (WebException ex)
            {
                throw ex;
            }

        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);


                //Encrypt
                //cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
                //cipherString = Convert.ToBase64String(cipherText);
                //Console.WriteLine("Encrypted Text: " + cipherString);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            finally { }
            return cipherText;
        }
    }
}