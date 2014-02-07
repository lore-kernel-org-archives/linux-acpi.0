From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Sat,  8 Feb 2014 02:28:52 +0700
Message-ID: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48197 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaBGTbA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Feb 2014 14:31:00 -0500
Received: by mail-lb0-f181.google.com with SMTP id z11so1974817lbi.26
        for <linux-acpi@vger.kernel.org>; Fri, 07 Feb 2014 11:30:58 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexander Mezin <mezin.alexander@gmail.com>

Do the same thing as in acpi_ac_resume.

BIOS on my laptop (HP Pavilion dv6-6179er) don't send proper
notifications when AC adapter is plugged/unplugged.
This change makes it possible to workaround the problem by using
acpid and a shell script.

This patch has the same effect as
commit 50a2bc5429f07ec4d53df2d287b03bdbceb281bb
"ACPI / AC: change notification handler type to ACPI_ALL_NOTIFY"

Aforementioned commit could be reverted.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/ac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index e7515aa..cdba639 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -90,12 +90,16 @@ static int get_ac_property(struct power_supply *psy,
 			   union power_supply_propval *val)
 {
 	struct acpi_ac *ac = to_acpi_ac(psy);
+	unsigned long long old_state;
 
 	if (!ac)
 		return -ENODEV;
 
+	old_state = ac->state;
 	if (acpi_ac_get_state(ac))
 		return -ENODEV;
+	if (old_state != ac->state)
+		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-- 
1.8.5.4

