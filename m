From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] Bluetooth: hci_bcm: Close serdev on failure to set power on bcm_open()
Date: Sun, 21 Jan 2018 22:46:45 +0100
Message-ID: <20180121214645.15004-2-hdegoede@redhat.com>
References: <20180121214645.15004-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbeAUVqw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 21 Jan 2018 16:46:52 -0500
In-Reply-To: <20180121214645.15004-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>

Commit 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
introduced error checking for the bcm_gpio_set_power() call in bcm_open()
but the error-path it introduces does not properly call
serdev_device_close() to undo the earlier serdev_device_open(), this
commit fixes this.

Cc: Lukas Wunner <lukas@wunner.de>
Fixes: 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 61f73cc4c05e..da4736f2e913 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -336,11 +336,13 @@ static int bcm_open(struct hci_uart *hu)
 		hu->oper_speed = bdev->oper_speed;
 		err = bcm_gpio_set_power(bdev, true);
 		if (err)
-			goto err_free;
+			goto err_close_serdev;
 	}
 
 	return 0;
 
+err_close_serdev:
+	serdev_device_close(hu->serdev);
 err_free:
 	hu->priv = NULL;
 	kfree(bcm);
-- 
2.14.3

