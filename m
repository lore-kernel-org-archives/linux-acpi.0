From: akpm@osdl.org
Subject: [patch 20/26] ACPI should depend on, not select PCI
Date: Tue, 28 Mar 2006 14:03:46 -0800
Message-ID: <200603282203.k2SM3qVF027710@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:11953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932439AbWC1WHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:07:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bunk@stusta.de


From: Adrian Bunk <bunk@stusta.de>

ACPI should depend on, not select PCI.

Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are
possible.

This patch also fixes the options select'ing ACPI to also select PCI.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ia64/Kconfig    |    1 +
 arch/x86_64/Kconfig  |    1 +
 drivers/acpi/Kconfig |    3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/ia64/Kconfig~acpi-should-depend-on-not-select-pci arch/ia64/Kconfig
--- devel/arch/ia64/Kconfig~acpi-should-depend-on-not-select-pci	2006-03-28 14:03:06.000000000 -0800
+++ devel-akpm/arch/ia64/Kconfig	2006-03-28 14:03:06.000000000 -0800
@@ -77,6 +77,7 @@ choice
 config IA64_GENERIC
 	bool "generic"
 	select ACPI
+	select PCI
 	select NUMA
 	select ACPI_NUMA
 	help
diff -puN arch/x86_64/Kconfig~acpi-should-depend-on-not-select-pci arch/x86_64/Kconfig
--- devel/arch/x86_64/Kconfig~acpi-should-depend-on-not-select-pci	2006-03-28 14:03:06.000000000 -0800
+++ devel-akpm/arch/x86_64/Kconfig	2006-03-28 14:03:06.000000000 -0800
@@ -289,6 +289,7 @@ config X86_64_ACPI_NUMA
        bool "ACPI NUMA detection"
        depends on NUMA
        select ACPI 
+	select PCI
        select ACPI_NUMA
        default y
        help
diff -puN drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci drivers/acpi/Kconfig
--- devel/drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci	2006-03-28 14:03:06.000000000 -0800
+++ devel-akpm/drivers/acpi/Kconfig	2006-03-28 14:03:06.000000000 -0800
@@ -10,9 +10,8 @@ menu "ACPI (Advanced Configuration and P
 config ACPI
 	bool "ACPI Support"
 	depends on IA64 || X86
+	depends on PCI
 	select PM
-	select PCI
-
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 
_
