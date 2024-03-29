﻿using System.ComponentModel.DataAnnotations;

namespace BookHeaven.Models
{
    public class Signup
    {
        [Required(ErrorMessage = "Email is required.")]
        [RegularExpression("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", ErrorMessage = "Email must follow a generic email pattern.")]
        public string email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        [RegularExpression("^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()-_=+{}\\[\\]|;:'\",.<>?]{6,12}$",
            ErrorMessage = "Password must have at-least one capital letter, at-least one number and be between 6 and 12 chars long.")]
        public string password { get; set; }

        [Required(ErrorMessage = "First name is required")]
        [RegularExpression("^[a-zA-Z]{2,20}$", ErrorMessage = "The input must contain only letters (a-z or A-Z) and be between 2 and 20 characters long.")]
        public string firstName { get; set; }

        [Required(ErrorMessage = "Last name is required")]
        [RegularExpression("^[a-zA-Z]{2,20}$", ErrorMessage = "The input must contain only letters (a-z or A-Z) and be between 2 and 20 characters long.")]
        public string lastName { get; set; }


        public Signup() { }

        public Signup(string _email, string _password, string _firstName, string _lastName)
        {
            email = _email;
            password = _password;
            firstName = _firstName;
            lastName = _lastName;
        }
    }
}
