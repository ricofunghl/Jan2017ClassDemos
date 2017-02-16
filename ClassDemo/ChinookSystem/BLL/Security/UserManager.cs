﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using ChinookSystem.DAL.Security;
using Chinook.Data.Entities.Security;
using ChinookSystem.DAL;
using Chinook.Data.POCOs;
#endregion

namespace ChinookSystem.BLL.Security
{
    public class UserManager : UserManager<ApplicationUser>
    {
        #region Constants
        private const string STR_DEFAULT_PASSWORD = "Pa$$word1";
        /// <summary>Requires FirstName and LastName</summary>
        private const string STR_USERNAME_FORMAT = "{0}.{1}";
        /// <summary>Requires UserName</summary>
        private const string STR_EMAIL_FORMAT = "{0}@chinook.ca";
        private const string STR_WEBMASTER_USERNAME = "Webmaster";
        #endregion

        public UserManager()
            : base(new UserStore<ApplicationUser>(new ApplicationDbContext()))
        {
        }

        public void AddWebMaster()
        {
            //Users accesses all the records on the AspNetUsers Table
            //UserName is the user logon user id e.g. dwelch
            if (!Users.Any(u => u.UserName.Equals(STR_WEBMASTER_USERNAME)))
            {
                //create a new instance that will be used as the data to
                //add a new record to the AspNetUsers table
                //dynamically fill two attribute of the instance
                var webmasterAccount = new ApplicationUser()
                {
                    UserName = STR_WEBMASTER_USERNAME,
                    Email = string.Format(STR_EMAIL_FORMAT, STR_WEBMASTER_USERNAME)
                };

                //place the webmaster account on the AspNetUsers table
                this.Create(webmasterAccount, STR_DEFAULT_PASSWORD);

                //place an account role record on the AspNetUserRoles table
                //.Id comes from the webmasterAccount and is the pkey of the Users table
                //role will come from the Entities.Security.SecurityRoles
                this.AddToRole(webmasterAccount.Id, SecurityRoles.WebsiteAdmins);
            }
        }

        public void AddEmployees()
        {
            using (var context = new ChinookContext())
            {
                //get all current employees
                //linq query will not execute as yet
                //return datatype will be IQueryable
                var currentEmployees = from x in context.Employees
                                       select new EmployeeListPOCO
                                       {
                                           EmployeeId = x.EmployeeId,
                                           FirstName = x.FirstName,
                                           LastName = x.LastName
                                       };

                //get all employees who have an user account
                //Users needs to be in memory therefore use .ToList()
                //POCO EmployeeID is an int
                //the Users Employee id is an int?
                //since we will only be retrieving
                //Users that are employees (ID is not null)
                //we need to convert the nullable int into a require int
                //the results of this query will be in memory
                var userEmployees = from x in Users.ToList()
                                    where x.EmployeeID.HasValue
                                    select new RegisteredEmployeePOCO
                                    {
                                        UserName = x.UserName,
                                        EmployeeId = int.Parse(x.EmployeeID.ToString())
                                    };
                //loop the see if auto generation of new employee
                //Users record is needed
                //the foreach causes the delayed execution of the linq above
                foreach (var employee in currentEmployees)
                {
                    //does the employee NOT have a logon (no Users record)
                    if (!userEmployees.Any(us => us.EmployeeId == employee.EmployeeId))
                    {
                        //create a suggested employee UserName
                        //firstname initial + lastname: dwelch
                        var newUserName = employee.FirstName.Substring(0, 1) + employee.LastName;

                        //create a new User ApplicationUser instance
                        var userAccount = new ApplicationUser()
                        {
                            UserName = newUserName,
                            Email = string.Format(STR_EMAIL_FORMAT, newUserName),
                            EmailConfirmed = true

                        };
                        userAccount.EmployeeID = employee.EmployeeId;
                        //create the User record
                        IdentityResult result = this.Create(userAccount, STR_DEFAULT_PASSWORD);

                        //result hold the return value of the creation attempt
                        //if true, account was created,
                        //if false, an account already exists with that username

                        if (!result.Succeeded)
                        {
                            //name already in use
                            //get a UserName that is not in use
                            newUserName = VerifyNewUserName(newUserName);
                            userAccount.UserName = newUserName;
                            this.Create(userAccount, STR_DEFAULT_PASSWORD);
                        }

                        //creat the staff role in UserRoles
                        this.AddToRole(userAccount.Id, SecurityRoles.Staff);
                    }
                }

            }
        }

        public string VerifyNewUserName(string suggestUserName)
        {
            //get a list of all current usersnames (customers and employees)
            // that start with the suggestUserName
            //list of strings
            //will be in memory
            var allUserNames = from x in Users.ToList()
                               where x.UserName.StartsWith(suggestUserName)
                               orderby x.UserName
                               select x.UserName;
            //set up the verified unique UserName
            var verifiedUserName = suggestUserName;

            //the following for loop will continue to loop until
            //an unused UserName has been genereated
            //the condition searches all current UserNames for the 
            //currently generated verified user name (inside loop code)
            //if found the loop will generate a new verified name
            //based on the original suggested username and the counter
            //This loop continues until an unused username is found
            //OrdinalIgnoreCase: case does not matter
            for (int i = 1; allUserNames.Any(x => x.Equals(verifiedUserName, StringComparison.OrdinalIgnoreCase)); i++)
            {
                verifiedUserName = suggestUserName + i.ToString();
            }

            //return the finalized new verified user name
            return verifiedUserName;
        }
    }
}
