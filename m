From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 3/7] ACPI: Add interfaces for ioremapping/iounmapping ACPI
	registers
Date: Thu, 21 Oct 2010 14:23:59 -0600
Message-ID: <20101021202359.9220.72989.stgit@bob.kio>
References: <20101021201916.9220.5711.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:24517 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab0JUUYA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2010 16:24:00 -0400
In-Reply-To: <20101021201916.9220.5711.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ak@linux.intel.com, ying.huang@intel.com

Add remapping and unmapping interfaces for ACPI registers that are
backed by memory mapped I/O (MMIO).  These interfaces, along with
the MMIO remapping list, enable accesses of such registers from within
interrupt context.

ACPI Generic Address Structure (GAS) reference (ACPI's fixed/generic
hardware registers use the GAS format):
  ACPI Specification, Revision 4.0, Section 5.2.3.1, "Generic Address
  Structure".


Signed-off-by: Myron Stowe <myron.stowe@hp.com>
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

