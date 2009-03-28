From: Len Brown <lenb@kernel.org>
Subject: [PATCH 66/98] sony-laptop: Make sony_pic_set_wwanpower not take mutexes
Date: Sat, 28 Mar 2009 00:31:41 -0400
Message-ID: <c9f1e6f67ad6d16c11586a4550fd054d7538eb92.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22659 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbZC1Ed3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:29 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LCJ8NRSB5R@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:28 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

For consistency with __sony_pic_set_bluetoothpower, this is also needed
later to allow setting the wwanpower attribute from the resume path and
only lock the mutex once.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3575a2d..8796dc6 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2001,18 +2001,14 @@ int sony_pic_camera_command(int command, u8 value)
 EXPORT_SYMBOL(sony_pic_camera_command);
 
 /* gprs/edge modem (SZ460N and SZ210P), thanks to Joshua Wise */
-static void sony_pic_set_wwanpower(u8 state)
+static void __sony_pic_set_wwanpower(u8 state)
 {
 	state = !!state;
-	mutex_lock(&spic_dev.lock);
-	if (spic_dev.wwan_power == state) {
-		mutex_unlock(&spic_dev.lock);
+	if (spic_dev.wwan_power == state)
 		return;
-	}
 	sony_pic_call2(0xB0, state);
 	sony_pic_call1(0x82);
 	spic_dev.wwan_power = state;
-	mutex_unlock(&spic_dev.lock);
 }
 
 static ssize_t sony_pic_wwanpower_store(struct device *dev,
@@ -2024,7 +2020,9 @@ static ssize_t sony_pic_wwanpower_store(struct device *dev,
 		return -EINVAL;
 
 	value = simple_strtoul(buffer, NULL, 10);
-	sony_pic_set_wwanpower(value);
+	mutex_lock(&spic_dev.lock);
+	__sony_pic_set_wwanpower(value);
+	mutex_unlock(&spic_dev.lock);
 
 	return count;
 }
-- 
1.6.0.6

