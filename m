From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI/AC: add check the return value of power_supply_regiester()
Date: Wed,  4 Jul 2012 13:33:43 +0800
Message-ID: <1341380023-5713-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47466 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933531Ab2GDFmK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Jul 2012 01:42:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org

In the ac.c, lack check return value of power_supply_register().
This may casue that acpi driver's add() ops was called successful
while the device may be failed to be initalized. For example, some
ugly bios may describe two ACADs in the same dsdt. They use the same
name which will cause the second ACAD device can no be registered.
And then power_supply_register() failed. But acpi driver's add() ops
is called sucessfully. The acpi device also will receive acpi notification
and cause oops.
	https://bugzilla.redhat.com/show_bug.cgi?id=772730

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/ac.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 6512b20..d1fcbc0 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -292,7 +292,9 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger.properties = ac_props;
 	ac->charger.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger.get_property = get_ac_property;
-	power_supply_register(&ac->device->dev, &ac->charger);
+	result = power_supply_register(&ac->device->dev, &ac->charger);
+	if (result)
+		goto end;
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
-- 
1.7.6.rc2.8.g28eb

