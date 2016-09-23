From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/5] ACPI / documentation: Use recommended name in GPIO property names
Date: Fri, 23 Sep 2016 17:57:06 +0300
Message-ID: <20160923145710.105489-2-mika.westerberg@linux.intel.com>
References: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The recommended property name for all kinds of GPIOs is to end it with
"-gpios" even if there is only one GPIO. Update the documentation to follow
this fact.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/acpi/gpio-properties.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index f35dad11f0de..5aafe0b351a1 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -28,8 +28,8 @@ index, like the ASL example below shows:
           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
           Package ()
 	  {
-              Package () {"reset-gpio", Package() {^BTH, 1, 1, 0 }},
-              Package () {"shutdown-gpio", Package() {^BTH, 0, 0, 0 }},
+              Package () {"reset-gpios", Package() {^BTH, 1, 1, 0 }},
+              Package () {"shutdown-gpios", Package() {^BTH, 0, 0, 0 }},
           }
       })
   }
@@ -48,7 +48,7 @@ Since ACPI GpioIo() resource does not have a field saying whether it is
 active low or high, the "active_low" argument can be used here.  Setting
 it to 1 marks the GPIO as active low.
 
-In our Bluetooth example the "reset-gpio" refers to the second GpioIo()
+In our Bluetooth example the "reset-gpios" refers to the second GpioIo()
 resource, second pin in that resource with the GPIO number of 31.
 
 ACPI GPIO Mappings Provided by Drivers
@@ -83,8 +83,8 @@ static const struct acpi_gpio_params reset_gpio = { 1, 1, false };
 static const struct acpi_gpio_params shutdown_gpio = { 0, 0, false };
 
 static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
-  { "reset-gpio", &reset_gpio, 1 },
-  { "shutdown-gpio", &shutdown_gpio, 1 },
+  { "reset-gpios", &reset_gpio, 1 },
+  { "shutdown-gpios", &shutdown_gpio, 1 },
   { },
 };
 
-- 
2.9.3
