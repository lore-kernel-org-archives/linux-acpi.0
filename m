From: Pavel Machek <pavel@ucw.cz>
Subject: If your ACPI-enabled machine does clean shutdown randomly...
Date: Fri, 28 Nov 2003 15:52:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031128145249.GA563@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


...then you probably need this one. (One notebook I have here
certainly needs it).

It seems that acpi likes to report completely bogus value from time to
time...

								Pavel

--- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2003-11-25 22:27:11.000000000 +0100
@@ -456,6 +459,10 @@
 	if (!tz || !tz->trips.critical.flags.valid)
 		return_VALUE(-EINVAL);
 
+	if (KELVIN_TO_CELSIUS(tz->temperature) >= 200) {
+		printk(KERN_ALERT "Are you running CPU or nuclear power plant? ACPI claims CPU temp is %d C. Ignoring.\n", KELVIN_TO_CELSIUS(tz->temperature));
+		return_VALUE(0);
+	}
 	if (tz->temperature >= tz->trips.critical.temperature) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
 		tz->trips.critical.flags.enabled = 1;
@@ -467,6 +474,7 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down.\n", tz->temperature);
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
