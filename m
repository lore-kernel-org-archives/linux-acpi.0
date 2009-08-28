From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 17/24] asus-laptop: Map X50R hotkeys
Date: Fri, 28 Aug 2009 14:56:48 +0200
Message-ID: <1251464215-6540-18-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-16-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-17-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60847 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbZH1NDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:40 -0400
In-Reply-To: <1251464215-6540-17-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Map some new hotkeys found on X50R.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 88cc9a1..410e545 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -285,6 +285,9 @@ static struct key_entry asus_keymap[] = {
 	{KE_KEY, 0x51, KEY_WWW},
 	{KE_KEY, 0x5C, KEY_SCREENLOCK},  /* Screenlock */
 	{KE_KEY, 0x5D, KEY_WLAN},
+	{KE_KEY, 0x5E, KEY_WLAN},
+	{KE_KEY, 0x5F, KEY_WLAN},
+	{KE_KEY, 0x60, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x61, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x6B, BTN_TOUCH}, /* Lock Mouse */
 	{KE_KEY, 0x82, KEY_CAMERA},
-- 
1.6.4


