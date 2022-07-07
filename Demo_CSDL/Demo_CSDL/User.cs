using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    class User
    {
        string fullname;
        string username;
        string birthday;
        string email;
        string phone;
        string address;
        string sex;

        public User() { }
        public User(
            string fullname,
            string username,
            string birthday,
            string email,
            string address,
            string phone,
            string sex
         )
        {
            this.fullname = fullname;
            this.username = username;
            this.birthday = birthday;
            this.email = email;
            this.address = address;
            this.phone = phone;
            this.sex = sex;
        }
        public string Fullname { get => fullname; set => fullname = value; }
        public string Username { get => username; set => username = value; }
        public string Birthday { get => birthday; set => birthday = value; }
        public string Email { get => email; set => email = value; }
        public string Phone { get => phone; set => phone = value; }
        public string Address { get => address; set => address = value; }
        public string Sex { get => sex; set => sex = value; }
    
       
    }
}
