From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: FW: ACPI too sensitive about critical temperature
Date: Mon, 19 Jan 2004 23:02:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040119220251.GD380@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84702C9321E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C9321E-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I didn't want to bug the whole lkml with this, so I'm sending this to 
> you guys who wrote "drivers/acpi/thermal.c". I hope that's okay...
> 
> A friend of mine has a mainboard (I can find out the specific type if 
> you want to know) which reports inaccurately high temperature "peaks" 
> from time to time.
> Looking at /proc/acpi/thermal_zone/THR1/temperature every second might 
> look something like this: 45, 43, 47, 42, 90, 43, 41, 45

Try this one.

								Pavel

--- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2004-01-13 22:33:49.000000000 +0100
@@ -223,8 +223,11 @@
 	tz->last_temperature = tz->temperature;
 
 	status = acpi_evaluate_integer(tz->handle, "_TMP", NULL, &tz->temperature);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		if (tz->temperature != tz->last_temperature)
+			printk(KERN_ERR "temperature damaged while processing\n");
 		return -ENODEV;
+	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n", tz->temperature));
 
@@ -457,7 +460,17 @@
 		return_VALUE(-EINVAL);
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
+		long old_temperature = tz->temperature;
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
+
+		result = acpi_thermal_get_temperature(tz);
+		if (!result) {
+			if (tz->temperature < (tz->trips.critical.temperature - 100)) {
+				printk(KERN_ALERT "ACPI changed its mind about temperature, was %ld C, now %ld C", 
+				       KELVIN_TO_CELSIUS(old_temperature), KELVIN_TO_CELSIUS(tz->temperature));
+				return_VALUE(0);
+			}
+		}
 		tz->trips.critical.flags.enabled = 1;
 	}
 	else if (tz->trips.critical.flags.enabled)
@@ -467,8 +480,8 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n", KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
-
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
 
 	return_VALUE(0);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
