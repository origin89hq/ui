package com.origin89.ui
import org.json.JSONArray
import org.junit.Assert.assertEquals
import org.junit.Test
class ReadingTest {
    @Test fun sharedFixtures() {
        val source = requireNotNull(javaClass.getResourceAsStream("/readings.json")).bufferedReader().use { it.readText() }
        val fixtures = JSONArray(source)
        for (index in 0 until fixtures.length()) {
            val fixture = fixtures.getJSONObject(index)
            val reading = fixture.getJSONObject("reading")
            val state = when (reading.getString("state")) {
                "current" -> ReadingValue.Current(reading.getDouble("value"), reading.getString("unit"))
                "stale" -> ReadingValue.Stale(reading.getDouble("value"), reading.getString("unit"), reading.getString("age"))
                else -> ReadingValue.Unknown
            }
            assertEquals(fixture.getString("expected"), state.description())
        }
    }
    @Test fun nonFiniteIsUnknown() {
        for (value in listOf(Double.NaN, Double.POSITIVE_INFINITY, Double.NEGATIVE_INFINITY)) {
            assertEquals("Unknown", ReadingValue.Current(value, "W").description())
            assertEquals("Unknown", ReadingValue.Stale(value, "W", "12 min ago").description())
        }
    }
}
