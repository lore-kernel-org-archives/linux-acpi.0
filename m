From: Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH v2 1/4] arm64: Prepare to use generic ACPI PCI implementation
Date: Tue, 12 Apr 2016 04:15:04 +0530
Message-ID: <1460414707-19153-2-git-send-email-jchandra@broadcom.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org
Cc: Jayachandran C <jchandra@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Define PCI_MMCONFIG config option for arm64.

Weaken implementations of raw_pci_read/write and pci_acpi_scan_root,
the generic ACPI PCI driver will implement these.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/Kconfig      | 3 +++
 arch/arm64/kernel/pci.c | 7 +++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..6c6658a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -236,6 +236,9 @@ config PCI_DOMAINS_GENERIC
 config PCI_SYSCALL
 	def_bool PCI
 
+config PCI_MMCONFIG
+	bool
+
 source "drivers/pci/Kconfig"
 
 endmenu
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 15109c11..098028c 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -67,13 +67,13 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
  */
-int raw_pci_read(unsigned int domain, unsigned int bus,
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
 		  unsigned int devfn, int reg, int len, u32 *val)
 {
 	return -ENXIO;
 }
 
-int raw_pci_write(unsigned int domain, unsigned int bus,
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
 		unsigned int devfn, int reg, int len, u32 val)
 {
 	return -ENXIO;
@@ -81,9 +81,8 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+struct pci_bus *__weak pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	/* TODO: Should be revisited when implementing PCI on ACPI */
 	return NULL;
 }
 #endif
-- 
1.9.1
