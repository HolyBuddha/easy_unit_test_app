package com.example.easy_unit_test_app

import android.appwidget.AppWidgetManager
//import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.content.SharedPreferences
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent
/**
 * Implementation of App Widget functionality.
 */
class UnitAppWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.unit_app_widget).apply {
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)
     
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
            //updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

// internal fun updateAppWidget(
//     context: Context,
//     appWidgetManager: AppWidgetManager,
//     appWidgetId: Int
// ) {
//     val widgetText = context.getString(R.string.appwidget_text)
//     // Construct the RemoteViews object
//     // val views = RemoteViews(context.packageName, R.layout.unit_app_widget)
//     views.setTextViewText(R.id.appwidget_text, widgetText)

//     // Instruct the widget manager to update the widget
    
// }