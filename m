From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Fix message levels in thermal
Date: Fri, 23 Jul 2004 20:57:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040723185738.GA8460@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

thermal prints rather serious messages with ACPI_DEBUG_PRINT. I do not
think that is good idea.

I also added continue so that we do not interpret AML in tight loop
making system close to unusable; I do not know if you want to apply
this.

								Pavel 

--- /home/pavel/new/linux/drivers/acpi/thermal.c	2004-06-22 12:37:56.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2004-07-23 18:03:23.000000000 +0200
@@ -622,8 +622,7 @@
 				for (j = 0; j < active->devices.count; j++) {
 					result = acpi_bus_set_power(active->devices.handles[j], ACPI_STATE_D0);
 					if (result) {
-						ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to turn cooling device [%p] 'on'\n", active->devices.handles[j]));
-						continue;
+						printk(KERN_ERR "Unable to turn cooling device [%p] 'on'\n", active->devices.handles[j]);
 					}
 					active->flags.enabled = 1;
 					ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p] now 'on'\n", active->devices.handles[j]));
@@ -640,8 +639,7 @@
 			for (j = 0; j < active->devices.count; j++) {
 				result = acpi_bus_set_power(active->devices.handles[j], ACPI_STATE_D3);
 				if (result) {
-					ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to turn cooling device [%p] 'off'\n", active->devices.handles[j]));
-					continue;
+					printk(KERN_ERR "Unable to turn cooling device [%p] 'off'\n", active->devices.handles[j]);
 				}
 				active->flags.enabled = 0;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p] now 'off'\n", active->devices.handles[j]));

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
