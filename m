From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V8 3/9] pci: Add new function to unmap IO resources.
Date: Mon, 30 May 2016 17:14:16 +0200
Message-ID: <1464621262-26770-4-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com
Cc: jcm@redhat.com, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, dhdang@apm.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, jeremy.linton@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, cov@codeaurora.org, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, wangyijing@huawei.com, Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, andrea.gallo@linaro.org, linux-arm-kernel@lists.infradead.org, liudongdong3@huawei.com
List-Id: linux-acpi@vger.kernel.org

We need to release I/O resources so that the same I/O resources
can be allocated again (pci_remap_iospace), like in PCI hotplug removal
scenario. Therefore this patch implements new pci_unmap_iospace call which
unmaps I/O space as the symmetry to pci_remap_iospace.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/pci.c   | 18 ++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..eb431b5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
+#include <linux/vmalloc.h>
 #include <asm/setup.h>
 #include <linux/aer.h>
 #include "pci.h"
@@ -3165,6 +3166,23 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 #endif
 }
 
+/**
+ *	pci_unmap_iospace - Unmap the memory mapped I/O space
+ *	@res: resource to be unmapped
+ *
+ *	Unmap the CPU virtual address @res from virtual address space.
+ *	Only architectures that have memory mapped IO functions defined
+ *	(and the PCI_IOBASE value defined) should call this function.
+ */
+void pci_unmap_iospace(struct resource *res)
+{
+#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
+	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
+
+	unmap_kernel_range(vaddr, resource_size(res));
+#endif
+}
+
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..12349de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1167,6 +1167,7 @@ int pci_register_io_range(phys_addr_t addr, resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+void pci_unmap_iospace(struct resource *res);
 
 static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
 {
-- 
1.9.1
