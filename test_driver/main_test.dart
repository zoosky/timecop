import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/screenshots.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end test', () {
    FlutterDriver driver;
    final config = Config();

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if(driver != null) await driver.close();
    });

    test('take screenshots', () async {
      // take a screenshot of the dashboard
      SerializableFinder descriptionField = find.byValueKey("descriptionField");

      await driver.waitFor(descriptionField);
      await screenshot(driver, config, '01 dashboard');

      // then the timer details page
      //String appDevelopmentText = await driver.requestData("app-development");
      //SerializableFinder timerEdit = find.text(appDevelopmentText);
      SerializableFinder timerEdit = find.byValueKey("stoppedTimer-42");
      await driver.waitFor(timerEdit);
      await driver.tap(timerEdit);
      SerializableFinder saveDetails = find.byValueKey("saveDetails");
      await driver.waitFor(saveDetails);
      await driver.waitUntilNoTransientCallbacks();
      await screenshot(driver, config, '02 editor');

      // then the projects page
      SerializableFinder closeButton = find.byType("CloseButton");
      await driver.waitFor(closeButton);
      await driver.tap(closeButton);
      SerializableFinder menuButton = find.byValueKey("menuButton");
      await driver.waitFor(menuButton);
      await driver.tap(menuButton);
      SerializableFinder menuProjects = find.byValueKey("menuProjects");
      await driver.waitFor(menuProjects);
      await driver.tap(menuProjects);
      SerializableFinder addProject = find.byValueKey("addProject");
      await driver.waitFor(addProject);
      await driver.waitUntilNoTransientCallbacks();
      await screenshot(driver, config, '03 projects');

      // then reports pages
      SerializableFinder backButton = find.byType("BackButton");
      await driver.waitFor(backButton);
      await driver.tap(backButton);
      await driver.waitFor(menuButton);
      await driver.tap(menuButton);
      SerializableFinder menuReports = find.byValueKey("menuReports");
      await driver.waitFor(menuReports);
      await driver.tap(menuReports);
      SerializableFinder projectBreakdown = find.byValueKey("projectBreakdown");
      await driver.waitFor(projectBreakdown);
      await screenshot(driver, config, '04a projectBreakdown');

      await driver.scroll(projectBreakdown, -300, 0, Duration(milliseconds: 500));
      SerializableFinder weeklyTotals = find.byValueKey("weeklyTotals");
      await driver.waitFor(weeklyTotals);
      await driver.waitUntilNoTransientCallbacks();
      await screenshot(driver, config, '04b weeklyTotals');

      await driver.scroll(weeklyTotals, -300, 0, Duration(milliseconds: 500));
      SerializableFinder weekdayAverages = find.byValueKey("weekdayAverages");
      await driver.waitFor(weekdayAverages);
      await driver.waitUntilNoTransientCallbacks();
      await screenshot(driver, config, '04c weekdayAverages');

      // then the export page
      await driver.waitFor(backButton);
      await driver.tap(backButton);
      await driver.waitFor(menuButton);
      await driver.tap(menuButton);
      SerializableFinder menuExport = find.byValueKey("menuExport");
      await driver.waitFor(menuExport);
      await driver.tap(menuExport);
      SerializableFinder optionColumns = find.byValueKey("optionColumns");
      await driver.waitFor(optionColumns);
      await driver.tap(optionColumns);
      await driver.waitUntilNoTransientCallbacks();
      await screenshot(driver, config, '05 export');
    }, timeout: Timeout(Duration(seconds: 30)));
  });
}
