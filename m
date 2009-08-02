From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 7/8] eeepc-laptop: correct the description of the hibernation
 abort bug
Date: Sun, 02 Aug 2009 16:57:18 +0100
Message-ID: <4A75B75E.1040306@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35842 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbZHBP5T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:57:19 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so2535576ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:57:20 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

Actually it is only the LED which is affected.  The bios bug does not
disable the wifi.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 8a32004..df68ae6 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -826,11 +826,10 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 	if (ehotk->wlan_rfkill) {
 		bool wlan;
 
-		/* Workaround - it seems that _PTS disables the wireless
-		   without notification or changing the value read by WLAN.
-		   Normally this is fine because the correct value is restored
-		   from the non-volatile storage on resume, but we need to do
-		   it ourself if case suspend is aborted, or we lose wireless.
+		/*
+		 * Work around bios bug - acpi _PTS turns off the wireless led
+		 * during suspend.  Normally it restores it on resume, but
+		 * we should kick it ourselves in case suspend is aborted.
 		 */
 		wlan = get_acpi(CM_ASL_WLAN);
 		set_acpi(CM_ASL_WLAN, wlan);
-- 
1.6.3.2

