From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: ACPI disappears silently if !CONFIG_X86_LOCAL_APIC
Date: Fri, 15 Aug 2003 17:34:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030815153414.GA789@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On some systems where ACPI used to work fine, APIC support is not really 
needed in the kernel because the mobile chipset/processor doesn't support
it. Nonetheless, in 2.6.0-test3-bk-current, CONFIG_ACPI depends on
CONFIG_X86_LOCAL_APIC. As it's only a requirement for ACPI_HT, this patch
should be fine [it compiles and it works on my notebook].

	Dominik

--- linux-2.6.0-test3+2/drivers/acpi/Kconfig.original	2003-08-15 16:48:16.000000000 +0200
+++ linux-2.6.0-test3+2/drivers/acpi/Kconfig	2003-08-15 16:53:56.000000000 +0200
@@ -30,7 +30,7 @@
 	bool "Full ACPI Support"
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
-	depends on IA64 || (X86 && ACPI_HT)
+	depends on IA64 || (X86 && ACPI_HT) || (X86 && !X86_LOCAL_APIC)
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
