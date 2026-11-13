
package com.example.flutter_aula07_widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class MeuHomeWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {

            val dados = HomeWidgetPlugin.getData(context)

            val texto = dados.getString(
                "chave_texto",
                "Minha Ideia"
            )

            val views = RemoteViews(
                context.packageName,
                R.layout.meu_home_widget
            )

            views.setTextViewText(
                R.id.widget_texto,
                texto
            )

            appWidgetManager.updateAppWidget(
                appWidgetId,
                views
            )
        }
    }
}
