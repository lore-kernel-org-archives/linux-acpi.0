From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/5] Bluetooth: hci_bcm: Remove needless acpi_match_device() call
Date: Wed, 30 Sep 2015 16:26:43 +0300
Message-ID: <1443619605-19320-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

There is no need to call acpi_match_device() in driver's probe path and
verify does it find a match to given ACPI _HIDs in .acpi_match_table as
driver/platform/acpi core code has found the match prior calling the probe.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5375c9c04fda..a1b9bbcbcb79 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -647,16 +647,11 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
-	const struct acpi_device_id *id;
 	struct acpi_device *adev;
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
 	int ret;
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-
 	/* Retrieve GPIO data */
 	dev->name = dev_name(&pdev->dev);
 	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
-- 
2.5.3
