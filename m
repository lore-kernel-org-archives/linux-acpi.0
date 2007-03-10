From: Len Brown <len.brown@intel.com>
Subject: [PATCH 17/20] asus-laptop: make code static
Date: Fri,  9 Mar 2007 22:49:35 -0500
Message-ID: <11734985922550-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com> <11734985882949-git-send-email-len.brown@intel.com> <11734985891723-git-send-email-len.brown@intel.com> <11734985892382-git-send-email-len.brown@intel.com> <11734985901640-git-send-email-len.brown@intel.com> <11734985912054-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965845AbXCJDtx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:53 -0500
In-Reply-To: <11734985912054-git-send-email-len.brown@intel.com>
Message-Id: <f110ef58e6c9bd562999247c5e8a5b8e722fbd11.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@stusta.de>

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 295e931..4b23212 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -211,7 +211,7 @@ static struct workqueue_struct *led_workqueue;
 				     enum led_brightness value);	\
 	static void object##_led_update(struct work_struct *ignored);	\
 	static int object##_led_wk;					\
-	DECLARE_WORK(object##_led_work, object##_led_update);		\
+	static DECLARE_WORK(object##_led_work, object##_led_update);	\
 	static struct led_classdev object##_led = {			\
 		.name           = "asus:" ledname,			\
 		.brightness_set = object##_led_set,			\
-- 
1.5.0.3.310.g05ef5
