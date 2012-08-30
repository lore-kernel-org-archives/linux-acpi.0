From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 4/4] libata: acpi: respect may_power_off flag
Date: Thu, 30 Aug 2012 14:40:18 +0800
Message-ID: <1346308818-27039-5-git-send-email-aaron.lu@intel.com>
References: <1346308818-27039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59606 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab2H3GmD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Aug 2012 02:42:03 -0400
In-Reply-To: <1346308818-27039-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>

If user does not want the device being powered off when runtime
suspended by setting may_power_off flag to 0, we will not choose D3 cold
ACPI D-State for it in sata_acpi_set_state.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 67a696f..90c42a0 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -848,7 +848,9 @@ static void sata_acpi_set_state(struct ata_port *ap, pm_message_t state)
 
 		if (state.event == PM_EVENT_AUTO_SUSPEND) {
 			acpi_state = acpi_pm_device_sleep_state(
-				&dev->sdev->sdev_gendev, NULL, ACPI_STATE_D3);
+				&dev->sdev->sdev_gendev, NULL,
+				dev->sdev->may_power_off ?
+				ACPI_STATE_D3_COLD : ACPI_STATE_D3_HOT);
 			if (acpi_state > 0)
 				acpi_bus_set_power(handle, acpi_state);
 			acpi_pm_device_run_wake(&dev->sdev->sdev_gendev, true);
-- 
1.7.11.5

