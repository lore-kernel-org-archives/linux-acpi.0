From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi: right error level for fan failures
Date: Sat, 19 Mar 2005 12:09:54 +0100
Message-ID: <20050319110954.GA1550@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

This prints messages on fan failures in KERN_ERR level (so that user
actually has chance to see them). It also does not retry all the
time. On evo560c, fan failures do happen, and trying again in a loop
only makes things worse. Please apply,
								Pavel
Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

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
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
