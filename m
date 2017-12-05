From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] ACPI / battery: drop redundant test for failure
Date: Tue,  5 Dec 2017 18:46:39 +0100
Message-ID: <20171205174639.672-1-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:51277 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdLERqv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Dec 2017 12:46:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>

Merging the two adjacent conditionally built blocks makes the code
a lot more readable.  And as a bonus, we drop a duplicate test when
CONFIG_ACPI_PROCFS_POWER is undefined.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/acpi/battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 13e7b56e33ae..f2eb6c37ea0a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1237,13 +1237,11 @@ static int acpi_battery_add(struct acpi_device *device)
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
-#endif
 	if (result) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_battery_remove_fs(device);
-#endif
 		goto fail;
 	}
+#endif
 
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
-- 
2.11.0

