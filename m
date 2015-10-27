From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 06/11] pci, acpi,
 mcfg: Provide default RAW ACPI PCI config space accessors.
Date: Tue, 27 Oct 2015 17:38:37 +0100
Message-ID: <1445963922-22711-7-git-send-email-tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445963922-22711-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, Narinder.Dhillon@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, wangyijing@huawei.com, Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jiang.liu@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Lets keep RAW ACPI PCI config space accessors empty by default,
since we are note sure if they are necessary accross all archs.
Once we sort this out, we can provide generic version or let
architectures to overwrite, like now x86.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/mcfg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 745b83e..3e1e7be 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -9,9 +9,30 @@
 
 #include <linux/acpi.h>
 #include <linux/ecam.h>
+#include <linux/pci.h>
 
 #define	PREFIX	"MCFG: "
 
+/*
+ * raw_pci_read/write - raw ACPI PCI config space accessors.
+ *
+ * By defauly (__weak) these accessors are empty and should be overwritten
+ * by architectures which support operations on ACPI PCI_Config regions,
+ * see osl.c file.
+ */
+
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
-- 
1.9.1
