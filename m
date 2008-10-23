From: Len Brown <lenb@kernel.org>
Subject: [PATCH 046/122] fix CONFIG_MMCONFIG=n build warning
Date: Thu, 23 Oct 2008 02:38:20 -0400
Message-ID: <1339c367a842a9fc34b8fcfa1abadb07b11848ad.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbYJWGkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:04 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600FIBIIN9H14@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:59 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Vasilyev <linuxoid@tochka.ru>, Len Brown <len.brown@intel.com>

From: Pavel Vasilyev <linuxoid@tochka.ru>

arch/x86/kernel/acpi/boot.c:100: warning: 'acpi_mcfg_64bit_base_addr' defined
but not used

http://bugzilla.kernel.org/show_bug.cgi?id=11743

Signed-off-by: Pavel Vasilyev <linuxoid@tochka.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index c102af8..0c2742f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -97,7 +97,6 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #warning ACPI uses CMPXCHG, i486 and later hardware
 #endif
 
-static int acpi_mcfg_64bit_base_addr __initdata = FALSE;
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
@@ -156,6 +155,9 @@ char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 }
 
 #ifdef CONFIG_PCI_MMCONFIG
+
+static int acpi_mcfg_64bit_base_addr __initdata = FALSE;
+
 /* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
 struct acpi_mcfg_allocation *pci_mmcfg_config;
 int pci_mmcfg_config_num;
-- 
1.5.5.1

