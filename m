From: Len Brown <lenb@kernel.org>
Subject: [PATCH 011/112] acpi: make __acpi_map_table() and __init function
Date: Thu,  7 Feb 2008 04:33:33 -0500
Message-ID: <2fdf07417e57136cf6baedf9508e2169a059ebea.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755883AbYBGJff (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:35 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <jbeulich@novell.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <jbeulich@novell.com>

.. as it it used only during early boot.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

 arch/ia64/kernel/acpi.c     |    2 +-
 arch/x86/kernel/acpi/boot.c |    4 ++--
 drivers/acpi/osl.c          |    3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi.c     |    2 +-
 arch/x86/kernel/acpi/boot.c |    4 ++--
 drivers/acpi/osl.c          |    3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 00b5d08..f932c48 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -152,7 +152,7 @@ int acpi_request_vector(u32 int_type)
 	return vector;
 }
 
-char *__acpi_map_table(unsigned long phys_addr, unsigned long size)
+char *__init __acpi_map_table(unsigned long phys_addr, unsigned long size)
 {
 	return __va(phys_addr);
 }
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0ca27c7..b595522 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -106,7 +106,7 @@ enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PIC;
 #ifdef	CONFIG_X86_64
 
 /* rely on all ACPI tables being in the direct mapping */
-char *__acpi_map_table(unsigned long phys_addr, unsigned long size)
+char *__init __acpi_map_table(unsigned long phys_addr, unsigned long size)
 {
 	if (!phys_addr || !size)
 		return NULL;
@@ -131,7 +131,7 @@ char *__acpi_map_table(unsigned long phys_addr, unsigned long size)
  * from the fixed base.  That's why we start at FIX_IO_APIC_BASE_END and
  * count idx down while incrementing the phys address.
  */
-char *__acpi_map_table(unsigned long phys, unsigned long size)
+char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 {
 	unsigned long base, offset, mapped_size;
 	int idx;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e3a673a..82525d9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -211,7 +211,8 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 		return acpi_find_rsdp();
 }
 
-void __iomem *acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
+void __iomem *__init_refok
+acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
 	if (phys > ULONG_MAX) {
 		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
-- 
1.5.4.23.gef5b9

