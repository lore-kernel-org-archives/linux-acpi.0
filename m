From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH] Restore SYSENTER setup on swsusp resume.
Date: 14 Feb 2003 18:30:00 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045247400.22719.138.camel@passion.cambridge.redhat.com>
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
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Box gets very unhappy if we don't set up SYSENTER again after returning
from sleep.

===== arch/i386/kernel/acpi.c 1.19 vs edited =====
--- 1.19/arch/i386/kernel/acpi.c	Tue Jan 21 00:56:24 2003
+++ edited/arch/i386/kernel/acpi.c      Fri Feb 14 18:11:55 2003
@@ -502,6 +502,10 @@
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
--- 1.7/arch/i386/kernel/sysenter.c	Tue Jan  7 18:08:52 2003
+++ edited/arch/i386/kernel/sysenter.c	Fri Feb 14 18:11:32 2003
@@ -35,7 +35,7 @@
 	unsigned char stack[0];
 } __attribute__((aligned(8192)));
 	
-static void __init enable_sep_cpu(void *info)
+void enable_sep_cpu(void *info)
 {
 	int cpu = get_cpu();
 	struct tss_struct *tss = init_tss + cpu;



-- 
dwmw2


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
