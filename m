From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 6/6] ACPI_SRAT needs ACPI
Date: Fri, 30 Jun 2006 14:28:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16BBE@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55214 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S933005AbWF3S2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 14:28:01 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, ak@muc.de, mingo@elte.hu

applied.
thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, June 30, 2006 5:15 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; ak@muc.de; mingo@elte.hu
>Subject: [patch 6/6] ACPI_SRAT needs ACPI
>
>From: Andrew Morton <akpm@osdl.org>
>
>arch/i386/kernel/srat.c won't compile without CONFIG_ACPI.
>
>Cc: Ingo Molnar <mingo@elte.hu>
>Cc: Andi Kleen <ak@muc.de>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> arch/i386/Kconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN arch/i386/Kconfig~acpi_srat-needs-acpi arch/i386/Kconfig
>--- a/arch/i386/Kconfig~acpi_srat-needs-acpi
>+++ a/arch/i386/Kconfig
>@@ -176,7 +176,7 @@ endchoice
> config ACPI_SRAT
> 	bool
> 	default y
>-	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
>+	depends on ACPI && NUMA && (X86_SUMMIT || X86_GENERICARCH)
> 	select ACPI_NUMA
> 
> config HAVE_ARCH_PARSE_SRAT
>_
>
