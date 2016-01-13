From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V3 21/21] arm64, pci, acpi: Start using ACPI based PCI host bridge driver for ARM64.
Date: Wed, 13 Jan 2016 14:21:07 +0100
Message-ID: <1452691267-32240-22-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
List-Id: linux-acpi@vger.kernel.org

Lets get rid of empty PCI init stub, related ACPI header and
go with full-blown PCI host bridge driver.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/pci.c | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d65d315..573bebc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_PCI_HOST_GENERIC if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 023b983..a0929a6 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -60,12 +59,3 @@ int pcibios_add_device(struct pci_dev *dev)
 
 	return 0;
 }
-
-#ifdef CONFIG_ACPI
-/* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	/* TODO: Should be revisited when implementing PCI on ACPI */
-	return NULL;
-}
-#endif
-- 
1.9.1
