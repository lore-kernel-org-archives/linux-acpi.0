From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/5] Bluetooth: hci_bcm: Do not test ACPI companion in bcm_acpi_probe()
Date: Wed, 30 Sep 2015 16:26:45 +0300
Message-ID: <1443619605-19320-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This device has always ACPI companion because driver supports only ACPI
enumeration. Therefore there is no need to test it in bcm_acpi_probe() and
we can pass it directly to acpi_dev_get_resources() (which will return
-EINVAL in case of NULL argument is passed).

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 967d16692925..512873262055 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -647,7 +647,6 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
-	struct acpi_device *adev;
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
 	int ret;
@@ -696,11 +695,8 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	}
 
 	/* Retrieve UART ACPI info */
-	adev = ACPI_COMPANION(&dev->pdev->dev);
-	if (!adev)
-		return 0;
-
-	ret = acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+	ret = acpi_dev_get_resources(ACPI_COMPANION(&dev->pdev->dev),
+				     &resources, bcm_resource, dev);
 	if (ret < 0)
 		return ret;
 	acpi_dev_free_resource_list(&resources);
-- 
2.5.3
