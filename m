From: Stephen Hemminger <shemminger-3NddpPZAyC0@public.gmane.org>
Subject: [PATCH] asus_acpi build fix for 2.6.0-test6
Date: Thu, 2 Oct 2003 13:33:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031002133318.0ee1fc95.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

For 2.6.0-test6 BK latest, fix 'make allmodconfig'.  
This driver seems to think there is still linux/modversions.h on 2.6?

  CC [M]  drivers/acpi/asus_acpi.o
drivers/acpi/asus_acpi.c:37:31: linux/modversions.h: No such file or directory
diff -Nru a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c	Thu Oct  2 13:28:35 2003
+++ b/drivers/acpi/asus_acpi.c	Thu Oct  2 13:28:35 2003
@@ -33,10 +33,6 @@
  */
 
 #include <linux/config.h>
-#if defined (CONFIG_MODVERSIONS) && !defined (MODVERSIONS) && defined (MODULE)
-#include <linux/modversions.h>
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
