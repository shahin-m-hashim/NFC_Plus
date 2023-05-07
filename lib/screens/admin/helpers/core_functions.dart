double getProgressPercentage() {
  double dailyIncomeLimit = 1000.0; // Set your daily income limit here
  double currentDayIncome = getCurrentDayIncome().toDouble();
  double progress = currentDayIncome / dailyIncomeLimit;
  return progress.clamp(0.0, 1.0); // Limit the progress between 0.0 and 1.0
}

int getCurrentDayIncome() {
  int currentDayIncome = 370;
  return currentDayIncome;
}

int getCurrentWeekIncome() {
  int currentWeekIncome = 800;
  return currentWeekIncome;
}
