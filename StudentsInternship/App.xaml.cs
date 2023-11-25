using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using StudentsInternship.Models;

namespace StudentsInternship
{
    /// <summary>
    /// Логика взаимодействия для App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static StudentsIntershipDBEntities Context { get; } = new StudentsIntershipDBEntities();
    }
}
