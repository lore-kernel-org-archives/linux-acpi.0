From: Len Brown <lenb@kernel.org>
Subject: [PATCH 093/103] battery: fix typo in comment
Date: Wed, 16 Dec 2009 03:36:44 -0500
Message-ID: <2345baf4a8a0ac2e7e83f932048bb2d8ec1287e7.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761858AbZLPJF6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:05:58 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:51 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, Len Brown <len.brown@intel.com>

From: Justin P. Mattock <justinmattock@gmail.com>

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3f4602b..cada73f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -831,7 +831,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
-	/* acpi_batter_update could remove power_supply object */
+	/* acpi_battery_update could remove power_supply object */
 	if (battery->bat.dev)
 		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
 #endif
-- 
1.6.0.6

