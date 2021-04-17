using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using Microsoft.Owin.Security.DataProtection;

/// <summary>
/// Summary description for CookieSecurityProvider
/// </summary>
public  class CookieSecurityProvider
{
    public string GetKey()
    {
        try
        {
            // Set the path of the config file.
            string configPath = "";

            // Get the Web application configuration object.
            Configuration config = WebConfigurationManager.OpenWebConfiguration(configPath);

            // Get the section related object.
            MachineKeySection configSection =
                (MachineKeySection)config.GetSection("system.web/machineKey");



            return configSection.DecryptionKey;


        }

        catch (Exception e)
        {
            // Unknown error.
           // Console.WriteLine(e.ToString());
            return null;
        }

    }

    public string Protect(string unprotectedText)
    {

        var unprotectedBytes = Encoding.UTF8.GetBytes(unprotectedText);
        var protectedBytes = MachineKey.Protect(unprotectedBytes, GetKey());
        var protectedText = Convert.ToBase64String(protectedBytes);
        return protectedText;
    }

    public string Unprotect(string protectedText)
    {
        var protectedBytes = Convert.FromBase64String(protectedText);
        var unprotectedBytes = MachineKey.Unprotect(protectedBytes, GetKey());
        var unprotectedText = Encoding.UTF8.GetString(unprotectedBytes);
        return unprotectedText;
    }

}