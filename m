From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH 6/7] platform/x86: fujitsu-laptop: do not evaluate ACPI _INI methods
Date: Fri, 16 Jun 2017 06:40:57 +0200
Message-ID: <20170616044058.30443-7-kernel@kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616044058.30443-1-kernel@kempniu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

acpi_ns_initialize_devices(), which is called during system-wide ACPI
initialization, already detects and calls all _INI methods belonging to
objects present in ACPI tables.  There is no need to call these methods
again every time the module is loaded because they only initialize
status flags and hotkey-related variables; status flags are effectively
constants, hotkey-related variables may be assigned non-zero values
before acpi_fujitsu_laptop_add() is called, but that does not really
matter as we drain the scancodes queued in the firmware's ring buffer
before doing anything else.

Remove sections of code which invoke and check evaluation status of the
_INI methods belonging to the ACPI devices handled by the driver.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index b9f3ede4d567..0861be36305d 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -421,14 +421,6 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	if (acpi_has_method(device->handle, METHOD_NAME__INI)) {
-		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
-		if (ACPI_FAILURE
-		    (acpi_evaluate_object
-		     (device->handle, METHOD_NAME__INI, NULL, NULL)))
-			pr_err("_INI Method failed\n");
-	}
-
 	if (get_max_brightness(device) <= 0)
 		priv->max_brightness = FUJITSU_LCD_N_LEVELS;
 	get_lcd_level(device);
@@ -801,14 +793,6 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	if (acpi_has_method(device->handle, METHOD_NAME__INI)) {
-		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
-		if (ACPI_FAILURE
-		    (acpi_evaluate_object
-		     (device->handle, METHOD_NAME__INI, NULL, NULL)))
-			pr_err("_INI Method failed\n");
-	}
-
 	i = 0;
 	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0
 		&& (i++) < MAX_HOTKEY_RINGBUFFER_SIZE)
-- 
2.13.1
