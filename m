From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 06/13] arm64, pci,
 acpi: ACPI support for legacy IRQs parsing and consolidation with DT
 code.
Date: Fri, 15 Apr 2016 19:06:41 +0200
Message-ID: <1460740008-19489-7-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: jcm@redhat.com, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, wangyijing@huawei.com, Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

To enable PCI legacy IRQs on platforms booting with ACPI, arch code
should include ACPI specific callbacks that parse and set-up the
device IRQ number, equivalent to the DT boot path. Owing to the current
ACPI core scan handlers implementation, ACPI PCI legacy IRQs bindings
cannot be parsed at device add time, since that would trigger ACPI scan
handlers ordering issues depending on how the ACPI tables are defined.

To solve this problem and consolidate FW PCI legacy IRQs parsing in
one single pcibios callback (pending final removal), this patch moves
DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
PCI core code at device probe time) and adds ACPI PCI legacy IRQs
parsing to the same callback too, so that FW PCI legacy IRQs parsing
is confined in one single arch callback that can be easily removed
when code parsing PCI legacy IRQs is consolidated and moved to core
PCI code.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index c72de66..15109c11 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -50,11 +50,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 }
 
 /*
- * Try to assign the IRQ number from DT when adding a new device
+ * Try to assign the IRQ number when probing a new device
  */
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+	if (acpi_disabled)
+		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+#ifdef CONFIG_ACPI
+	else
+		return acpi_pci_irq_enable(dev);
+#endif
 
 	return 0;
 }
-- 
1.9.1
