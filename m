From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] Restore SYSENTER setup on swsusp resume.
Date: Fri, 14 Feb 2003 12:31:23 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302141227410.1067-100000@localhost.localdomain>
References: <1045247400.22719.138.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1045247400.22719.138.camel-U6vq7BvGKfF5pKCnmE3YQOkCa/Q774e0VpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 14 Feb 2003, David Woodhouse wrote:

> Box gets very unhappy if we don't set up SYSENTER again after returning
> from sleep.

Here's the patch against the current BK tree, since the code in 
arch/i386/kernel/acpi.c got moved into arch/i386/kernel/acpi/sleep.c

	-pat

===== arch/i386/kernel/acpi/sleep.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/acpi/sleep.c	Thu Feb 13 11:51:14 2003
+++ edited/arch/i386/kernel/acpi/sleep.c	Fri Feb 14 12:30:57 2003
@@ -6,7 +6,9 @@
 
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
-#include <asm/smp.h>
+#include <linux/smp.h>
+
+extern void enable_sep_cpu(void *info);
 
 
 /* address in low memory of the wakeup routine. */
@@ -60,6 +62,10 @@
 void acpi_restore_state_mem (void)
 {
 	zap_low_mappings();
+	if (boot_cpu_has(X86_FEATURE_SEP)) {
+		enable_sep_cpu(NULL);
+		smp_call_function(enable_sep_cpu, NULL, 1, 1);
+	}
 }
 
 /**
===== arch/i386/kernel/sysenter.c 1.7 vs edited =====
--- 1.7/arch/i386/kernel/sysenter.c	Tue Jan  7 12:08:52 2003
+++ edited/arch/i386/kernel/sysenter.c	Fri Feb 14 12:26:47 2003
@@ -35,7 +35,7 @@
 	unsigned char stack[0];
 } __attribute__((aligned(8192)));
 	
-static void __init enable_sep_cpu(void *info)
+void enable_sep_cpu(void *info)
 {
 	int cpu = get_cpu();
 	struct tss_struct *tss = init_tss + cpu;




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
