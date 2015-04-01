From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] Documentation: gpio: Update ACPI part of the document to mention _DSD
Date: Wed,  1 Apr 2015 11:13:16 +0300
Message-ID: <1427875996-216926-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

With ACPI 5.1 _DSD (Device Specific Data) it is now possible to name
functions just like Device Tree is doing. Make sure that the documentation
mentions _DSD as the recommended way to describe GPIOs in ACPI systems.

Reported-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v2: Corrected text according what Darren suggested

 Documentation/gpio/board.txt | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpio/board.txt b/Documentation/gpio/board.txt
index 8b35f51fe7b6..b80606de545a 100644
--- a/Documentation/gpio/board.txt
+++ b/Documentation/gpio/board.txt
@@ -50,10 +50,43 @@ gpiod_is_active_low(power) will be true).
 
 ACPI
 ----
-ACPI does not support function names for GPIOs. Therefore, only the "idx"
-argument of gpiod_get_index() is useful to discriminate between GPIOs assigned
-to a device. The "con_id" argument can still be set for debugging purposes (it
-will appear under error messages as well as debug and sysfs nodes).
+ACPI also supports function names for GPIOs in a similar fashion to DT.
+The above DT example can be converted to an equivalent ACPI description
+with the help of _DSD (Device Specific Data), introduced in ACPI 5.1:
+
+	Device (FOO) {
+		Name (_CRS, ResourceTemplate () {
+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
+				"\\_SB.GPI0") {15} // red
+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
+				"\\_SB.GPI0") {16} // green
+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
+				"\\_SB.GPI0") {17} // blue
+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
+				"\\_SB.GPI0") {1} // power
+		})
+
+		Name (_DSD, Package () {
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package () {
+				Package () {
+					"led-gpios",
+					Package () {
+						^FOO, 0, 0, 1,
+						^FOO, 1, 0, 1,
+						^FOO, 2, 0, 1,
+					}
+				},
+				Package () {
+					"power-gpios",
+					Package () {^FOO, 3, 0, 0},
+				},
+			}
+		})
+	}
+
+For more information about the ACPI GPIO bindings see
+Documentation/acpi/gpio-properties.txt.
 
 Platform Data
 -------------
-- 
2.1.4

