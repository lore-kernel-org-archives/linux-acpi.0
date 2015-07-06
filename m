From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] x86: pmc_atom: supply register mappings via pmc object
Date: Mon,  6 Jul 2015 17:29:02 +0300
Message-ID: <1436192944-56496-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The patch converts the functions to use the register mappings provided by pmc
object. It would help in case of mappings on different platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/pmc_atom.c | 49 ++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index c7dca07..4752b1a62 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -25,9 +25,20 @@
 
 #include <asm/pmc_atom.h>
 
+struct pmc_bit_map {
+	const char *name;
+	u32 bit_mask;
+};
+
+struct pmc_reg_map {
+	const struct pmc_bit_map *dev;
+	const struct pmc_bit_map *pss;
+};
+
 struct pmc_dev {
 	u32 base_addr;
 	void __iomem *regmap;
+	const struct pmc_reg_map *map;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
@@ -37,11 +48,6 @@ struct pmc_dev {
 static struct pmc_dev pmc_device;
 static u32 acpi_base_addr;
 
-struct pmc_bit_map {
-	const char *name;
-	u32 bit_mask;
-};
-
 static const struct pmc_bit_map dev_map[] = {
 	{"LPSS1_F0_DMA",	BIT_LPSS1_F0_DMA},
 	{"LPSS1_F1_PWM1",	BIT_LPSS1_F1_PWM1},
@@ -104,6 +110,11 @@ static const struct pmc_bit_map pss_map[] = {
 	{},
 };
 
+static const struct pmc_reg_map reg_map = {
+	.dev		= dev_map,
+	.pss		= pss_map,
+};
+
 static inline u32 pmc_reg_read(struct pmc_dev *pmc, int reg_offset)
 {
 	return readl(pmc->regmap + reg_offset);
@@ -172,17 +183,18 @@ static void pmc_hw_reg_setup(struct pmc_dev *pmc)
 static int pmc_dev_state_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmc = s->private;
+	const struct pmc_bit_map *map = pmc->map->dev;
 	u32 func_dis, func_dis_2, func_dis_index;
 	u32 d3_sts_0, d3_sts_1, d3_sts_index;
-	int dev_index, reg_index;
+	int index, reg_index;
 
 	func_dis = pmc_reg_read(pmc, PMC_FUNC_DIS);
 	func_dis_2 = pmc_reg_read(pmc, PMC_FUNC_DIS_2);
 	d3_sts_0 = pmc_reg_read(pmc, PMC_D3_STS_0);
 	d3_sts_1 = pmc_reg_read(pmc, PMC_D3_STS_1);
 
-	for (dev_index = 0; dev_map[dev_index].name; dev_index++) {
-		reg_index = dev_index / PMC_REG_BIT_WIDTH;
+	for (index = 0; map[index].name; index++) {
+		reg_index = index / PMC_REG_BIT_WIDTH;
 		if (reg_index) {
 			func_dis_index = func_dis_2;
 			d3_sts_index = d3_sts_1;
@@ -192,10 +204,10 @@ static int pmc_dev_state_show(struct seq_file *s, void *unused)
 		}
 
 		seq_printf(s, "Dev: %-2d - %-32s\tState: %s [%s]\n",
-			dev_index, dev_map[dev_index].name,
-			dev_map[dev_index].bit_mask & func_dis_index ?
+			index, map[index].name,
+			map[index].bit_mask & func_dis_index ?
 			"Disabled" : "Enabled ",
-			dev_map[dev_index].bit_mask & d3_sts_index ?
+			map[index].bit_mask & d3_sts_index ?
 			"D3" : "D0");
 	}
 	return 0;
@@ -216,13 +228,14 @@ static const struct file_operations pmc_dev_state_ops = {
 static int pmc_pss_state_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmc = s->private;
+	const struct pmc_bit_map *map = pmc->map->pss;
 	u32 pss = pmc_reg_read(pmc, PMC_PSS);
-	int pss_index;
+	int index;
 
-	for (pss_index = 0; pss_map[pss_index].name; pss_index++) {
+	for (index = 0; map[index].name; index++) {
 		seq_printf(s, "Island: %-2d - %-32s\tState: %s\n",
-			pss_index, pss_map[pss_index].name,
-			pss_map[pss_index].bit_mask & pss ? "Off" : "On");
+			index, map[index].name,
+			map[index].bit_mask & pss ? "Off" : "On");
 	}
 	return 0;
 }
@@ -312,7 +325,7 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static int pmc_setup_dev(struct pci_dev *pdev)
+static int pmc_setup_dev(struct pci_dev *pdev, const struct pmc_reg_map *map)
 {
 	struct pmc_dev *pmc = &pmc_device;
 	int ret;
@@ -334,6 +347,8 @@ static int pmc_setup_dev(struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
+	pmc->map = map;
+
 	/* PMC hardware registers setup */
 	pmc_hw_reg_setup(pmc);
 
@@ -376,7 +391,7 @@ static int __init pmc_atom_init(void)
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(pmc_pci_ids, pdev);
 		if (ent)
-			return pmc_setup_dev(pdev);
+			return pmc_setup_dev(pdev, &reg_map);
 	}
 	/* Device not found. */
 	return -ENODEV;
-- 
2.1.4
