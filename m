From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: thermal: tell user when something goes very wrong
Date: Wed, 12 Jan 2005 14:26:22 +0100
Message-ID: <20050112132621.GA2104@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This informs user when turning fan on/off helps. It also does not
retry playing with fan: on evo nx560c this lead to ugly loop in acpi
trying to turn it on over and over and over and over... Please apply,

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

								Pavel

--- clean/drivers/acpi/thermal.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2005-01-12 11:12:02.000000000 +0100
@@ -612,8 +625,7 @@
 				for (j = 0; j < active->devices.count; j++) {
 					result = acpi_bus_set_power(active->devices.handles[j], ACPI_STATE_D0);
 					if (result) {
-						ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to turn cooling device [%p] 'on'\n", active->devices.handles[j]));
-						continue;
+						printk(KERN_ERR "Unable to turn cooling device [%p] 'on'\n", active->devices.handles[j]);
 					}
 					active->flags.enabled = 1;
 					ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p] now 'on'\n", active->devices.handles[j]));
@@ -630,8 +642,7 @@
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
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
