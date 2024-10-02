import SwiftUI

struct PerCheck: View {
    
    
    
    //Array example tasks
    @State private var Utasks: [Task] = [
        Task(time: "6:00 AM", name: "Feed", isCompleted: true, frequency: "Daily"),
        Task(time: "1:00 PM", name: "Feed", isCompleted: false, frequency: "Daily"),
        Task(time: "3:15 PM", name: "Water", isCompleted: false, frequency: "Daily"),
        Task(time: "10:00 PM", name: "LitterBox", isCompleted: false, frequency: "Weekly"),
        Task(time: "12:00 PM", name: "Feed", isCompleted: false, frequency: "Weekly"),
        Task(time: "12:30 PM", name: "Water", isCompleted: false, frequency: "Weekly"),
        Task(time: "12:35 PM", name: "feed", isCompleted: false, frequency: "Weekly"),
        Task(time: "12:36 PM", name: "feed", isCompleted: false, frequency: "Weekly")
    ]
    
    
    
    
    
    //by default we are not in the edit page
    @State private var isEditing = false
    
    
    
    
    
    
    //here is how the current day picked
    var startDate: Date {
            let today = Calendar.current.startOfDay(for: Date())
            let weekday = Calendar.current.component(.weekday, from: today)
            let daysFromSunday = weekday - Calendar.current.firstWeekday
            return Calendar.current.date(byAdding: .day, value: -daysFromSunday, to: today)!
        }

        var daysOfWeek: [Date] {
            (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: startDate) }
        }

        var currentDayName: String {
            DateFormatter().shortWeekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1]
        }


    
    
    
    
    
    
    
    
    //All what is showing in the screen
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundGray").ignoresSafeArea()
                
                //الزاوية البرتقاليه
                Image("background")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 500)
                    .position(x: 280, y: 30)

                VStack {
                    header
                    dayPicker
                    taskHeader
                    taskList
                }
            }
            
            
            
            
            
            //اجزاء البار العلوي
            .navigationBarItems(
                //ليدنق يعني البار يبدا من اليسار
                //navBarLeading is calling a var contain the HStack
                leading: navBarLeading,
                
                //ترايلنق يعني البار يبدا من اليمين
                //toggle mean the isEditing will be True (the default is false)
                trailing: Button("Edit") { isEditing.toggle() }.foregroundColor(.gray)
            )
            
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { //loadTasks()
            }
            
            //what inside the edit button
            .sheet(isPresented: $isEditing) {
                
                //SetSchedule(isEditing:$isEditing)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //استدعيناهم داخل الNavigationView
    var header: some View {
        VStack(alignment: .leading) {
            Text("October").font(.system(size: 20)).foregroundColor(.gray).padding(.leading, -160)
            Text("Today reminders").font(.title).fontWeight(.light).padding(.leading, -160)
        }
        .padding()
    }
    
    
    
    
    
    
    
    //استدعيناهم داخل الNavigationView
    //week display
    var dayPicker: some View {
            HStack(spacing: 8) {
                ForEach(daysOfWeek, id: \.self) { day in
                    let dayName = getDayName(for: day)
                    let dayOfMonth = getDayOfMonth(for: day)
                    VStack {
                        Text(dayName).font(.caption).padding(.bottom, 10)
                        Text(dayOfMonth)
                            .font(.callout)
                            .padding()
                        //currentday will have a orange circle
                            .background(dayName == currentDayName ? Color.orange : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()
    }
    
    
    
    
    
    
    
    
    
    
    //استدعيناهم داخل الNavigationView
    var taskHeader: some View {
        HStack {
            Text("Time").font(.headline).foregroundColor(.gray).frame(width: 80, alignment: .leading)
            Text("Task").font(.headline).foregroundColor(.gray)
            Spacer()
        }.padding(.horizontal)
    }
    
    
    
    
    
    
    
    
    
    //استدعيناهم داخل الNavigationView
    //يجيب اراي التاسكز ويظهرهم هنا
    var taskList: some View {
        //سوينا سكرول للتساكز
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach($Utasks) { $task in
                    TaskView(task: $task, tasks: $Utasks)
                }
            }}
            .padding()
            
            //الصندوق الابيض
        //طلعنا الصندوق الابيض برا السكرول عشان م ينسحب مع التاسكز
            .background(Color.white)
            .cornerRadius(45)
            .shadow(radius: 1)
            .padding(.horizontal)
        //}
    }
    
    
    
    
    
    //استدعيناه فوق مع اجزاء البار
    var navBarLeading: some View {
        HStack {
            Image(systemName: "chevron.left")
            Image(systemName: "pawprint.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            Text("CatName").font(.title)
        }
    }
    
    
    
    
    
    
    
//الفنكشنز الي استخدمناها فوق
    func getDayName(for date: Date) -> String {
        DateFormatter().shortWeekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
    
    func getDayOfMonth(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    
    
    
    //في مشكلة هنا م يحفظ الاراي تاسكز الجديده
//    func saveTasks() {
//        if let encoded = try? JSONEncoder().encode(Utasks) {
//            UserDefaults.standard.set(encoded, forKey: "tasks")
//        }
//    }

    
    
    
//    func loadTasks() {
//        if let savedData = UserDefaults.standard.data(forKey: "tasks"),
//           let loadedTasks = try? JSONDecoder().decode([Task].self, from: savedData) {
//            Utasks = loadedTasks
//        } else {
//            //saveTasks() // Save default tasks if no data is found
//        }
//    }
}
















struct TaskView: View {
    @Binding var task: Task
    @Binding var tasks: [Task]
    
    var body: some View {
        HStack(alignment: .top) {
            //يجيب الاوقات الي بالاراي تاسكز
            Text(task.time)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 80, alignment: .leading)
            
            
            
            //الخطوط الزرقاء الي تفصل الوقت والتاسك
            Rectangle()
                .frame(width: 2)
                .foregroundColor(.blue)
                .padding(.vertical, 5)
            
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        //يجيب التاسكز الي بالاراي تاسكز
                        Text(task.name)
                            .font(.system(size: 18, weight: .bold))
                        
                        //اذا الاراي اكتمل يصير فوق عنوان التاسك خط رمادي
                            .strikethrough(task.isCompleted, color: .gray)
                        
                        //يجيب التكرار الي بالاراي تاسكز
                        Text(task.frequency)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()

                    
                    //ايكون الباو وكيف يصير له تشيك
                    Image(systemName: task.isCompleted ? "pawprint.fill" : "pawprint")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.orange)
                        .onTapGesture {
                            task.isCompleted.toggle()
                            saveTasks()
                        }
                }
            }
           
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            .padding()
            //المربع البرتقالي داخله التساك
            .background(Color.orange.opacity(0.3))
            
            //حدة الزاويه
            .cornerRadius(25)
            .overlay(
                //الايطار الربتقالي الي يكون على التاسكز الغير مكتمله
                RoundedRectangle(cornerRadius: 25)
                //If task.isCompleted is true, the stroke width will be 0, meaning no visible stroke.
                //If task.isCompleted is false, the stroke width will be 2, meaning the stroke will be 2 points thick.
                    .stroke(Color.orange, lineWidth: task.isCompleted ? 0 : 2)
            )
        }
        .padding(.vertical, 5)
    }
    
    
    
    //يخزن التساكز بس م فهمته
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
}



















struct Task: Identifiable, Codable {
    var id = UUID()
    var time: String
    var name: String
    var isCompleted: Bool
    var frequency: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PerCheck()
    }
}
