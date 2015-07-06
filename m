From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/5] x86: pmc_atom: export accessors to PMC registers
Date: Mon,  6 Jul 2015 17:29:00 +0300
Message-ID: <1436192944-56496-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Export pmc_atom_read() and pmc_atom_write() accessors to the PMC registers. On
early initcall stages the functions will return -ENODEV, and caller has to wait
when it will be available. Additionally make absence of debugfs a non-fatal
error.

The patch will be useful for the upcoming fixes regarding to LPSS block found
on Intel BayTrail-T and Braswell.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/pmc_atom.h |  4 ++++
 arch/x86/kernel/pmc_atom.c      | 49 ++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pmc_atom.h b/arch/x86/include/asm/pmc_atom.h
index bc0fc08..6ee2200 100644
--- a/arch/x86/include/asm/pmc_atom.h
+++ b/arch/x86/include/asm/pmc_atom.h
@@ -126,4 +126,8 @@
 #define	SLEEP_TYPE_MASK		0xFFFFECFF
 #define	SLEEP_TYPE_S5		0x1C00
 #define	SLEEP_ENABLE		0x2000
+
+extern int pmc_atom_read(int offset, u32 *value);
+extern int pmc_atom_write(int offset, u32 value);
+
 #endif /* PMC_ATOM_H */
diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index d66a4fe..4e1242e 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -31,6 +31,7 @@ struct pmc_dev {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
+	bool init;
 };
 
 static struct pmc_dev pmc_device;
@@ -111,6 +112,30 @@ static inline void pmc_reg_write(struct pmc_dev *pmc, int reg_offset, u32 val)
 	writel(val, pmc->regmap + reg_offset);
 }
 
+int pmc_atom_read(int offset, u32 *value)
+{
+	struct pmc_dev *pmc = &pmc_device;
+
+	if (!pmc->init)
+		return -ENODEV;
+
+	*value = pmc_reg_read(pmc, offset);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmc_atom_read);
+
+int pmc_atom_write(int offset, u32 value)
+{
+	struct pmc_dev *pmc = &pmc_device;
+
+	if (!pmc->init)
+		return -ENODEV;
+
+	pmc_reg_write(pmc, offset, value);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmc_atom_write);
+
 static void pmc_power_off(void)
 {
 	u16	pm1_cnt_port;
@@ -250,7 +275,7 @@ static void pmc_dbgfs_unregister(struct pmc_dev *pmc)
 	debugfs_remove_recursive(pmc->dbgfs_dir);
 }
 
-static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
+static int pmc_dbgfs_register(struct pmc_dev *pmc)
 {
 	struct dentry *dir, *f;
 
@@ -262,24 +287,18 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
 
 	f = debugfs_create_file("dev_state", S_IFREG | S_IRUGO,
 				dir, pmc, &pmc_dev_state_ops);
-	if (!f) {
-		dev_err(&pdev->dev, "dev_state register failed\n");
+	if (!f)
 		goto err;
-	}
 
 	f = debugfs_create_file("pss_state", S_IFREG | S_IRUGO,
 				dir, pmc, &pmc_pss_state_ops);
-	if (!f) {
-		dev_err(&pdev->dev, "pss_state register failed\n");
+	if (!f)
 		goto err;
-	}
 
 	f = debugfs_create_file("sleep_state", S_IFREG | S_IRUGO,
 				dir, pmc, &pmc_sleep_tmr_ops);
-	if (!f) {
-		dev_err(&pdev->dev, "sleep_state register failed\n");
+	if (!f)
 		goto err;
-	}
 
 	return 0;
 err:
@@ -287,7 +306,7 @@ err:
 	return -ENODEV;
 }
 #else
-static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
+static int pmc_dbgfs_register(struct pmc_dev *pmc)
 {
 	return 0;
 }
@@ -318,11 +337,11 @@ static int pmc_setup_dev(struct pci_dev *pdev)
 	/* PMC hardware registers setup */
 	pmc_hw_reg_setup(pmc);
 
-	ret = pmc_dbgfs_register(pmc, pdev);
-	if (ret) {
-		iounmap(pmc->regmap);
-	}
+	ret = pmc_dbgfs_register(pmc);
+	if (ret)
+		dev_warn(&pdev->dev, "debugfs register failed\n");
 
+	pmc->init = true;
 	return ret;
 }
 
-- 
2.1.4
