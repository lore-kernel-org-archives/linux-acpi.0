From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/84] PCI ACPI: Drop the second argument of
 platform_pci_choose_state
Date: Sat, 28 Jun 2008 01:43:28 -0400
Message-ID: <d40f76ca5c165c9ff1490bbbdb34c520d7155c1f.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:36217 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbYF1FpE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:04 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K350037IRYYV4XD@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:59 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Since the second argument of acpi_pci_choose_state() and
platform_pci_choose_state() is never used, remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |    3 +--
 drivers/pci/pci.c      |    4 ++--
 drivers/pci/pci.h      |    3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index caabf05..dab9d47 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -293,8 +293,7 @@ EXPORT_SYMBOL(pci_osc_control_set);
  * 	choose highest power _SxD or any lower power
  */
 
-static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
-	pm_message_t state)
+static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e4548ab..75c6023 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -508,7 +508,7 @@ pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	return 0;
 }
 
-pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
  
 /**
  * pci_choose_state - Choose the power state of a PCI device
@@ -528,7 +528,7 @@ pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 		return PCI_D0;
 
 	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
+		ret = platform_pci_choose_state(dev);
 		if (ret != PCI_POWER_ERROR)
 			return ret;
 	}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0a497c1..ff30b3c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,8 +6,7 @@ extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
 
 /* Firmware callbacks */
-extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev,
-						pm_message_t state);
+extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev,
 						pci_power_t state);
 
-- 
1.5.6.1.89.gd544

