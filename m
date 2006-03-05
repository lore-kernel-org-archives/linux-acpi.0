From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] ACPI should depend on, not select PCI
Date: Sun, 5 Mar 2006 23:21:36 +0100
Message-ID: <20060305222136.GD20287@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6669 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751888AbWCEWVi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Mar 2006 17:21:38 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

ACPI should depend on, not select PCI.

Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are 
possible.

This patch also fixes the options select'ing ACPI to also select PCI.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Feb 2006

 arch/ia64/Kconfig    |    1 +
 arch/x86_64/Kconfig  |    1 +
 drivers/acpi/Kconfig |    3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc3-mm1-full/drivers/acpi/Kconfig.old	2006-02-16 21:21:23.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/drivers/acpi/Kconfig	2006-02-16 21:21:42.000000000 +0100
@@ -10,9 +10,8 @@
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
--- linux-2.6.16-rc3-mm1-full/arch/ia64/Kconfig.old	2006-02-16 21:21:52.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/arch/ia64/Kconfig	2006-02-16 21:22:08.000000000 +0100
@@ -73,6 +73,7 @@
 config IA64_GENERIC
 	bool "generic"
 	select ACPI
+	select PCI
 	select NUMA
 	select ACPI_NUMA
 	help
--- linux-2.6.16-rc3-mm1-full/arch/x86_64/Kconfig.old	2006-02-16 21:22:19.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/arch/x86_64/Kconfig	2006-02-16 21:23:39.000000000 +0100
@@ -285,6 +285,7 @@
        bool "ACPI NUMA detection"
        depends on NUMA
        select ACPI 
+	select PCI
        select ACPI_NUMA
        default y
        help

