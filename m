From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi: remove obfuscating macro from acpi/battery.c
Date: Sat, 19 Mar 2005 12:03:59 +0100
Message-ID: <20050319110359.GA1514@elf.ucw.cz>
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
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

It seems to me that macros in battery.c only make code more obscure
and longer. This fixes it a bit. Please apply,
								Pavel

--- clean/drivers/acpi/battery.c	2004-12-25 13:34:58.000000000 +0100
+++ linux/drivers/acpi/battery.c	2004-12-25 16:31:14.000000000 +0100
@@ -50,8 +50,6 @@
 #define ACPI_BATTERY_FILE_ALARM		"alarm"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
-#define ACPI_BATTERY_UNITS_WATTS	"mW"
-#define ACPI_BATTERY_UNITS_AMPS		"mA"
 
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
@@ -369,7 +374,7 @@
 		goto end;
 	}
 
-	units = bif->power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	units = bif->power_unit ? "mA" : "mW";
 					
 	if (bif->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design capacity:         unknown\n");
@@ -452,7 +457,7 @@
 
 	/* Battery Units */
 
-	units = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	units = battery->flags.power_unit ? "mA" : "mW";
 
 	/* Battery Status (_BST) */
 
@@ -528,7 +533,7 @@
 
 	/* Battery Units */
 	
-	units = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	units = battery->flags.power_unit ? "mA" : "mW";
 
 	/* Battery Alarm */
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
