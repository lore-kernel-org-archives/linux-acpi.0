From: Len Brown <lenb@kernel.org>
Subject: [PATCH 57/60] ACPI: Add interfaces for ioremapping/iounmapping ACPI
 registers
Date: Mon, 25 Oct 2010 02:21:05 -0400
Message-ID: <29718521237a1b1607ea05b49243100ea2044337.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0JYHLL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:11 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:09 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

Add remapping and unmapping interfaces for ACPI registers that are
backed by memory mapped I/O (MMIO).  These interfaces, along with
the MMIO remapping list, enable accesses of such registers from within
interrupt context.

ACPI Generic Address Structure (GAS) reference (ACPI's fixed/generic
hardware registers use the GAS format):
  ACPI Specification, Revision 4.0, Section 5.2.3.1, "Generic Address
  Structure".

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c   |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |    3 +++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index bd72129..fc6c5d2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -372,6 +372,44 @@ void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 		__acpi_unmap_table(virt, size);
 }
 
+int acpi_os_map_generic_address(struct acpi_generic_address *addr)
+{
+	void __iomem *virt;
+
+	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		return 0;
+
+	if (!addr->address || !addr->bit_width)
+		return -EINVAL;
+
+	virt = acpi_os_map_memory(addr->address, addr->bit_width / 8);
+	if (!virt)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_os_map_generic_address);
+
+void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
+{
+	void __iomem *virt;
+	unsigned long flags;
+	acpi_size size = addr->bit_width / 8;
+
+	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		return;
+
+	if (!addr->address || !addr->bit_width)
+		return;
+
+	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	virt = acpi_map_vaddr_lookup(addr->address, size);
+	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+
+	acpi_os_unmap_memory(virt, size);
+}
+EXPORT_SYMBOL_GPL(acpi_os_unmap_generic_address);
+
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c227757..7774e6d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -308,6 +308,9 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
 					     u32 *mask, u32 req);
 extern void acpi_early_init(void);
 
+int acpi_os_map_generic_address(struct acpi_generic_address *addr);
+void acpi_os_unmap_generic_address(struct acpi_generic_address *addr);
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
1.7.3.2.90.gd4c43

