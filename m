From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/6] sony-laptop: SNC input event 38 fix
Date: Sun, 12 Apr 2009 20:26:28 +0900
Message-ID: <1239535591-15514-4-git-send-email-malattia@linux.it>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
 <1239535591-15514-2-git-send-email-malattia@linux.it>
 <1239535591-15514-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41429
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517AbZDLL0d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:33 -0400
In-Reply-To: <1239535591-15514-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>

From: Almer S. Tigelaar <almer@gnome.org>

Fixes the "unknown input event 38" messages. ANYBUTTON_RELEASED is now
treated the same way as FN_KEY_RELEASED.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 7b1da3f..ddbd86b 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -317,7 +317,8 @@ static void sony_laptop_report_input_event(u8 event)
 	struct input_dev *key_dev = sony_laptop_input.key_dev;
 	struct sony_laptop_keypress kp = { NULL };
 
-	if (event == SONYPI_EVENT_FNKEY_RELEASED) {
+	if (event == SONYPI_EVENT_FNKEY_RELEASED ||
+			event == SONYPI_EVENT_ANYBUTTON_RELEASED) {
 		/* Nothing, not all VAIOs generate this event */
 		return;
 	}
-- 
1.6.2.2

