From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 06/12] ACPI: report errors in fan.c
Date: Wed, 23 Feb 2005 01:53:04 -0800
Message-ID: <200502230953.j1N9rIwN020705@shell0.pdx.osdl.net>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

Currently, fan.c ignores errors from acpi_bus_get_power.  On compaq evo
notebook that leads to very confusing empty output.

Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/fan.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff -puN drivers/acpi/fan.c~acpi-report-errors-in-fanc drivers/acpi/fan.c
--- 25/drivers/acpi/fan.c~acpi-report-errors-in-fanc	2005-02-23 01:48:03.000000000 -0800
+++ 25-akpm/drivers/acpi/fan.c	2005-02-23 01:48:03.000000000 -0800
@@ -78,21 +78,18 @@ struct proc_dir_entry		*acpi_fan_dir;
 static int
 acpi_fan_read_state (struct seq_file *seq, void *offset)
 {
-	struct acpi_fan		*fan = (struct acpi_fan *) seq->private;
+	struct acpi_fan		*fan = seq->private;
 	int			state = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_fan_read_state");
 
-	if (!fan)
-		goto end;
-
-	if (acpi_bus_get_power(fan->handle, &state))
-		goto end;
-
-	seq_printf(seq, "status:                  %s\n",
-		!state?"on":"off");
-
-end:
+	if (fan) {
+		if (acpi_bus_get_power(fan->handle, &state))
+			seq_printf(seq, "status:                  ERROR\n");
+		else
+			seq_printf(seq, "status:                  %s\n",
+				     !state?"on":"off");
+	}
 	return_VALUE(0);
 }
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
