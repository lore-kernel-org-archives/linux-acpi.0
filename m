From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/5] Bluetooth: hci_bcm: Handle possible error from acpi_dev_get_resources()
Date: Wed, 30 Sep 2015 16:26:42 +0300
Message-ID: <1443619605-19320-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Driver doesn't handle possible error from acpi_dev_get_resources(). Test it
and return the error code in case of error.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a538ad6bf2b..5375c9c04fda 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -705,7 +705,9 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (!adev)
 		return 0;
 
-	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+	ret = acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+	if (ret < 0)
+		return ret;
 	acpi_dev_free_resource_list(&resources);
 
 	dmi_id = dmi_first_match(bcm_wrong_irq_dmi_table);
-- 
2.5.3
