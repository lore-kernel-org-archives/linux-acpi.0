From: Pavel Machek <pavel@ucw.cz>
Subject: Tell user when ACPI is killing machine
Date: Fri, 28 Nov 2003 15:55:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031128145558.GA576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
List-Id: linux-acpi@vger.kernel.org

Hi!

On critical overheat (or perceived critical overheat -- acpi bioses on
some notebooks apparently report bogus values from time to time),
kernel itself calls /sbin/halt *without telling anything*. User can
not see anything, his machine just shuts down cleanly. Bad.

We should at least tell the user what is going on... 

								Pavel

--- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2003-11-25 22:27:11.000000000 +0100
@@ -467,6 +474,7 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down.\n", tz->temperature);
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
