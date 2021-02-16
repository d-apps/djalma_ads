## [0.1.8] - Fixed Future methods returning dynamic to void

## [0.1.7] - Fixed rea dme.

## [0.1.6] - Added coin icon as an example to increase when rewarded video reward the user.

## [0.0.6] - Fix and update.

* - Update firebase_admob plugin to the latest version.

  - Fixed error updating to classpath("com.android.tools.build:gradle:3.5.4"):
   * What went wrong:
   Execution failed for task ':app:processDebugResources'.
   > A failure occurred while executing com.android.build.gradle.internal.tasks.Workers$ActionFacade
   > Android resource linking failed
   C:\Users\Djalma\.gradle\caches\transforms-2\files-2.1\ecceec9b0a83bdc57a95097902237691\play-services-ads-lite-19.6.0\AndroidManifest.xml:27:5-38:15: AAPT: error: unexpected element <queries> found in <manifest>.
   - Added Firebase Project to the project, since it is mandatory now.
   - Added firebase_core plugin since it is mandatory now and initialized on main.dart
   - Updated Ads.dart class, removed code from non firebase_admob plugins.
   - Added method getMargin to set the margin of the screen you need to show smart banner.
   - Removed Native Ad.

## [0.0.5] - Update.

* Changed EdgeInsets default parameter to EdgeInsets.all(0) on padding for Native Ads.

## [0.0.4] - Update.

* Added option to add Test Device ID and Testing App Open Ads (Not available yet).
* Update project for null safety.
* Removed loadBanner method, showBanner method load and show the banner.

## [0.0.3] - Update.

* Updated README.

## [0.0.2] - Update.

* Updated README.

## [0.0.1] - Release.

* Initial release.
