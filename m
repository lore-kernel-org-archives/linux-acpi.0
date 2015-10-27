From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 09/11] x86,
 pci: Use previously added ECAM hot_added flag to remove ECAM regions.
Date: Tue, 27 Oct 2015 17:38:40 +0100
Message-ID: <1445963922-22711-10-git-send-email-tn@semihalf.com>
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

Now that we have hot_added flag we can get rid of arch specific mcfg_added.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/x86/pci/acpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 28c9cd6..b4ef761 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -13,7 +13,6 @@ struct pci_root_info {
 	struct acpi_pci_root_info common;
 	struct pci_sysdata sd;
 #ifdef	CONFIG_PCI_MMCONFIG
-	bool mcfg_added;
 	u8 start_bus;
 	u8 end_bus;
 #endif
@@ -188,7 +187,6 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 	info = container_of(ci, struct pci_root_info, common);
 	info->start_bus = (u8)root->secondary.start;
 	info->end_bus = (u8)root->secondary.end;
-	info->mcfg_added = false;
 	seg = info->sd.domain;
 
 	/* return success if MMCFG is not in use */
@@ -204,7 +202,6 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 		/* enable MMCFG if it hasn't been enabled yet */
 		if (raw_pci_ext_ops == NULL)
 			raw_pci_ext_ops = &pci_mmcfg;
-		info->mcfg_added = true;
 	} else if (result != -EEXIST)
 		return check_segment(seg, dev,
 			 "fail to add MMCONFIG information,");
@@ -214,14 +211,17 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 
 static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 {
+	struct pci_mmcfg_region *cfg;
 	struct pci_root_info *info;
 
 	info = container_of(ci, struct pci_root_info, common);
-	if (info->mcfg_added) {
-		pci_mmconfig_delete(info->sd.domain,
-				    info->start_bus, info->end_bus);
-		info->mcfg_added = false;
-	}
+	cfg = pci_mmconfig_lookup(info->sd.domain, info->start_bus);
+	if (!cfg)
+		return;
+
+	if (cfg->hot_added)
+		pci_mmconfig_delete(info->sd.domain, info->start_bus,
+				    info->end_bus);
 }
 #else
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
-- 
1.9.1
