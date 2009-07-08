From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/12] SFI, PCI: Hook MMCONFIG
Date: Wed, 08 Jul 2009 00:13:57 -0400
Message-ID: <24fe646fcbbd9049850de4ac57cf6a67846b38c4.1247025117.git.len.brown@intel.com>
References: <1247026438-20891-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:42823 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591AbZGHEPH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 00:15:07 -0400
In-reply-to: <1247026438-20891-1-git-send-email-lenb@kernel.org>
In-reply-to: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
References: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <len.brown@intel.com>

From: Feng Tang <feng.tang@intel.com>

First check ACPI, and if that fails, ask SFI to find the MCFG.

Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/Kconfig               |    2 +-
 arch/x86/pci/mmconfig-shared.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8e864c0..8e20a0e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1880,7 +1880,7 @@ config PCI_DIRECT
 
 config PCI_MMCONFIG
 	def_bool y
-	depends on X86_32 && PCI && ACPI && (PCI_GOMMCONFIG || PCI_GOANY)
+	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
 
 config PCI_OLPC
 	def_bool y
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 712443e..373780b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/sfi_acpi.h>
 #include <linux/bitmap.h>
 #include <linux/sort.h>
 #include <asm/e820.h>
@@ -606,7 +607,9 @@ static void __init __pci_mmcfg_init(int early)
 	}
 
 	if (!known_bridge)
-		acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+		if (acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg))
+			sfi_acpi_table_parse(ACPI_SIG_MCFG, NULL, NULL, 0,
+				pci_parse_mcfg);
 
 	pci_mmcfg_reject_broken(early);
 
-- 
1.6.0.6

