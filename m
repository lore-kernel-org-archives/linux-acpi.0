From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: ACPI-20030228 and custom dsdt
Date: Tue, 04 Mar 2003 16:37:31 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046749050.9966.3.camel@laptop-linux.cunninghams>
References: <20030303211020.7e008a42.greg@algx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030303211020.7e008a42.greg-OpKIWVIkplU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg Oliver <greg-OpKIWVIkplU@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-03-04 at 16:10, Greg Oliver wrote:
> What is the secret for incorporating this into the 2.4.21-pre4 kernel
> sources?  All patches apply cleanly, but all available methods to use my
> own DSDT fail compilation.

This still works for me.

Regards,

Nigel

diff -ruN linux-2.4.18/drivers/acpi/dsdt_table.h linux-2.4.18-use-my-dsdt/drivers/acpi/dsdt_table.h
--- linux-2.4.18/drivers/acpi/dsdt_table.h	Thu Jan  1 12:00:00 1970
+++ linux-2.4.18-use-my-dsdt/drivers/acpi/dsdt_table.h	Thu Aug 29 22:15:49 2002
@@ -0,0 +1,2526 @@
+/*
+ * 
+ * Intel ACPI Component Architecture ASL Compiler X2046 [Jun 11 2002]
+ * Includes ACPI CA Subsystem version 20020611
+ * Copyright (C) 2000 - 2002 Intel Corporation
+ * Supports ACPI Specification Revision 2.0a
+ * 
+ * Compilation of "nigel.v3.asl" - Thu Jun 27 07:37:12 2002
+ * 
+ * C source code output
+ *
+ */
+unsigned char AmlCode[] = 
+{
+    0x44,0x53,0x44,0x54,0x73,0x4E,0x00,0x00,  /* 00000000 "DSDTsN.."  */

[deletia]

+    0x53,0x08,0x5F,0x41,0x44,0x52,0x0C,0x03,  /* 00004E68 "S._ADR.."  */
+    0x00,0x1F,0x00,
+};
diff -ruN linux-2.4.18/drivers/acpi/dsdt.h linux-2.4.18-use-my-dsdt/drivers/acpi/dsdt.h
--- linux-2.4.18/drivers/acpi/osl.c-dist	Mon Aug 12 11:40:31 2002
+++ linux-2.4.18/drivers/acpi/osl.c	Tue Aug 13 12:02:23 2002
@@ -25,6 +25,7 @@
  *
  */
 
+#include "dsdt_table.h"
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -208,7 +209,8 @@
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
 
-	*new_table = NULL;
+	*new_table = (strncmp(existing_table->signature, DSDT_SIG, 4)) ? NULL \
+			: (struct acpi_table_header *) AmlCode;
 	return AE_OK;
 }
 





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
