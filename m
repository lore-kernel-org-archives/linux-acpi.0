From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 4/5] x86: pmc_atom: clean up init function
Date: Wed, 14 Jan 2015 18:39:34 +0200
Message-ID: <1421253575-22509-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

There is no need to use err variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 arch/x86/kernel/pmc_atom.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 6b62f55..f8becc4 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -288,7 +288,6 @@ MODULE_DEVICE_TABLE(pci, pmc_pci_ids);
 
 static int __init pmc_atom_init(void)
 {
-	int err = -ENODEV;
 	struct pci_dev *pdev = NULL;
 	const struct pci_device_id *ent;
 
@@ -302,14 +301,11 @@ static int __init pmc_atom_init(void)
 	 */
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(pmc_pci_ids, pdev);
-		if (ent) {
-			err = pmc_setup_dev(pdev);
-			goto out;
-		}
+		if (ent)
+			return pmc_setup_dev(pdev);
 	}
 	/* Device not found. */
-out:
-	return err;
+	return -ENODEV;
 }
 
 module_init(pmc_atom_init);
-- 
2.1.4
