using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using StudentsInternship.Models;

namespace StudentsInternship.Views.StudentDistributionsPages
{
    /// <summary>
    /// Логика взаимодействия для StudentDistributionsAddEditPage.xaml
    /// </summary>
    public partial class StudentDistributionsAddEditPage : Page
    {
        private PracticeDistributions currentElem = new PracticeDistributions();

        bool isEditing = false;
        public List<PracticeDistributions> distributionsContext = App.Context.PracticeDistributions.ToList();
        public List<PracticeDistributions> distributionsList = new List<PracticeDistributions>();
        public List<StudentsDistribution> studentsDistributionContext = App.Context.StudentsDistribution.ToList();
        public List<StudentsDistribution> studentsdistributionsList = new List<StudentsDistribution>();
        public List<EducationalOrganisations> educationalOrganisationsList = App.Context.EducationalOrganisations.ToList();
        public List<Groups> groupsList = App.Context.Groups.ToList();
        public List<PracticeSchedules> practiceSchedulesList = App.Context.PracticeSchedules.ToList();
        public List<Agreements> agreementsList = App.Context.Agreements.ToList();
        public List<Students> studentsList = new List<Students>();
        public List<Students> studentsContext = App.Context.Students.ToList();

        public List<EducationalOrganisations> educationalOrganisationsReal = new List<EducationalOrganisations>();
        public List<Groups> groupsReal = new List<Groups>();
        public List<Agreements> agreementsReal = new List<Agreements>();


        public StudentDistributionsAddEditPage(PracticeDistributions elemData)
        {
            InitializeComponent();


            if (elemData != null)
            {
                isEditing = true;
                Title = "Распределение студентов. Редактирование";
                currentElem = elemData;

                //There is no editing here though...
            }
            DataContext = currentElem;

            CheckBoxCheck();

            cmbEducationalOrganisation.ItemsSource = App.Context.EducationalOrganisations.ToList();
        }
        private void CheckBoxCheck()
        {
            groupsReal.Clear();
            educationalOrganisationsReal.Clear();
            agreementsReal.Clear();
            var today = DateTime.Today;

            //Deleting schedules that is Expired
            practiceSchedulesList = practiceSchedulesList.Where(p => p.PracticeEndDate.Date >= today).ToList();
            foreach (var elem in practiceSchedulesList)
            {
                if (groupsList.Any(p => p.PracticeSchedules == elem))
                    groupsReal.Add(groupsList.First(p => p.PracticeSchedules == elem));
            }

            //Selecting groups that have unexpired practices
            foreach(var elem in groupsReal)
            {
                if (educationalOrganisationsList.Any(p => p.Groups == elem))
                    educationalOrganisationsReal.Add(educationalOrganisationsList.First(p => p.Groups == elem));
            }

            agreementsList = agreementsList.Where(p => p.AgreementEndDate.HasValue).ToList();

            cmbEducationalOrganisation.ItemsSource = educationalOrganisationsList;

            //Selecting educational organisations that have groups with unexpired practices
            if (cmbEducationalOrganisation.SelectedItem != null)
            {
                groupsList = groupsList.Where(p => p.EducationalOrganisations == cmbEducationalOrganisation.SelectedItem).ToList();
                cmbGroup.ItemsSource = groupsList;
                cmbGroup.IsEnabled = true;
            }
            else
            {
                cmbGroup.SelectedItem = null;
                cmbGroup.IsEnabled = false;
            }

            //Practice Schedules ComboBox stage
            if (cmbGroup.IsEnabled == true && cmbGroup.SelectedItem != null)
            {
                practiceSchedulesList = practiceSchedulesList.Where(p => p.Groups == cmbGroup.SelectedItem).ToList();

                if (distributionsList.Count > 1)
                {
                    var selectedAgreement = (Agreements)cmbAgreement.SelectedItem;
                    practiceSchedulesList = practiceSchedulesList.Where(p => p.PracticeEndDate <= selectedAgreement.AgreementEndDate).ToList();
                }

                cmbPracticesSchedules.ItemsSource = practiceSchedulesList;
                cmbPracticesSchedules.IsEnabled = true;
            }
            else
            {
                cmbPracticesSchedules.SelectedItem = null;
                cmbPracticesSchedules.IsEnabled = false;
            }

            //Agreements ComboBox stage
            if (cmbPracticesSchedules.IsEnabled == true && cmbPracticesSchedules.SelectedItem != null)
            {
                var selectedGroup = (Groups)cmbGroup.SelectedItem;
                var agreementSpecilalityList = App.Context.AgreementSpeciality.ToList();
                var selectedPracticeSchedule = (PracticeSchedules)cmbPracticesSchedules.SelectedItem;

                agreementsList = agreementsList.Where(p => p.AgreementEndDate.Value.Date >= selectedPracticeSchedule.PracticeEndDate).ToList();

                agreementSpecilalityList = agreementSpecilalityList.Where(p => p.Specialties == selectedGroup.Specialties).ToList();
                foreach (var elem in agreementSpecilalityList)
                {
                    if (agreementsList.Any(p => p.AgreementSpeciality.Contains(elem)))
                        agreementsReal.Add(agreementsList.First(p => p.AgreementSpeciality.Contains(elem)));
                }


                //Deleting the agreement that is used in these practice schedule(-es)
                if (distributionsList.Count > 0)
                {
                    foreach(var tempA in distributionsList)
                    {
                        foreach (var elem in distributionsContext.Where(p => p.PracticeSchedules == tempA.PracticeSchedules).ToList())
                        {
                            if (agreementsReal.Any(p => p.AgreementNumber == elem.AgreementID))
                            {
                                agreementsReal.Remove(agreementsReal.First(p => p.AgreementNumber == elem.AgreementID));
                            }
                        }
                    }
                }
                else
                {
                    foreach (var elem in distributionsContext.Where(p => p.PracticeSchedules == selectedPracticeSchedule).ToList())
                    {
                        if (agreementsReal.Any(p => p.AgreementNumber == elem.AgreementID))
                        {
                            agreementsReal.Remove(agreementsReal.First(p => p.AgreementNumber == elem.AgreementID));
                        }
                    }
                }

                if (agreementsReal.Count > 0)
                {
                    tbPeopleOnAgreement.Text = "0";
                    txtResidenceRequired.Text = "?";
                    cmbAgreement.ItemsSource = agreementsReal;
                    cmbAgreement.IsEnabled = true;
                }
                else
                {
                    cmbAgreement.IsEnabled = false;
                    txtResidenceRequired.Text = "?";
                    tbPeopleOnAgreement.Text = $"Актуальных договоров для специальности {selectedGroup.Specialties.NumberNameSpeciality} - не найдено";
                }

            }

            //Students ComboBox stage
            if (cmbAgreement.SelectedItem != null)
            {
                var selectedPracticeSchedule = (PracticeSchedules)cmbPracticesSchedules.SelectedItem;
                var selectedAgreement = (Agreements)cmbAgreement.SelectedItem;
                var selectedGroup = (Groups)cmbGroup.SelectedItem;
                studentsList = studentsContext.Where(p => p.Groups == selectedGroup).ToList();
                
                if (selectedAgreement.NumberOfPeople > 0)
                {
                    tbPeopleOnAgreement.Text = selectedAgreement.NumberOfPeople + "";
                }
                else
                {
                    tbPeopleOnAgreement.Text = "Не указано";
                }
                cmbStudents.IsEnabled = true;

                //Deleting student that is used in previous practice distributions
                if (distributionsList.Count < 1)
                {
                    foreach (var elem in distributionsContext.Where(p => p.PracticeSchedules == selectedPracticeSchedule).ToList())
                    {
                        foreach (var item in studentsDistributionContext.Where(p => p.PracticeDistributions == elem))
                        {
                            if (studentsList.Any(p => p.ID == item.StudentID))
                            {
                                studentsList.Remove(studentsList.First(p => p.ID == item.StudentID));
                            }
                        }
                    }
                }
                else
                {
                    foreach (var practiceDist in distributionsList)
                    {
                        foreach (var elem in distributionsContext.Where(p => p.PracticeSchedules == practiceDist.PracticeSchedules).ToList())
                        {
                            foreach (var item in studentsDistributionContext.Where(p => p.PracticeDistributions == elem))
                            {
                                if (studentsList.Any(p => p.ID == item.StudentID))
                                {
                                    studentsList.Remove(studentsList.First(p => p.ID == item.StudentID));
                                }
                            }
                        }
                    }
                }


                if (selectedAgreement.IsRegistrationRequired)
                {
                    studentsList = studentsList.Where(p => p.ResidenceRegistration == true).ToList();
                    txtResidenceRequired.Text = "Необходима";
                }
                else
                {
                    txtResidenceRequired.Text = "Не обязательна";
                }

                cmbStudents.ItemsSource = studentsList;
            }
            else
            {
                tbPeopleOnAgreement.Text = "*";
                cmbStudents.IsEnabled = false;
            }
            if (datagridSpecilities.Items.Count < 1)
            {
                cmbAgreement.IsEnabled = true;
                cmbEducationalOrganisation.IsEnabled = true;
            }
        }
        private void cmbEducationalOrganisation_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            CheckBoxCheck();
        }

        private void cmbGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            CheckBoxCheck();
        }

        private void cmbPracticesSchedules_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            CheckBoxCheck();
        }

        private void cmbAgreement_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            CheckBoxCheck();
        }

        private void cmbStudents_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbStudents.SelectedItem != null)
            {
                cmbAgreement.IsEnabled = false;
                cmbEducationalOrganisation.IsEnabled = false;
                var selectedSchedule = (PracticeSchedules)cmbPracticesSchedules.SelectedItem;
                var selectedAgreement = (Agreements)cmbAgreement.SelectedItem;
                var studentSelected = (Students)cmbStudents.SelectedItem;
                if (!distributionsList.Any(p => p.PracticeSchedules == selectedSchedule))
                {
                    PracticeDistributions practicedistributionAdd = new PracticeDistributions();
                    practicedistributionAdd.PracticeSchedules = selectedSchedule;
                    practicedistributionAdd.PracticeScheduleID = selectedSchedule.ID;
                    practicedistributionAdd.Agreements = selectedAgreement;
                    practicedistributionAdd.AgreementID = selectedAgreement.AgreementNumber;

                    distributionsList.Add(practicedistributionAdd);
                    distributionsContext.Add(practicedistributionAdd);

                    StudentsDistribution studentInDistribution = new StudentsDistribution();
                    studentInDistribution.PracticeDistributions = practicedistributionAdd;
                    studentInDistribution.Students = studentSelected;
                    studentInDistribution.StudentID = studentSelected.ID;

                    studentsdistributionsList.Add(studentInDistribution);
                    studentsDistributionContext.Add(studentInDistribution);

                    practicedistributionAdd.StudentsDistribution.Add(studentInDistribution);

                    App.Context.PracticeDistributions.Add(practicedistributionAdd);
                    App.Context.StudentsDistribution.Add(studentInDistribution);

                    //Delete the selected student
                    studentsList.Remove(studentSelected);
                }
                else
                {
                    var practiceDistiribution = distributionsList.FirstOrDefault(p => p.Agreements == selectedAgreement && p.PracticeSchedules == selectedSchedule);
                    StudentsDistribution studentInDistribution = new StudentsDistribution();
                    studentInDistribution.PracticeDistributions = practiceDistiribution;
                    studentInDistribution.Students = studentSelected;
                    studentInDistribution.StudentID = studentSelected.ID;

                    studentsdistributionsList.Add(studentInDistribution);
                    studentsDistributionContext.Add(studentInDistribution);

                    practiceDistiribution.StudentsDistribution.Add(studentInDistribution);

                    App.Context.StudentsDistribution.Add(studentInDistribution);

                    //Delete the selected student
                    studentsList.Remove(studentSelected);
                }
            }

            cmbStudents.ItemsSource = studentsList;
            cmbStudents.Items.Refresh();
            cmbStudents.SelectedIndex = -1;

            datagridSpecilities.ItemsSource = distributionsList;
            datagridSpecilities.Items.Refresh();
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (datagridSpecilities.SelectedItems.Count > 0)
            {
                var elemsToDelete = datagridSpecilities.SelectedItems.Cast<PracticeDistributions>().ToList();
                if (MessageBox.Show($"Вы точно хотите удалить следующие {elemsToDelete.Count()} элементов?", "Внимание",
                    MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    foreach (var item in elemsToDelete)
                    {
                        App.Context.PracticeDistributions.Remove(item);
                        distributionsContext.Remove(item);
                        distributionsList.Remove(item);
                    }

                    try
                    {
                        MessageBox.Show("Данные удалены!");
                        if (distributionsList.Count < 1)
                        {
                            cmbAgreement.IsEnabled = true;
                            cmbEducationalOrganisation.IsEnabled = true;
                        }
                        datagridSpecilities.ItemsSource = distributionsList;
                        datagridSpecilities.Items.Refresh();
                        CheckBoxCheck();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }
                }
            }
        }
        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            // Check if fields are filled
            StringBuilder err = new StringBuilder();
            if (distributionsList.Count < 1)
                err.AppendLine("Добавьте хотя бы одну практику");
            if (studentsdistributionsList.Count < 1)
                err.AppendLine("Добавьте хотя бы одного студента");

            if (err.Length > 0)
            {
                MessageBox.Show(err.ToString(), "Ошибка!", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }


            try
            {
                Microsoft.Win32.SaveFileDialog dlg = new Microsoft.Win32.SaveFileDialog();
                dlg.FileName = "Распределение"; // Default file name
                dlg.DefaultExt = ".docx"; // Default file extension
                dlg.Filter = "Word documents (.doc/.docx)|*.doc;*.docx"; // Filter files by extension

                // Show save file dialog box
                Nullable<bool> result = dlg.ShowDialog();

                // Process save file dialog box results
                if (result == true)
                {
                    // Save document
                    string filename = dlg.FileName;
                    WordExportClass.WordExport(filename, studentsdistributionsList);
                    Process p = new Process();
                    p.StartInfo.FileName = @filename;
                    p.Start();
                }
                App.Context.SaveChanges();
                MessageBox.Show("Данные сохранены");
                var wnd = Window.GetWindow(this);
                wnd.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
                if (ex.InnerException != null)
                    MessageBox.Show(ex.InnerException.ToString());
            }
        }
        private void BtnSaveAndNew_Click(object sender, RoutedEventArgs e)
        {
            string directory = System.IO.Path.GetFullPath(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory));
            string filetempfile = directory + "tempFile.docx";
            try
            {
                WordExportClass.WordExport(filetempfile, studentsdistributionsList);
                MessageBox.Show("Это временный файл.\nНе пересохраняйте его во избежание дублирования данных", "Внимание!", MessageBoxButton.OK, MessageBoxImage.Information);
                Process p = new Process();
                p.StartInfo.FileName = @filetempfile;
                p.Start();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
                if (ex.InnerException != null)
                    MessageBox.Show(ex.InnerException.ToString());
            }
        }
    }
}
