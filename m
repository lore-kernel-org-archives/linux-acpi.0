From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/5] Bluetooth: hci_bcm: Add missing acpi_dev_free_resource_list()
Date: Wed, 30 Sep 2015 16:26:41 +0300
Message-ID: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46685 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbbI3N0w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Sep 2015 09:26:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Frederic Danis <frederic.danis@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Caller of acpi_dev_get_resources() should free the constructed resource
list by calling the acpi_dev_free_resource_list() in order to avoid memory
leak.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Call to acpi_dev_get_resources() was introduced by the commit ae056908862b
("Bluetooth: hci_bcm: Retrieve UART speed from ACPI") so fix should go to
v4.3-rc.
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0c791ac279d0..1a538ad6bf2b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -706,6 +706,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 		return 0;
 
 	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+	acpi_dev_free_resource_list(&resources);
 
 	dmi_id = dmi_first_match(bcm_wrong_irq_dmi_table);
 	if (dmi_id) {
-- 
2.5.3

