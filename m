From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/5] Bluetooth: hci_bcm: Remove needless looking code
Date: Wed, 30 Sep 2015 16:26:44 +0300
Message-ID: <1443619605-19320-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Tree wide grep for "hci_bcm" doesn't reveal there is any code registering
this platform device and "struct acpi_device_id" use for passing the
platform data looks a debug/test code leftover to me.

I'm assuming this driver effectively supports only ACPI enumeration and
thus test for ACPI_HANDLE() and platform data can be removed.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index a1b9bbcbcb79..967d16692925 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -724,7 +724,6 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 static int bcm_probe(struct platform_device *pdev)
 {
 	struct bcm_device *dev;
-	struct acpi_device_id *pdata = pdev->dev.platform_data;
 	int ret;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
@@ -733,15 +732,9 @@ static int bcm_probe(struct platform_device *pdev)
 
 	dev->pdev = pdev;
 
-	if (ACPI_HANDLE(&pdev->dev)) {
-		ret = bcm_acpi_probe(dev);
-		if (ret)
-			return ret;
-	} else if (pdata) {
-		dev->name = pdata->id;
-	} else {
-		return -ENODEV;
-	}
+	ret = bcm_acpi_probe(dev);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, dev);
 
-- 
2.5.3
