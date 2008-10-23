From: Len Brown <lenb@kernel.org>
Subject: [PATCH 067/122] asus-laptop: Fix the led behavior with value > 1
Date: Thu, 23 Oct 2008 02:38:41 -0400
Message-ID: <e3deda9c87ac5eef2b5d18cd0b5511370979ca26.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbYJWGkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600JX9IIVBGRA@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:07 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Fix http://bugzilla.kernel.org/show_bug.cgi?id=11613 .

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index df82cda..57d81c7 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -351,7 +351,7 @@ static void write_status(acpi_handle handle, int out, int mask)
 	static void object##_led_set(struct led_classdev *led_cdev,	\
 				     enum led_brightness value)		\
 	{								\
-		object##_led_wk = value;				\
+		object##_led_wk = (value > 0) ? 1 : 0;			\
 		queue_work(led_workqueue, &object##_led_work);		\
 	}								\
 	static void object##_led_update(struct work_struct *ignored)	\
-- 
1.5.5.1

