From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: write thermal trip_points totally broken in 2.6.10-rc3-mm1 -
 patch attached
Date: 23 Dec 2004 12:45:55 -0500
Message-ID: <1103823955.4384.4.camel@d845pe>
References: <41C0626B.9020706@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C0626B.9020706-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The original patch was to get acpi off the "make checkstack" radar.
I think we should fix it per below rather than discard it.

thanks,
-Len

===== drivers/acpi/thermal.c 1.41 vs edited =====
--- 1.41/drivers/acpi/thermal.c	2004-12-06 00:03:38 -05:00
+++ edited/drivers/acpi/thermal.c	2004-12-23 11:46:06 -05:00
@@ -917,7 +917,7 @@
 	if(!active)
 		return_VALUE(-ENOMEM);
 
-	if (!tz || (count > sizeof(limit_string) - 1)) {
+	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
 		count = -EINVAL;
 		goto end;





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
