From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v8 06/21] ARM64 / ACPI: Introduce PCI stub functions for ACPI
Date: Mon,  2 Feb 2015 20:45:34 +0800
Message-ID: <1422881149-8177-7-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, wangyijing@huawei.com, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Ashwin Chaugule <ashwinc@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
world we will have PCIe in most cases, but some of them may not,
make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.

With that case, we need some arch dependent PCI functions to
access the config space before the PCI root bridge is created, and
pci_acpi_scan_root() to create the PCI root bus. So introduce
some stub function here to make ACPI core compile and revisit
them later when implemented on ARM64.

CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/pci.h |  6 ++++++
 arch/arm64/kernel/pci.c      | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 872ba93..fded096 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -24,6 +24,12 @@
  */
 #define PCI_DMA_BUS_IS_PHYS	(0)
 
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQ on arm64 */
+	return -ENODEV;
+}
+
 extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_PCI
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index ce5836c..c17e7ea 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -68,3 +69,27 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 	bus->domain_nr = domain;
 }
 #endif
+
+/*
+ * raw_pci_read/write - Platform-specific PCI config space access.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 *val)
+{
+	return -EINVAL;
+}
+
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 val)
+{
+	return -EINVAL;
+}
+
+#ifdef CONFIG_ACPI
+/* Root bridge scanning */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	/* TODO: Should be revisited when implementing PCI on ACPI */
+	return NULL;
+}
+#endif
-- 
1.9.1
