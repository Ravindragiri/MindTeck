using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Eatery.Common
{
    public sealed class ServiceHostHelper
    {
        /// <summary>
        /// Reads the App.config and get all the declared services and create the
        /// type of the service to help the console to host the service.
        /// </summary>
        /// <returns></returns>
        public static List<Type> GetAllServices(string configFile)
        {
            //load the app config to query using linq
            XDocument configXML = XDocument.Load(configFile);//"CCS.ServiceConsole.exe.config");

            //query all the services declared in the config file
            var configs = (from config in configXML.Descendants("service")
                           select new AssemblyDetails
                           {
                               ActivatorClass = config.Attribute("name").Value
                           }
                           );
            //load the assembly that holds all the service class.
            Assembly assembly;
            string basePath;
            basePath = System.AppDomain.CurrentDomain.BaseDirectory;
            if (basePath.EndsWith("\\") == false)
                basePath = basePath + "\\";
            assembly = Assembly.LoadFrom(basePath + "CCS.Services.dll");

            List<Type> assmTypes = new List<Type>();
            //using the reflection to create the type from the service assembly
            foreach (AssemblyDetails assm in configs)
            {
                Type type = assembly.GetType(assm.ActivatorClass);
                assmTypes.Add(type);
            }
            return assmTypes;
        }
    }
}
