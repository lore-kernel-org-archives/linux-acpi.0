From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 2/5] x86: pmc_atom: don't check for NULL twice
Date: Wed, 14 Jan 2015 18:39:32 +0200
Message-ID: <1421253575-22509-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

debugfs_remove_recursive() is NULL-aware, thus, we may safely remove the check
here. There is no need to assing NULL to variable since it will be not used
anywhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 arch/x86/kernel/pmc_atom.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 8bb9a61..1dd6c62 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -202,11 +202,7 @@ static const struct file_operations pmc_sleep_tmr_ops = {
 
 static void pmc_dbgfs_unregister(struct pmc_dev *pmc)
 {
-	if (!pmc->dbgfs_dir)
-		return;
-
 	debugfs_remove_recursive(pmc->dbgfs_dir);
-	pmc->dbgfs_dir = NULL;
 }
 
 static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
-- 
2.1.4
