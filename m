From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: DSDT Override: Is this correct?
Date: Tue, 14 Jan 2003 16:55:25 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1042516523.2328.3.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

I'm just trying to override the DSDT using the 2.4.21-pre3 kernel, and
had to stick a struct in front of the (acpi_table_header *) cast. Can I
get confirmation that this the the right thing to do?

Regards,

Nigel

--- linux-2.4.18/drivers/acpi/osl.c-dist	Mon Aug 12 11:40:31 2002
+++ linux-2.4.18/drivers/acpi/osl.c	Tue Aug 13 12:02:23 2002
@@ -25,6 +25,7 @@
  *
  */
 
+#include "dsdt_table.h"
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -221,7 +222,8 @@
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
 
-	*new_table = NULL;
+	*new_table = (strncmp(existing_table->signature, DSDT_SIG, 4)) ? NULL
\
+			: (struct acpi_table_header *) AmlCode;
 	return AE_OK;
 }
 





-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
