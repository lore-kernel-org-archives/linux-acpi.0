From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] pci: Ensure we re-enable devices on resume
Date: Thu, 22 Apr 2010 09:30:51 -0400
Message-ID: <1271943051-2671-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3631 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab0DVRbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Apr 2010 13:31:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jbarnes@virtuousgeek.org
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, achiang@canonical.com, rjw@sisk.pl, Matthew Garrett <mjg@redhat.com>

If the firmware puts a device back into D0 state at resume time, we'll
update its state in resume_noirq and thus skip the platform resume code.
Calling that code twice should be safe and we ought to avoid getting to
that point anyway, so remove the check and also allow the platform pci
code to be called for D0.

Fixes USB not being powered after resume on recent Lenovo machines.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/pci/pci.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ea587e..3749912 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -679,7 +679,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
  */
 int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
 {
-	return state > PCI_D0 ?
+	return state >= PCI_D0 ?
 			pci_platform_power_transition(dev, state) : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
@@ -716,10 +716,6 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		 */
 		return 0;
 
-	/* Check if we're already there */
-	if (dev->current_state == state)
-		return 0;
-
 	__pci_start_power_transition(dev, state);
 
 	/* This device is quirked not to be put into D3, so
-- 
1.7.0.1

