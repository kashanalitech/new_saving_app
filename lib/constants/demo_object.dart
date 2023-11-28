// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/models.dart';
// import '../objectbox.g.dart';
// import 'package:jiffy/jiffy.dart';

// /// Provides access to the ObjectBox Store throughout the app.
// ///
// /// Create this in the apps main function.
// class ObjectBox {
//   late final Store store;

//   late final Box<Milestone> milestoneBox;
//   late final Box<WeeklyMonthlySaving> weeklyMonthlySavingBox;
//   late final Box<SavingSheet> savingSheetBox;
//   late final Stream<Query<SavingSheet>> savingSheetStream;

//   ObjectBox._create(this.store) {
//     milestoneBox = Box<Milestone>(store);
//     weeklyMonthlySavingBox = Box<WeeklyMonthlySaving>(store);
//     savingSheetBox = Box<SavingSheet>(store);
//     final qBuilderSavings = savingSheetBox.query()..order(SavingSheet_.date);
//     savingSheetStream = qBuilderSavings.watch(triggerImmediately: true);
//   }

//   /// Create an instance of ObjectBox to use throughout the app.
//   static Future<ObjectBox> create() async {
//     // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
//     final store = await openStore();
//     return ObjectBox._create(store);
//   }

//   void manuallyEnded(int savingSheetId) {
//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((updatedSavingSheet) {
//       // SavingSheet updateSavings = SavingSheet(status: savingSheet.status);
//       updatedSavingSheet.status = 2;
//       savingSheetBox.put(updatedSavingSheet);

//       subscription.cancel();
//     });
//   }

//   void autoEndedSheets() {
//     final subscription = getSavingSheets().listen(null);
//     subscription.onData((savingSheets) {
//       subscription.cancel();
//       final today = Jiffy.parseFromDateTime(DateTime.now());
//       for (int i = 0; i <= savingSheets.length - 1; i++) {

//         var savingSheetsData = savingSheets[i];
//         if (savingSheetsData.status != 2 && savingSheetsData.status != 1) {
//           final dateOfCompletion =
//               Jiffy.parseFromDateTime(savingSheetsData.dateOfCompletion!);

//           final diffInHours = dateOfCompletion.diff(today, unit: Unit.hour);
//           if (diffInHours <= 0) {
//             // calculate average savings
//             var averageSavings = 0.0;
//             var barellSavings = 0.0;

//             // get all weekly savings
//             // get all weekly savings
//             var weeklySavings = 0.0;
//             var weeklySavingsMultiplyByWeeks = 0.0;
//             for (var i = 0;
//                 i < savingSheetsData.weeklyMonthlySaving.length;
//                 i++) {
//               weeklySavings = weeklySavings +
//                   savingSheetsData.weeklyMonthlySaving[i].amount;

//               weeklySavingsMultiplyByWeeks = weeklySavingsMultiplyByWeeks +
//                   (savingSheetsData.weeklyMonthlySaving[i].amount *
//                       savingSheetsData.noOfTimeFrame);
//             }

//             averageSavings = weeklySavings / savingSheetsData.noOfTimeFrame;

//             barellSavings =
//                 weeklySavingsMultiplyByWeeks / savingSheetsData.noOfTimeFrame;

//             savingSheetsData.averageSaving = averageSavings;
//             savingSheetsData.barellSaving = barellSavings;
//             savingSheetsData.activeWeek = savingSheetsData.noOfTimeFrame;
//             savingSheetsData.status = 1;

//             savingSheetBox.put(savingSheetsData);
//           }
//         }
//       }
//     });
//   }

//   void activeWeek(int savingSheetId) {
//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((savingSheet) {
//       final jiffy1 = Jiffy.parseFromDateTime(savingSheet.startingDate!);
//       final jiffy2 = Jiffy.parseFromDateTime(DateTime.now());

//       // Calculate the difference between the two Jiffy instances in days
//       final diffInDays = jiffy2.diff(jiffy1, unit: Unit.day) + 1;
//       final diffInWeeks = jiffy2.diff(jiffy1, unit: Unit.week) + 1;
//       final diffInMonths = jiffy2.diff(jiffy1, unit: Unit.month) + 1;

//       print('Difference in days: $diffInDays');
//       print('Difference in weeks: $diffInWeeks');
//       print('Difference in months: $diffInMonths');

//       if (savingSheet.isWeekly) {
//         savingSheet.activeWeek = diffInWeeks.toInt();
//       } else {
//         savingSheet.activeWeek = diffInMonths.toInt();
//       }

//       // calculate average savings
//       var averageSavings = 0.0;
//       var barellSavings = 0.0;

//       // get all weekly savings
//       // get all weekly savings
//       var weeklySavings = 0.0;
//       var weeklySavingsMultiplyByWeeks = 0.0;
//       for (var i = 0; i < savingSheet.weeklyMonthlySaving.length; i++) {
//         weeklySavings =
//             weeklySavings + savingSheet.weeklyMonthlySaving[i].amount;

//         weeklySavingsMultiplyByWeeks = weeklySavingsMultiplyByWeeks +
//             (savingSheet.weeklyMonthlySaving[i].amount *
//                 savingSheet.noOfTimeFrame);
//       }

//       averageSavings = weeklySavings / savingSheet.activeWeek;

//       barellSavings = weeklySavingsMultiplyByWeeks / savingSheet.activeWeek;

//       savingSheet.averageSaving = averageSavings;
//       savingSheet.barellSaving = barellSavings;

//       savingSheetBox.put(savingSheet);
//       debugPrint("Updated Saving sheet: ${savingSheet.date}");

//       subscription.cancel();
//     });
//   }

//   void update(int savingSheetId) {
//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((savingSheet) {
//       // calculate average savings
//       var averageSavings = 0.0;
//       var barellSavings = 0.0;

//       var weeklySavings = 0.0;
//       var weeklySavingsMultiplyByWeeks = 0.0;
//       for (var i = 0; i < savingSheet.weeklyMonthlySaving.length; i++) {
//         weeklySavings =
//             weeklySavings + savingSheet.weeklyMonthlySaving[i].amount;

//         weeklySavingsMultiplyByWeeks = weeklySavingsMultiplyByWeeks +
//             (savingSheet.weeklyMonthlySaving[i].amount *
//                 savingSheet.noOfTimeFrame);
//       }

//       averageSavings = weeklySavings / savingSheet.activeWeek;

//       barellSavings = weeklySavingsMultiplyByWeeks / savingSheet.activeWeek;

//       savingSheet.averageSaving = averageSavings;
//       savingSheet.barellSaving = barellSavings;

//       savingSheetBox.put(savingSheet);
//       subscription.cancel();
//     });
//   }

//   // void updateMile(int savingSheetId, int milestoneId, ) {
//   //   Query<SavingSheet> query =
//   //   savingSheetBox.query(SavingSheet_.id.equals(savingSheetId)).build();
//   //   SavingSheet savingSheet = query.find()[0];
//   //
//   //   Query<Milestone> query2 = milestoneBox.query(Milestone_.id.equals(milestoneId)).build();
//   //   Milestone milestone = query2.find()[0];
//   //   var mileAmount = 0;
//   //   for (var i = 0; i < savingSheet.milestones.length; i++) {
//   //     mileAmount =  savingSheet.milestones[i].milestoneAmount;
//   //   }
//   //   milestone.milestoneAmount = mileAmount;
//   //   // savingSheetBox.put(savingSheet);
//   //   milestoneBox.put(milestone);
//   //   debugPrint("Updated Saving sheet: ${savingSheet.date},,,,,,,,${milestone.milestoneAmount}");
//   // }
//   void updateMilestones(int amount, int savingSheetId, int milestoneId,) {
//     Query<SavingSheet> query =
//         savingSheetBox.query(SavingSheet_.id.equals(savingSheetId)).build();
//     SavingSheet savingSheet = query.find()[0];

//     Query<Milestone> query2 =
//         milestoneBox.query(Milestone_.id.equals(milestoneId)).build();
//     Milestone milestone = query2.find()[0];

//     Milestone updateMilestone = Milestone(
//       milestoneAmount: amount,
//     );
//     savingSheet.milestones.add(updateMilestone);
//     var mileAmount = 0;
//     for (var i = 0; i < savingSheet.milestones.length; i++) {
//       mileAmount = savingSheet.milestones[i].milestoneAmount;
//     }
//     milestone.milestoneAmount = mileAmount;
//     // savingSheetBox.put(savingSheet);
//     milestoneBox.put(milestone);
//     debugPrint(
//         "Updated Saving sheet: ${savingSheet.date},,,,,,,,${milestone.milestoneAmount}");
//   }

//   void updateName(String Rename,int savingSheetId){
//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((updatedSavingSheet) {
//     updatedSavingSheet.name = Rename;
//     savingSheetBox.put(updatedSavingSheet);
//     subscription.cancel();
//     });
//   }

//   void istoggle(bool isToggle, int savingSheetId) {
//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((updatedSavingSheet) {
//       // SavingSheet updateSavings = SavingSheet(status: savingSheet.status);
//       updatedSavingSheet.isToggle = true;
//       savingSheetBox.put(updatedSavingSheet);

//       subscription.cancel();
//     });
//   }

//   void updateAdditionalTime(int weekMonths, int savingSheetId) {
//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((updatedSavingSheet) {
//       // SavingSheet updateSavings = SavingSheet(status: savingSheet.status);
//       // updatedSavingSheet.status = 2;
//       var noOfTimeframe = 0;
//       noOfTimeframe = weekMonths + updatedSavingSheet.noOfTimeFrame;
//       updatedSavingSheet.noOfTimeFrame = noOfTimeframe;

//       DateTime? dateOfCompletion = DateTime.now();
//       dateOfCompletion = updatedSavingSheet.dateOfCompletion;

//       if(weekMonths>0){
//         updatedSavingSheet.status=0;
//       }

//       if (updatedSavingSheet.isWeekly) {
//         dateOfCompletion = Jiffy.parseFromDateTime(dateOfCompletion!)
//             .add(weeks: weekMonths)
//             .dateTime;
//       } else {
//         dateOfCompletion = Jiffy.parseFromDateTime(dateOfCompletion!)
//             .add(months: weekMonths)
//             .dateTime;
//       }

//       updatedSavingSheet.dateOfCompletion = dateOfCompletion;
//       savingSheetBox.put(updatedSavingSheet);
//       subscription.cancel();
//     });

//     // Query<SavingSheet> query =
//     //     savingSheetBox.query(SavingSheet_.id.equals(savingSheetId)).build();
//     // SavingSheet savingSheet = query.find()[0];
//     // SavingSheet updateAddtionalTime = SavingSheet(noOfTimeFrame: amout);
//     // savingSheetBox.put(updateAddtionalTime);
//     // var noOfTimeframe = 0;
//     // noOfTimeframe = amout + savingSheet.noOfTimeFrame;
//     // savingSheet.noOfTimeFrame = noOfTimeframe;
//     //
//     // DateTime? dateOfCompletion = DateTime.now();
//     // dateOfCompletion = savingSheet.dateOfCompletion;
//     //
//     // if (savingSheet.isWeekly = true) {
//     //   dateOfCompletion =
//     //       Jiffy.parseFromDateTime(dateOfCompletion!).add(weeks: amout).dateTime;
//     // } else {
//     //   dateOfCompletion = Jiffy.parseFromDateTime(dateOfCompletion!)
//     //       .add(months: amout)
//     //       .dateTime;
//     // }
//     //
//     // savingSheet.dateOfCompletion = dateOfCompletion;
//     // savingSheetBox.put(savingSheet);
//   }

//   void updateEditSavings(double amount, int savingSheetId, int weeklyMonthlyId) {
//     Query<SavingSheet> query =
//         savingSheetBox.query(SavingSheet_.id.equals(savingSheetId)).build();
//     SavingSheet savingSheet = query.find()[0];

//     Query<WeeklyMonthlySaving> query2 = weeklyMonthlySavingBox
//         .query(WeeklyMonthlySaving_.id.equals(weeklyMonthlyId))
//         .build();
//     WeeklyMonthlySaving weeklyMonthlySaving = query2.find()[0];

//     WeeklyMonthlySaving updateWeeklyMonthlySaving =
//         WeeklyMonthlySaving(amount, DateTime.timestamp(), 1);
//     savingSheet.weeklyMonthlySaving.add(updateWeeklyMonthlySaving);


//     var mileAmount = 0.0;
//     // var updateweeklysaving = 0.0;
//     for (var i = 0; i < savingSheet.weeklyMonthlySaving.length; i++) {
//       mileAmount = savingSheet.weeklyMonthlySaving[i].amount;
//       // updateweeklysaving = updateweeklysaving +  savingSheet.weeklyMonthlySaving[i].amount;
//     }
//     weeklyMonthlySaving.amount = mileAmount;
//     // averageSavings = mileAmount / savingSheet.activeWeek;
//     // barellSavings = averageSavings * savingSheet.noOfTimeFrame;
//     // savingSheet.averageSaving = averageSavings;
//     // savingSheet.barellSaving = barellSavings;
//     weeklyMonthlySavingBox.put(weeklyMonthlySaving);
//     // savingSheetBox.put(savingSheet);

//     debugPrint(
//         "Updated EditSavings: ${savingSheet.date},${savingSheet.weeklyMonthlySaving}");
//   }

//   void updateSavingAmount(double amount, int savingSheetId) {
//     Query<SavingSheet> query =
//         savingSheetBox.query(SavingSheet_.id.equals(savingSheetId)).build();
//     SavingSheet savingSheet = query.find()[0];
//     WeeklyMonthlySaving weeklyMonthlySaving =
//         WeeklyMonthlySaving(amount, DateTime.now(), savingSheet.activeWeek);
//     savingSheet.weeklyMonthlySaving.add(weeklyMonthlySaving);

//     // calculate average savings
//     var averageSavings = 0.0;
//     var barellSavings = 0.0;

//     // get all weekly savings
//     var weeklySavings = 0.0;
//     var weeklySavingsMultiplyByWeeks = 0.0;
//     for (var i = 0; i < savingSheet.weeklyMonthlySaving.length; i++) {
//       weeklySavings = weeklySavings + savingSheet.weeklyMonthlySaving[i].amount;

//       weeklySavingsMultiplyByWeeks = weeklySavingsMultiplyByWeeks +
//           (savingSheet.weeklyMonthlySaving[i].amount *
//               savingSheet.noOfTimeFrame);
//     }

//     averageSavings = weeklySavings / savingSheet.activeWeek;

//     barellSavings = weeklySavingsMultiplyByWeeks / savingSheet.activeWeek;

//     savingSheet.averageSaving = averageSavings;
//     savingSheet.barellSaving = barellSavings;


//     for (var j = 0; j < savingSheet.milestones.length; j++) {
//       if (savingSheet.averageSaving >= savingSheet.milestones[j].milestoneAmount) {
//         savingSheet.milestones[j].isCompleted =true;
//         milestoneBox.put(savingSheet.milestones[j]);
//         print(savingSheet.milestones[j].milestoneAmount);
//       }
//     }


//     savingSheetBox.put(savingSheet);
//     debugPrint("Updated Saving sheet: ${savingSheet.date}");
//   }

//   void addMilestone(int milestoneAmount, int savingSheetId, {bool isCompleted = false}) {
//     Milestone newMilestone =
//         Milestone(milestoneAmount: milestoneAmount, isCompleted: isCompleted);

//     final subscription = getSavingSheet(savingSheetId).listen(null);
//     subscription.onData((updatedSheet) {
//       updatedSheet.milestones.add(newMilestone);
//       int savintSheetId = savingSheetBox.put(updatedSheet);
//       debugPrint(
//           "Added Task: ${newMilestone.milestoneAmount} in event: ${savingSheetBox.get(savintSheetId)?.date}");

//       subscription.cancel();
//     });
//   }

//   // void addWeeklyMonthlySaving(double amount, DateTime? dateTime, int activeWeekMonth) {
//   //   WeeklyMonthlySaving newWeeklyMonthlySaving =
//   //       WeeklyMonthlySaving(amount, DateTime.now(), activeWeekMonth);
//   //
//   //   weeklyMonthlySavingBox.put(newWeeklyMonthlySaving);
//   //   debugPrint("Added Event: ${newWeeklyMonthlySaving.dateTime}");
//   // }

//   int addSavingSheet(
//     String name,
//     String currency,
//     bool isWeekly,
//     int noOfTimeFrame,
//     DateTime dateOfCompletion,
//     String notifications,
//     int barellSaving,
//     int averageSaving,

//     // DateTime date,
//     DateTime startingDate,
//     int activeWeek,
//   ) {
//     SavingSheet newSavingSheet = SavingSheet(
//       name: name,
//       currency: currency,
//       isWeekly: isWeekly,
//       noOfTimeFrame: noOfTimeFrame,
//       // date: dateOfCompletion,
//       dateOfCompletion: dateOfCompletion,
//       notificationReminderDay: notifications,
//       barellSaving: 0,
//       averageSaving: 0,
//       // date: DateTime.now(),
//       startingDate: startingDate,
//       // startingDate: DateTime.now(),
//       activeWeek: activeWeek,
//     );
//     return savingSheetBox.put(newSavingSheet);
//   }

//   Stream<List<Milestone>> getMilstones(int savingSheetId) {
//     final builder = milestoneBox.query()
//       ..order(Milestone_.id, flags: Order.descending);
//     builder.link(Milestone_.savingSheet, SavingSheet_.id.equals(savingSheetId));
//     return builder.watch(triggerImmediately: true).map((query) => query.find());
//   }

//   Stream<List<Milestone>> getMilstonesc() {
//     final builder = milestoneBox.query()
//       ..order(Milestone_.id, flags: Order.descending);
//     // builder.link(Milestone_.savingSheet, SavingSheet_.id.equals(savingSheetId));
//     return builder.watch(triggerImmediately: true).map((query) => query.find());
//   }

//   Stream<List<WeeklyMonthlySaving>> getWeeklyMonthlySavingsListByWeek(int savingSheetId, int activeWeek) {
//     // final subscription = getSavingSheet(savingSheetId).listen(null);
//     // subscription.onData((savingSheet) {
//     //   this.savingSheet=savingSheet;
//     //   subscription.cancel();
//     // });
//     //

//     final builder = weeklyMonthlySavingBox
//         .query(WeeklyMonthlySaving_.activeWeekMonth.equals(activeWeek))
//       ..order(WeeklyMonthlySaving_.id, flags: Order.descending);
//     builder.link(WeeklyMonthlySaving_.savingSheet,
//         SavingSheet_.id.equals(savingSheetId));
//     return builder.watch(triggerImmediately: true).map((query) => query.find());
//   }

//   Stream<List<WeeklyMonthlySaving>> getWeeklyMonthlySavingsList(int savingSheetId) {
//     // final subscription = getSavingSheet(savingSheetId).listen(null);
//     // subscription.onData((savingSheet) {
//     //   this.savingSheet=savingSheet;
//     //   subscription.cancel();
//     // });
//     //

//     final builder = weeklyMonthlySavingBox.query()
//       ..order(WeeklyMonthlySaving_.id, flags: Order.descending);
//     builder.link(WeeklyMonthlySaving_.savingSheet,
//         SavingSheet_.id.equals(savingSheetId));
//     return builder.watch(triggerImmediately: true).map((query) => query.find());
//   }

//   Stream<List<SavingSheet>> getSavingSheets() {
//     final builder = savingSheetBox.query()
//       ..order(SavingSheet_.id, flags: Order.descending);
//     // builder.link(WeeklyMonthlySaving_.savingSheet, SavingSheet_.id.equals(savingSheetid));
//     return builder.watch(triggerImmediately: true).map((query) => query.find());
//   }

//   Stream<SavingSheet> getSavingSheet(int savingSheetid) {
//     final builder = savingSheetBox.query(SavingSheet_.id.equals(savingSheetid))
//       ..order(SavingSheet_.id, flags: Order.descending);
//     return builder
//         .watch(triggerImmediately: true)
//         .map((query) => query.find()[0]);
//   }

// // Stream<List<Task>> getTasksOfEvent(int eventId) {
// //   final builder = taskBox.query()..order(Task_.id, flags: Order.descending);
// //   builder.link(Task_.event, Event_.id.equals(eventId));
// //   return builder.watch(triggerImmediately: true).map((query) => query.find());
// // }
// }
