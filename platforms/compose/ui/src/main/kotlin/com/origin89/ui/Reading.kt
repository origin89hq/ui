package com.origin89.ui

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import java.math.BigDecimal

sealed interface ReadingValue {
    data class Current(val value: Double, val unit: String) : ReadingValue
    data class Stale(val value: Double, val unit: String, val age: String) : ReadingValue
    data object Unknown : ReadingValue
}
fun ReadingValue.description(): String {
    fun number(value: Double, unit: String) = "${BigDecimal.valueOf(value).stripTrailingZeros().toPlainString()} $unit".trim()
    return when (this) {
        is ReadingValue.Current -> if (value.isFinite()) number(value, unit) else "Unknown"
        is ReadingValue.Stale -> if (value.isFinite()) "${number(value, unit)} · Last known · $age" else "Unknown"
        ReadingValue.Unknown -> "Unknown"
    }
}
@Composable fun Origin89Reading(label: String, reading: ReadingValue, modifier: Modifier = Modifier) {
    val palette = if (isSystemInDarkTheme()) Origin89Tokens.dark else Origin89Tokens.light
    Column(modifier.fillMaxWidth().semantics(mergeDescendants = true) {}.padding(vertical = 16.dp), verticalArrangement = Arrangement.spacedBy(6.dp)) {
        Text(label, color = palette.muted, fontSize = 14.sp, fontFamily = FontFamily(Font(R.font.inter_tight_regular)))
        Text(reading.description(), color = palette.fg, fontSize = 24.sp, fontFamily = FontFamily(Font(R.font.inter_tight_semibold)))
        HorizontalDivider(color = palette.line)
    }
}
@Preview(showBackground = true)
@Composable private fun ReadingPreview() {
    Column(Modifier.padding(16.dp)) {
        Origin89Reading("Battery", ReadingValue.Current(76.0, "%"))
        Origin89Reading("Solar", ReadingValue.Current(0.0, "kW"))
        Origin89Reading("Battery", ReadingValue.Stale(78.0, "%", "12 min ago"))
        Origin89Reading("Solar", ReadingValue.Unknown)
    }
}
