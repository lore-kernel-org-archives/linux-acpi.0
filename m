From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for ACPI
Date: Tue, 26 May 2015 20:49:14 +0800
Message-ID: <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
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

ARM64 ACPI based PCI host bridge init needs a arch dependent
struct pci_controller to accommodate common PCI host bridge
code which is introduced later, or it will lead to compile
errors on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b008a72..7088495 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -10,6 +10,16 @@
 #include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci-dma-compat.h>
 
+struct acpi_device;
+
+struct pci_controller {
+#ifdef CONFIG_ACPI
+	struct acpi_device *companion;	/* ACPI companion device */
+#endif
+	int		segment;	/* PCI domain */
+	int		node;		/* NUMA node */
+};
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0
 
-- 
1.9.1
