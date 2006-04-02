From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 20/26] ACPI should depend on, not select PCI
Date: Sat, 1 Apr 2006 21:07:17 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DCF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50572 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932373AbWDBCHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Apr 2006 21:07:20 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bunk@stusta.de

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bunk@stusta.de
>Subject: [patch 20/26] ACPI should depend on, not select PCI
>
>
>From: Adrian Bunk <bunk@stusta.de>
>
>ACPI should depend on, not select PCI.
>
>Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are
>possible.
>
>This patch also fixes the options select'ing ACPI to also select PCI.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> arch/ia64/Kconfig    |    1 +
> arch/x86_64/Kconfig  |    1 +
> drivers/acpi/Kconfig |    3 +--
> 3 files changed, 3 insertions(+), 2 deletions(-)
>
>diff -puN 
>arch/ia64/Kconfig~acpi-should-depend-on-not-select-pci 
>arch/ia64/Kconfig
>--- 
>devel/arch/ia64/Kconfig~acpi-should-depend-on-not-select-pci	
>2006-03-28 14:03:06.000000000 -0800
>+++ devel-akpm/arch/ia64/Kconfig	2006-03-28 
>14:03:06.000000000 -0800
>@@ -77,6 +77,7 @@ choice
> config IA64_GENERIC
> 	bool "generic"
> 	select ACPI
>+	select PCI
> 	select NUMA
> 	select ACPI_NUMA
> 	help
>diff -puN 
>arch/x86_64/Kconfig~acpi-should-depend-on-not-select-pci 
>arch/x86_64/Kconfig
>--- 
>devel/arch/x86_64/Kconfig~acpi-should-depend-on-not-select-pci	
>2006-03-28 14:03:06.000000000 -0800
>+++ devel-akpm/arch/x86_64/Kconfig	2006-03-28 
>14:03:06.000000000 -0800
>@@ -289,6 +289,7 @@ config X86_64_ACPI_NUMA
>        bool "ACPI NUMA detection"
>        depends on NUMA
>        select ACPI 
>+	select PCI
>        select ACPI_NUMA
>        default y
>        help
>diff -puN 
>drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci 
>drivers/acpi/Kconfig
>--- 
>devel/drivers/acpi/Kconfig~acpi-should-depend-on-not-sel
>ect-pci	2006-03-28 14:03:06.000000000 -0800
>+++ devel-akpm/drivers/acpi/Kconfig	2006-03-28 
>14:03:06.000000000 -0800
>@@ -10,9 +10,8 @@ menu "ACPI (Advanced Configuration and P
> config ACPI
> 	bool "ACPI Support"
> 	depends on IA64 || X86
>+	depends on PCI
> 	select PM
>-	select PCI
>-
> 	default y
> 	---help---
> 	  Advanced Configuration and Power Interface (ACPI) support for 
>_
>
