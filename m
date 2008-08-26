From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Subject: [RESEND][PATCH -tip] x86: acpi: move acpi_mcfg_64bit_base_addr into
 CONFIG_PCI_MMCONFIG
Date: Tue, 26 Aug 2008 15:13:45 -0700
Message-ID: <48B48019.6080803@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753332AbYHZWOu@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: John Keller <jpk@sgi.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

acpi_mcfg_64bit_base_addr is used when CONFIG_PCI_MMCONFIG is enabled.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 arch/x86/kernel/acpi/boot.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index fc64412..8a1c9f9 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -96,8 +96,6 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #warning ACPI uses CMPXCHG, i486 and later hardware
 #endif
 
-static int acpi_mcfg_64bit_base_addr __initdata = FALSE;
-
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
@@ -159,6 +157,8 @@ char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 struct acpi_mcfg_allocation *pci_mmcfg_config;
 int pci_mmcfg_config_num;
 
+static int acpi_mcfg_64bit_base_addr __initdata = FALSE;
+
 static int __init acpi_mcfg_oem_check(struct acpi_table_mcfg *mcfg)
 {
 	if (!strcmp(mcfg->header.oem_id, "SGI"))
-- 
1.5.6
