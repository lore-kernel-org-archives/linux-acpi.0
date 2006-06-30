From: akpm@osdl.org
Subject: [patch 6/6] ACPI_SRAT needs ACPI
Date: Fri, 30 Jun 2006 02:15:19 -0700
Message-ID: <200606300915.k5U9FKTe001047@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:40587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751552AbWF3JPh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 05:15:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, ak@muc.de, mingo@elte.hu

From: Andrew Morton <akpm@osdl.org>

arch/i386/kernel/srat.c won't compile without CONFIG_ACPI.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/Kconfig~acpi_srat-needs-acpi arch/i386/Kconfig
--- a/arch/i386/Kconfig~acpi_srat-needs-acpi
+++ a/arch/i386/Kconfig
@@ -176,7 +176,7 @@ endchoice
 config ACPI_SRAT
 	bool
 	default y
-	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
+	depends on ACPI && NUMA && (X86_SUMMIT || X86_GENERICARCH)
 	select ACPI_NUMA
 
 config HAVE_ARCH_PARSE_SRAT
_
