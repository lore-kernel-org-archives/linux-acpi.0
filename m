From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 08/24] eeepc-laptop: correct the description of the hibernation abort bug
Date: Fri, 28 Aug 2009 14:56:39 +0200
Message-ID: <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61313 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 124A7700246D
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Actually it is only the LED which is affected.  The bios bug does not
disable the wifi.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.4


