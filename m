From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 12/14] sony-laptop: Make sony_pic_set_wwanpower not take mutexes
Date: Thu, 26 Mar 2009 21:58:23 +0900
Message-ID: <1238072305-8085-13-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
 <1238072305-8085-6-git-send-email-malattia@linux.it>
 <1238072305-8085-7-git-send-email-malattia@linux.it>
 <1238072305-8085-8-git-send-email-malattia@linux.it>
 <1238072305-8085-9-git-send-email-malattia@linux.it>
 <1238072305-8085-10-git-send-email-malattia@linux.it>
 <1238072305-8085-11-git-send-email-malattia@linux.it>
 <1238072305-8085-12-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53417
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035AbZCZM6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:30 -0400
In-Reply-To: <1238072305-8085-12-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

For consistency with __sony_pic_set_bluetoothpower, this is also needed
later to allow setting the wwanpower attribute from the resume path and
only lock the mutex once.

Signed-off-by: Mattia Dongili <malattia@linux.it>
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
1.6.2

