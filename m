From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: [PATCH] replace pr_debug
Date: Sun, 22 Dec 2002 14:49:22 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33L2.0212221443300.16753-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

This patch to 2.5.52 replaces one instance of pr_debug() with
printk(KERN_DEBUG ...).

Reasons:
1.  pr_debug() is overused (or abused) in Linux:  it has over 300
usage instances, spread throughout drivers, filesystems, core code,
library code, etc.  This is just one tiny step in cleaning this up.

2.  This code is already conditioned by
#ifdef CONFIG_ACPI_DEBUG_OUTPUT

3.  ACPI's Kconfig has a config option named 'ACPI_DEBUG' which could
be used for further control.

Please apply.

-- 
~Randy



--- ./drivers/acpi/scan.c%PRD	Sun Dec 15 18:07:54 2002
+++ ./drivers/acpi/scan.c	Sun Dec 22 14:37:58 2002
@@ -644,7 +644,7 @@
 		break;
 	}

-	pr_debug("Found %s %s [%p]\n", type_string, name, handle);
+	printk(KERN_DEBUG "Found %s %s [%p]\n", type_string, name, handle);
 #endif /*CONFIG_ACPI_DEBUG_OUTPUT*/
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
