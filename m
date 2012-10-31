From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/26] ACPICA: Update local C library module comments for ASCII table
Date: Wed, 31 Oct 2012 10:26:47 +0800
Message-ID: <325ec55d2154216fe63680fea7ecd0f15027e92b.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15971 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab2JaC1E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:04 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Improve the commenting of the table.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utclib.c |  261 +++++++++++++++++++++---------------------
 1 file changed, 131 insertions(+), 130 deletions(-)

diff --git a/drivers/acpi/acpica/utclib.c b/drivers/acpi/acpica/utclib.c
index f887f93..19ea4755 100644
--- a/drivers/acpi/acpica/utclib.c
+++ b/drivers/acpi/acpica/utclib.c
@@ -46,7 +46,7 @@
 
 /*
  * These implementations of standard C Library routines can optionally be
- * used if a C library is not available.  In general, they are less efficient
+ * used if a C library is not available. In general, they are less efficient
  * than an inline or assembly implementation
  */
 
@@ -606,134 +606,134 @@ int acpi_ut_to_lower(int c)
  ******************************************************************************/
 
 const u8 _acpi_ctype[257] = {
-	_ACPI_CN,		/* 0x0      0.     */
-	_ACPI_CN,		/* 0x1      1.     */
-	_ACPI_CN,		/* 0x2      2.     */
-	_ACPI_CN,		/* 0x3      3.     */
-	_ACPI_CN,		/* 0x4      4.     */
-	_ACPI_CN,		/* 0x5      5.     */
-	_ACPI_CN,		/* 0x6      6.     */
-	_ACPI_CN,		/* 0x7      7.     */
-	_ACPI_CN,		/* 0x8      8.     */
-	_ACPI_CN | _ACPI_SP,	/* 0x9      9.     */
-	_ACPI_CN | _ACPI_SP,	/* 0xA     10.     */
-	_ACPI_CN | _ACPI_SP,	/* 0xB     11.     */
-	_ACPI_CN | _ACPI_SP,	/* 0xC     12.     */
-	_ACPI_CN | _ACPI_SP,	/* 0xD     13.     */
-	_ACPI_CN,		/* 0xE     14.     */
-	_ACPI_CN,		/* 0xF     15.     */
-	_ACPI_CN,		/* 0x10    16.     */
-	_ACPI_CN,		/* 0x11    17.     */
-	_ACPI_CN,		/* 0x12    18.     */
-	_ACPI_CN,		/* 0x13    19.     */
-	_ACPI_CN,		/* 0x14    20.     */
-	_ACPI_CN,		/* 0x15    21.     */
-	_ACPI_CN,		/* 0x16    22.     */
-	_ACPI_CN,		/* 0x17    23.     */
-	_ACPI_CN,		/* 0x18    24.     */
-	_ACPI_CN,		/* 0x19    25.     */
-	_ACPI_CN,		/* 0x1A    26.     */
-	_ACPI_CN,		/* 0x1B    27.     */
-	_ACPI_CN,		/* 0x1C    28.     */
-	_ACPI_CN,		/* 0x1D    29.     */
-	_ACPI_CN,		/* 0x1E    30.     */
-	_ACPI_CN,		/* 0x1F    31.     */
-	_ACPI_XS | _ACPI_SP,	/* 0x20    32. ' ' */
-	_ACPI_PU,		/* 0x21    33. '!' */
-	_ACPI_PU,		/* 0x22    34. '"' */
-	_ACPI_PU,		/* 0x23    35. '#' */
-	_ACPI_PU,		/* 0x24    36. '$' */
-	_ACPI_PU,		/* 0x25    37. '%' */
-	_ACPI_PU,		/* 0x26    38. '&' */
-	_ACPI_PU,		/* 0x27    39. ''' */
-	_ACPI_PU,		/* 0x28    40. '(' */
-	_ACPI_PU,		/* 0x29    41. ')' */
-	_ACPI_PU,		/* 0x2A    42. '*' */
-	_ACPI_PU,		/* 0x2B    43. '+' */
-	_ACPI_PU,		/* 0x2C    44. ',' */
-	_ACPI_PU,		/* 0x2D    45. '-' */
-	_ACPI_PU,		/* 0x2E    46. '.' */
-	_ACPI_PU,		/* 0x2F    47. '/' */
-	_ACPI_XD | _ACPI_DI,	/* 0x30    48. '0' */
-	_ACPI_XD | _ACPI_DI,	/* 0x31    49. '1' */
-	_ACPI_XD | _ACPI_DI,	/* 0x32    50. '2' */
-	_ACPI_XD | _ACPI_DI,	/* 0x33    51. '3' */
-	_ACPI_XD | _ACPI_DI,	/* 0x34    52. '4' */
-	_ACPI_XD | _ACPI_DI,	/* 0x35    53. '5' */
-	_ACPI_XD | _ACPI_DI,	/* 0x36    54. '6' */
-	_ACPI_XD | _ACPI_DI,	/* 0x37    55. '7' */
-	_ACPI_XD | _ACPI_DI,	/* 0x38    56. '8' */
-	_ACPI_XD | _ACPI_DI,	/* 0x39    57. '9' */
-	_ACPI_PU,		/* 0x3A    58. ':' */
-	_ACPI_PU,		/* 0x3B    59. ';' */
-	_ACPI_PU,		/* 0x3C    60. '<' */
-	_ACPI_PU,		/* 0x3D    61. '=' */
-	_ACPI_PU,		/* 0x3E    62. '>' */
-	_ACPI_PU,		/* 0x3F    63. '?' */
-	_ACPI_PU,		/* 0x40    64. '@' */
-	_ACPI_XD | _ACPI_UP,	/* 0x41    65. 'A' */
-	_ACPI_XD | _ACPI_UP,	/* 0x42    66. 'B' */
-	_ACPI_XD | _ACPI_UP,	/* 0x43    67. 'C' */
-	_ACPI_XD | _ACPI_UP,	/* 0x44    68. 'D' */
-	_ACPI_XD | _ACPI_UP,	/* 0x45    69. 'E' */
-	_ACPI_XD | _ACPI_UP,	/* 0x46    70. 'F' */
-	_ACPI_UP,		/* 0x47    71. 'G' */
-	_ACPI_UP,		/* 0x48    72. 'H' */
-	_ACPI_UP,		/* 0x49    73. 'I' */
-	_ACPI_UP,		/* 0x4A    74. 'J' */
-	_ACPI_UP,		/* 0x4B    75. 'K' */
-	_ACPI_UP,		/* 0x4C    76. 'L' */
-	_ACPI_UP,		/* 0x4D    77. 'M' */
-	_ACPI_UP,		/* 0x4E    78. 'N' */
-	_ACPI_UP,		/* 0x4F    79. 'O' */
-	_ACPI_UP,		/* 0x50    80. 'P' */
-	_ACPI_UP,		/* 0x51    81. 'Q' */
-	_ACPI_UP,		/* 0x52    82. 'R' */
-	_ACPI_UP,		/* 0x53    83. 'S' */
-	_ACPI_UP,		/* 0x54    84. 'T' */
-	_ACPI_UP,		/* 0x55    85. 'U' */
-	_ACPI_UP,		/* 0x56    86. 'V' */
-	_ACPI_UP,		/* 0x57    87. 'W' */
-	_ACPI_UP,		/* 0x58    88. 'X' */
-	_ACPI_UP,		/* 0x59    89. 'Y' */
-	_ACPI_UP,		/* 0x5A    90. 'Z' */
-	_ACPI_PU,		/* 0x5B    91. '[' */
-	_ACPI_PU,		/* 0x5C    92. '\' */
-	_ACPI_PU,		/* 0x5D    93. ']' */
-	_ACPI_PU,		/* 0x5E    94. '^' */
-	_ACPI_PU,		/* 0x5F    95. '_' */
-	_ACPI_PU,		/* 0x60    96. '`' */
-	_ACPI_XD | _ACPI_LO,	/* 0x61    97. 'a' */
-	_ACPI_XD | _ACPI_LO,	/* 0x62    98. 'b' */
-	_ACPI_XD | _ACPI_LO,	/* 0x63    99. 'c' */
-	_ACPI_XD | _ACPI_LO,	/* 0x64   100. 'd' */
-	_ACPI_XD | _ACPI_LO,	/* 0x65   101. 'e' */
-	_ACPI_XD | _ACPI_LO,	/* 0x66   102. 'f' */
-	_ACPI_LO,		/* 0x67   103. 'g' */
-	_ACPI_LO,		/* 0x68   104. 'h' */
-	_ACPI_LO,		/* 0x69   105. 'i' */
-	_ACPI_LO,		/* 0x6A   106. 'j' */
-	_ACPI_LO,		/* 0x6B   107. 'k' */
-	_ACPI_LO,		/* 0x6C   108. 'l' */
-	_ACPI_LO,		/* 0x6D   109. 'm' */
-	_ACPI_LO,		/* 0x6E   110. 'n' */
-	_ACPI_LO,		/* 0x6F   111. 'o' */
-	_ACPI_LO,		/* 0x70   112. 'p' */
-	_ACPI_LO,		/* 0x71   113. 'q' */
-	_ACPI_LO,		/* 0x72   114. 'r' */
-	_ACPI_LO,		/* 0x73   115. 's' */
-	_ACPI_LO,		/* 0x74   116. 't' */
-	_ACPI_LO,		/* 0x75   117. 'u' */
-	_ACPI_LO,		/* 0x76   118. 'v' */
-	_ACPI_LO,		/* 0x77   119. 'w' */
-	_ACPI_LO,		/* 0x78   120. 'x' */
-	_ACPI_LO,		/* 0x79   121. 'y' */
-	_ACPI_LO,		/* 0x7A   122. 'z' */
-	_ACPI_PU,		/* 0x7B   123. '{' */
-	_ACPI_PU,		/* 0x7C   124. '|' */
-	_ACPI_PU,		/* 0x7D   125. '}' */
-	_ACPI_PU,		/* 0x7E   126. '~' */
-	_ACPI_CN,		/* 0x7F   127.     */
+	_ACPI_CN,		/* 0x00     0 NUL */
+	_ACPI_CN,		/* 0x01     1 SOH */
+	_ACPI_CN,		/* 0x02     2 STX */
+	_ACPI_CN,		/* 0x03     3 ETX */
+	_ACPI_CN,		/* 0x04     4 EOT */
+	_ACPI_CN,		/* 0x05     5 ENQ */
+	_ACPI_CN,		/* 0x06     6 ACK */
+	_ACPI_CN,		/* 0x07     7 BEL */
+	_ACPI_CN,		/* 0x08     8 BS  */
+	_ACPI_CN | _ACPI_SP,	/* 0x09     9 TAB */
+	_ACPI_CN | _ACPI_SP,	/* 0x0A    10 LF  */
+	_ACPI_CN | _ACPI_SP,	/* 0x0B    11 VT  */
+	_ACPI_CN | _ACPI_SP,	/* 0x0C    12 FF  */
+	_ACPI_CN | _ACPI_SP,	/* 0x0D    13 CR  */
+	_ACPI_CN,		/* 0x0E    14 SO  */
+	_ACPI_CN,		/* 0x0F    15 SI  */
+	_ACPI_CN,		/* 0x10    16 DLE */
+	_ACPI_CN,		/* 0x11    17 DC1 */
+	_ACPI_CN,		/* 0x12    18 DC2 */
+	_ACPI_CN,		/* 0x13    19 DC3 */
+	_ACPI_CN,		/* 0x14    20 DC4 */
+	_ACPI_CN,		/* 0x15    21 NAK */
+	_ACPI_CN,		/* 0x16    22 SYN */
+	_ACPI_CN,		/* 0x17    23 ETB */
+	_ACPI_CN,		/* 0x18    24 CAN */
+	_ACPI_CN,		/* 0x19    25 EM  */
+	_ACPI_CN,		/* 0x1A    26 SUB */
+	_ACPI_CN,		/* 0x1B    27 ESC */
+	_ACPI_CN,		/* 0x1C    28 FS  */
+	_ACPI_CN,		/* 0x1D    29 GS  */
+	_ACPI_CN,		/* 0x1E    30 RS  */
+	_ACPI_CN,		/* 0x1F    31 US  */
+	_ACPI_XS | _ACPI_SP,	/* 0x20    32 ' ' */
+	_ACPI_PU,		/* 0x21    33 '!' */
+	_ACPI_PU,		/* 0x22    34 '"' */
+	_ACPI_PU,		/* 0x23    35 '#' */
+	_ACPI_PU,		/* 0x24    36 '$' */
+	_ACPI_PU,		/* 0x25    37 '%' */
+	_ACPI_PU,		/* 0x26    38 '&' */
+	_ACPI_PU,		/* 0x27    39 ''' */
+	_ACPI_PU,		/* 0x28    40 '(' */
+	_ACPI_PU,		/* 0x29    41 ')' */
+	_ACPI_PU,		/* 0x2A    42 '*' */
+	_ACPI_PU,		/* 0x2B    43 '+' */
+	_ACPI_PU,		/* 0x2C    44 ',' */
+	_ACPI_PU,		/* 0x2D    45 '-' */
+	_ACPI_PU,		/* 0x2E    46 '.' */
+	_ACPI_PU,		/* 0x2F    47 '/' */
+	_ACPI_XD | _ACPI_DI,	/* 0x30    48 '0' */
+	_ACPI_XD | _ACPI_DI,	/* 0x31    49 '1' */
+	_ACPI_XD | _ACPI_DI,	/* 0x32    50 '2' */
+	_ACPI_XD | _ACPI_DI,	/* 0x33    51 '3' */
+	_ACPI_XD | _ACPI_DI,	/* 0x34    52 '4' */
+	_ACPI_XD | _ACPI_DI,	/* 0x35    53 '5' */
+	_ACPI_XD | _ACPI_DI,	/* 0x36    54 '6' */
+	_ACPI_XD | _ACPI_DI,	/* 0x37    55 '7' */
+	_ACPI_XD | _ACPI_DI,	/* 0x38    56 '8' */
+	_ACPI_XD | _ACPI_DI,	/* 0x39    57 '9' */
+	_ACPI_PU,		/* 0x3A    58 ':' */
+	_ACPI_PU,		/* 0x3B    59 ';' */
+	_ACPI_PU,		/* 0x3C    60 '<' */
+	_ACPI_PU,		/* 0x3D    61 '=' */
+	_ACPI_PU,		/* 0x3E    62 '>' */
+	_ACPI_PU,		/* 0x3F    63 '?' */
+	_ACPI_PU,		/* 0x40    64 '@' */
+	_ACPI_XD | _ACPI_UP,	/* 0x41    65 'A' */
+	_ACPI_XD | _ACPI_UP,	/* 0x42    66 'B' */
+	_ACPI_XD | _ACPI_UP,	/* 0x43    67 'C' */
+	_ACPI_XD | _ACPI_UP,	/* 0x44    68 'D' */
+	_ACPI_XD | _ACPI_UP,	/* 0x45    69 'E' */
+	_ACPI_XD | _ACPI_UP,	/* 0x46    70 'F' */
+	_ACPI_UP,		/* 0x47    71 'G' */
+	_ACPI_UP,		/* 0x48    72 'H' */
+	_ACPI_UP,		/* 0x49    73 'I' */
+	_ACPI_UP,		/* 0x4A    74 'J' */
+	_ACPI_UP,		/* 0x4B    75 'K' */
+	_ACPI_UP,		/* 0x4C    76 'L' */
+	_ACPI_UP,		/* 0x4D    77 'M' */
+	_ACPI_UP,		/* 0x4E    78 'N' */
+	_ACPI_UP,		/* 0x4F    79 'O' */
+	_ACPI_UP,		/* 0x50    80 'P' */
+	_ACPI_UP,		/* 0x51    81 'Q' */
+	_ACPI_UP,		/* 0x52    82 'R' */
+	_ACPI_UP,		/* 0x53    83 'S' */
+	_ACPI_UP,		/* 0x54    84 'T' */
+	_ACPI_UP,		/* 0x55    85 'U' */
+	_ACPI_UP,		/* 0x56    86 'V' */
+	_ACPI_UP,		/* 0x57    87 'W' */
+	_ACPI_UP,		/* 0x58    88 'X' */
+	_ACPI_UP,		/* 0x59    89 'Y' */
+	_ACPI_UP,		/* 0x5A    90 'Z' */
+	_ACPI_PU,		/* 0x5B    91 '[' */
+	_ACPI_PU,		/* 0x5C    92 '\' */
+	_ACPI_PU,		/* 0x5D    93 ']' */
+	_ACPI_PU,		/* 0x5E    94 '^' */
+	_ACPI_PU,		/* 0x5F    95 '_' */
+	_ACPI_PU,		/* 0x60    96 '`' */
+	_ACPI_XD | _ACPI_LO,	/* 0x61    97 'a' */
+	_ACPI_XD | _ACPI_LO,	/* 0x62    98 'b' */
+	_ACPI_XD | _ACPI_LO,	/* 0x63    99 'c' */
+	_ACPI_XD | _ACPI_LO,	/* 0x64   100 'd' */
+	_ACPI_XD | _ACPI_LO,	/* 0x65   101 'e' */
+	_ACPI_XD | _ACPI_LO,	/* 0x66   102 'f' */
+	_ACPI_LO,		/* 0x67   103 'g' */
+	_ACPI_LO,		/* 0x68   104 'h' */
+	_ACPI_LO,		/* 0x69   105 'i' */
+	_ACPI_LO,		/* 0x6A   106 'j' */
+	_ACPI_LO,		/* 0x6B   107 'k' */
+	_ACPI_LO,		/* 0x6C   108 'l' */
+	_ACPI_LO,		/* 0x6D   109 'm' */
+	_ACPI_LO,		/* 0x6E   110 'n' */
+	_ACPI_LO,		/* 0x6F   111 'o' */
+	_ACPI_LO,		/* 0x70   112 'p' */
+	_ACPI_LO,		/* 0x71   113 'q' */
+	_ACPI_LO,		/* 0x72   114 'r' */
+	_ACPI_LO,		/* 0x73   115 's' */
+	_ACPI_LO,		/* 0x74   116 't' */
+	_ACPI_LO,		/* 0x75   117 'u' */
+	_ACPI_LO,		/* 0x76   118 'v' */
+	_ACPI_LO,		/* 0x77   119 'w' */
+	_ACPI_LO,		/* 0x78   120 'x' */
+	_ACPI_LO,		/* 0x79   121 'y' */
+	_ACPI_LO,		/* 0x7A   122 'z' */
+	_ACPI_PU,		/* 0x7B   123 '{' */
+	_ACPI_PU,		/* 0x7C   124 '|' */
+	_ACPI_PU,		/* 0x7D   125 '}' */
+	_ACPI_PU,		/* 0x7E   126 '~' */
+	_ACPI_CN,		/* 0x7F   127 DEL */
 
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0x80 to 0x8F    */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0x90 to 0x9F    */
@@ -742,7 +742,8 @@ const u8 _acpi_ctype[257] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xC0 to 0xCF    */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xD0 to 0xDF    */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xE0 to 0xEF    */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	/* 0xF0 to 0x100   */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xF0 to 0xFF    */
+	0			/* 0x100 */
 };
 
 #endif				/* ACPI_USE_SYSTEM_CLIBRARY */
-- 
1.7.10

