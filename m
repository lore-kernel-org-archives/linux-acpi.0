From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/5] x86: pmc-atom: assign debugfs node as soon as possible
Date: Wed, 14 Jan 2015 18:39:31 +0200
Message-ID: <1421253575-22509-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58264 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbbANQjg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jan 2015 11:39:36 -0500
In-Reply-To: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

pmc_dbgfs_unregister() will be called when pmc->dbgfs_dir is unconditionally
NULL on error path in pmc_dbgfs_register(). To prevent this we move an
assignment to where is should be.

Fixes: f855911c1f48 (x86/pmc_atom: Expose PMC device state and platform sleep state)
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/pmc_atom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 0ee5025e..8bb9a61 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -217,6 +217,8 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
 	if (!dir)
 		return -ENOMEM;
 
+	pmc->dbgfs_dir = dir;
+
 	f = debugfs_create_file("dev_state", S_IFREG | S_IRUGO,
 				dir, pmc, &pmc_dev_state_ops);
 	if (!f) {
@@ -229,7 +231,7 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
 		dev_err(&pdev->dev, "sleep_state register failed\n");
 		goto err;
 	}
-	pmc->dbgfs_dir = dir;
+
 	return 0;
 err:
 	pmc_dbgfs_unregister(pmc);
-- 
2.1.4

