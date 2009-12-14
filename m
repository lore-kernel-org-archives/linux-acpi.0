From: Justin Mattock <justinmattock@gmail.com>
Subject: [PATCH] Fix a typo in drivers/acpi/battery.c
Date: Sun, 13 Dec 2009 18:34:02 -0800
Message-ID: <dd18b0c30912131834se50a980hff01fe06751f3a2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63577 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbZLNCeG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Dec 2009 21:34:06 -0500
Received: by pzk1 with SMTP id 1so1952548pzk.33
        for <linux-acpi@vger.kernel.org>; Sun, 13 Dec 2009 18:34:02 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>

>From d77442e6ec529d4b675e2cd63ef91ecacbab0d42 Mon Sep 17 00:00:00 2001
From: Justin P. Mattock <justinmattock@gmail.com>
Date: Sun, 13 Dec 2009 14:42:36 -0800
Subject: [PATCH] Fix a typo in drivers/acpi/battery.c


Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3f4602b..cada73f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -831,7 +831,7 @@ static void acpi_battery_notify(struct acpi_device
*device, u32 event)
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
-	/* acpi_batter_update could remove power_supply object */
+	/* acpi_battery_update could remove power_supply object */
 	if (battery->bat.dev)
 		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
 #endif
-- 
1.6.5.5

-- 
Justin P. Mattock
