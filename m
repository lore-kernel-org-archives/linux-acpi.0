From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v3 1/9] x86,
 pci: Clean up comment about buggy MMIO config space access for AMD
 Fam10h CPUs.
Date: Tue, 10 Mar 2015 12:35:12 +0100
Message-ID: <1425987320-15020-2-git-send-email-tomasz.nowicki@linaro.org>
References: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de, hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, al.stone@linaro.org
Cc: linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

- fix typo
- improve explanation
- add reference to the related document

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/include/asm/pci_x86.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index fa1195d..d024f4d 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -152,10 +152,13 @@ extern struct list_head pci_mmcfg_list;
 
 /*
  * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
- * on their northbrige except through the * %eax register. As such, you MUST
- * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
+ * on their northbridge except through the * %eax register. As such, you MUST
+ * NOT use normal IOMEM accesses, you need to only use the magic mmio_config_*
  * accessor functions.
- * In fact just use pci_config_*, nothing else please.
+ *
+ * Please refer to the following doc:
+ * "BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors",
+ * rev. 3.48, sec 2.11.1, "MMIO Configuration Coding Requirements".
  */
 static inline unsigned char mmio_config_readb(void __iomem *pos)
 {
-- 
1.9.1
