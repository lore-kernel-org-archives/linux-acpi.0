From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] Documentation: gpio: Update ACPI part of the document to mention _DSD
Date: Tue, 31 Mar 2015 14:43:15 +0300
Message-ID: <1427802195-221906-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48350 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbbCaLnT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Mar 2015 07:43:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@linux.intel.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

With ACPI 5.1 _DSD (Device Specific Data) it is now possible to name
functions just like Device Tree is doing. Make sure that the documentation
mentions _DSD as the recommended way to describe GPIOs in ACPI systems.

Reported-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/gpio/board.txt | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpio/board.txt b/Documentation/gpio/board.txt
index 8b35f51fe7b6..b68cfa8a6865 100644
--- a/Documentation/gpio/board.txt
+++ b/Documentation/gpio/board.txt
@@ -50,10 +50,43 @@ gpiod_is_active_low(power) will be true).
 
 ACPI
 ----
-ACPI does not support function names for GPIOs. Therefore, only the "idx"
-argument of gpiod_get_index() is useful to discriminate between GPIOs assigned
-to a device. The "con_id" argument can still be set for debugging purposes (it
-will appear under error messages as well as debug and sysfs nodes).
+ACPI does also support function names for GPIOs in similar fashion than DT.
+The above DT example can be converted to corresponding ACPI version with
+the help of _DSD (Device Specific Data) which was introduced in ACPI 5.1:
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

