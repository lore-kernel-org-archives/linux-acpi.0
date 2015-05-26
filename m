From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 07/11] x86, pci: mmconfig_{32,
 64}.c code refactoring - remove code duplication.
Date: Tue, 26 May 2015 20:49:20 +0800
Message-ID: <1432644564-24746-8-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, Yijing Wang <wangyijing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

mmconfig_64.c version is going to be default implementation for arch
agnostic low-level direct PCI config space accessors for ECAM dirver.
However, now it initialize raw_pci_ext_ops pointer which is x86 specific
code only. Moreover, mmconfig_32.c is doing the same thing at the same time.

Move it to mmconfig_shared.c so it becomes common for both and
mmconfig_64.c turns out to be purely arch agnostic.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/x86/pci/mmconfig-shared.c | 10 ++++++++--
 arch/x86/pci/mmconfig_32.c     | 10 ++--------
 arch/x86/pci/mmconfig_64.c     | 11 ++---------
 include/linux/ecam.h           |  5 +++++
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 6fa3080..8938db3 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -29,6 +29,11 @@
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 
+const struct pci_raw_ops pci_mmcfg = {
+	.read =		pci_mmcfg_read,
+	.write =	pci_mmcfg_write,
+};
+
 static u32
 pci_mmconfig_amd_read(int len, void __iomem *addr)
 {
@@ -555,9 +560,10 @@ static void __init __pci_mmcfg_init(int early)
 		}
 	}
 
-	if (pci_mmcfg_arch_init())
+	if (pci_mmcfg_arch_init()) {
+		raw_pci_ext_ops = &pci_mmcfg;
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
-	else {
+	} else {
 		free_all_mmcfg();
 		pci_mmcfg_arch_init_failed = true;
 	}
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 5cf6291..7a050cb 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -50,7 +50,7 @@ static void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
 	}
 }
 
-static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
@@ -79,7 +79,7 @@ err:		*value = -1;
 	return 0;
 }
 
-static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
@@ -106,15 +106,9 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-const struct pci_raw_ops pci_mmcfg = {
-	.read =		pci_mmcfg_read,
-	.write =	pci_mmcfg_write,
-};
-
 int __init pci_mmcfg_arch_init(void)
 {
 	printk(KERN_INFO "PCI: Using MMCONFIG for extended config space\n");
-	raw_pci_ext_ops = &pci_mmcfg;
 	return 1;
 }
 
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index b62ff18..fd857ea 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -25,7 +25,7 @@ static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned i
 	return NULL;
 }
 
-static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	char __iomem *addr;
@@ -49,7 +49,7 @@ err:		*value = -1;
 	return 0;
 }
 
-static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	char __iomem *addr;
@@ -71,11 +71,6 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-const struct pci_raw_ops pci_mmcfg = {
-	.read =		pci_mmcfg_read,
-	.write =	pci_mmcfg_write,
-};
-
 static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
 {
 	void __iomem *addr;
@@ -101,8 +96,6 @@ int __init pci_mmcfg_arch_init(void)
 			return 0;
 		}
 
-	raw_pci_ext_ops = &pci_mmcfg;
-
 	return 1;
 }
 
diff --git a/include/linux/ecam.h b/include/linux/ecam.h
index 2387df5..fba5d6b 100644
--- a/include/linux/ecam.h
+++ b/include/linux/ecam.h
@@ -47,5 +47,10 @@ extern struct list_head pci_mmcfg_list;
 
 #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
 
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+		   unsigned int devfn, int reg, int len, u32 *value);
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+		    unsigned int devfn, int reg, int len, u32 value);
+
 #endif  /* __KERNEL__ */
 #endif  /* __ECAM_H */
-- 
1.9.1
