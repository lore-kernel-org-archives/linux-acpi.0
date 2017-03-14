From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] PCI: For d3_delay and d3cold_delay, zero means zero
Date: Tue, 14 Mar 2017 11:44:56 +0200
Message-ID: <1489484696-14093-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:24563 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdCNJu2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 05:50:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Do not sleep at all for the respective cases of d3_delay is zero or
d3cold_delay is zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02ffdb9..9779483f81fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -66,7 +66,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 	if (delay < pci_pm_d3_delay)
 		delay = pci_pm_d3_delay;
 
-	msleep(delay);
+	if (delay)
+		msleep(delay);
 }
 
 #ifdef CONFIG_PCI_DOMAINS
@@ -827,7 +828,8 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
 		 * because have already delayed for the bridge.
 		 */
 		if (dev->runtime_d3cold) {
-			msleep(dev->d3cold_delay);
+			if (dev->d3cold_delay)
+				msleep(dev->d3cold_delay);
 			/*
 			 * When powering on a bridge from D3cold, the
 			 * whole hierarchy may be powered on into
-- 
1.9.1

