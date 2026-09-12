type EquipmentKind = "solar" | "generator" | "cottage" | "battery" | "mining" | "telecom";

// Generic equipment drawings for the app concept, not model-specific hardware.
export function EquipmentIllustration({ kind }: { kind: EquipmentKind }) {
  return (
    <svg
      className={`equipment-drawing equipment-${kind}`}
      viewBox="0 0 120 84"
      aria-hidden="true"
      focusable="false"
    >
      <path className="equipment-shadow" d="M12 68L73 50L115 69L55 83Z" />
      {kind === "solar" && (
        <>
          <path className="equipment-edge" d="M33 43V67L40 70V43M86 30V57L93 59V29M36 66L91 51" />
          <path className="equipment-side" d="M18 24L44 55L108 36V41L44 60L18 29Z" />
          <path className="equipment-panel" d="M18 24L82 6L108 36L44 55Z" />
          <path
            className="equipment-panel-grid"
            d="M34 19L60 50M50 15L76 45M66 10L92 40M27 34L91 16M36 44L100 26"
          />
        </>
      )}
      {kind === "generator" && (
        <>
          <path className="equipment-side" d="M20 29L57 48V75L20 57Z" />
          <path className="equipment-face" d="M57 48L105 32V60L57 75Z" />
          <path className="equipment-top" d="M20 29L69 12L105 32L57 48Z" />
          <path
            className="equipment-edge"
            d="M26 40L48 51M26 45L48 56M26 50L48 61M65 53L93 44M65 58L93 49M65 63L93 54M26 59V65M96 64V70"
          />
          <path className="equipment-panel" d="M68 22L77 19L86 24L77 27Z" />
          <path className="equipment-edge" d="M88 23V15L93 13V23" />
        </>
      )}
      {kind === "cottage" && (
        <>
          <path className="equipment-timber" d="M22 33L52 17L80 33V68H22Z" />
          <path className="equipment-side" d="M80 33L106 20V55L80 68Z" />
          <path className="equipment-panel" d="M52 17L77 4L109 20L80 35Z" />
          <path className="equipment-edge" d="M18 35L52 15L83 34M77 4L109 20" />

          <path
            className="equipment-edge"
            d="M24 37H72M24 41H72M24 46H72M24 51H72M24 57H72M24 62H72M35 43V54M30 49H41M52 66H62"
          />
          <path
            className="equipment-window"
            d="M30 43H41V54H30ZM50 39H64V68H50ZM87 39L98 34V46L87 51Z"
          />
          <path className="equipment-edge" d="M35 43V54M30 49H41" />
          <path className="equipment-top" d="M17 68H80L92 75H26Z" />
          <path
            className="equipment-edge"
            d="M18 58V68M29 58V73M73 58V73M19 59H73M30 76H79M34 80H83"
          />
          <path className="equipment-side" d="M87 16V5L94 3V20Z" />
        </>
      )}
      {kind === "mining" && (
        <>
          <path className="equipment-face" d="M15 37L56 47V72L15 61Z" />
          <path className="equipment-side" d="M56 47L91 32V58L56 72Z" />
          <path className="equipment-top" d="M12 35L48 19L94 31L56 49Z" />
          <path
            className="equipment-edge"
            d="M22 44L46 50V65L22 59ZM26 46V60M31 48V62M37 49V63M43 51V64M62 51L81 43M62 56L81 48M62 61L81 53"
          />
          <path className="equipment-face" d="M84 56L99 50L113 57V70L98 77L84 69Z" />
          <path className="equipment-edge" d="M84 57L98 64L113 57M98 64V77M93 53V44L85 40V29" />
          <path className="equipment-panel" d="M66 35L73 32L82 35L75 38Z" />
        </>
      )}
      {kind === "telecom" && (
        <>
          <path className="equipment-face" d="M14 51L50 62V81L14 69Z" />
          <path className="equipment-side" d="M50 62L80 49V68L50 81Z" />
          <path className="equipment-top" d="M14 51L44 38L80 49L50 62Z" />
          <path
            className="equipment-edge"
            d="M21 57L33 61V74M58 65L70 60M58 69L70 64M58 73L70 68M85 9L76 65M85 9L95 59M80 33H89M79 42H91M78 51H93M81 24L91 42L78 51L95 59"
          />
          <path className="equipment-face" d="M71 16L77 14V29L71 31ZM93 12L99 14V29L93 27Z" />
          <path className="equipment-edge" d="M77 19L85 21L93 17M85 9V3M80 63L97 69" />
          <path className="equipment-panel" d="M42 46L48 43L58 46L52 49Z" />
        </>
      )}
      {kind === "battery" && (
        <>
          <path className="equipment-side" d="M33 17L54 28V77L33 65Z" />
          <path className="equipment-face" d="M54 28L87 17V65L54 77Z" />
          <path className="equipment-top" d="M33 17L66 6L87 17L54 28Z" />
          <path
            className="equipment-edge"
            d="M60 34L81 27V60L60 67ZM37 29L47 34M37 34L47 39M37 39L47 44"
          />
          <path
            className="equipment-panel"
            d="M65 39L76 35V40L65 44ZM65 47L76 43V48L65 52ZM65 55L76 51V56L65 60Z"
          />
        </>
      )}
    </svg>
  );
}
