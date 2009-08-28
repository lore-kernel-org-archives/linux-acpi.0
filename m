From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 21/24] asus-laptop: Add suport for another "Media" key
Date: Fri, 28 Aug 2009 14:56:52 +0200
Message-ID: <1251464215-6540-22-git-send-email-corentincj@iksaif.net>
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
 <1251464215-6540-18-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-19-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-20-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-21-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60907 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
In-Reply-To: <1251464215-6540-21-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index dd926b9..0325f7c 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -288,6 +288,7 @@ static struct key_entry asus_keymap[] = {
 	{KE_KEY, 0x41, KEY_NEXTSONG},
 	{KE_KEY, 0x43, KEY_STOPCD},
 	{KE_KEY, 0x45, KEY_PLAYPAUSE},
+	{KE_KEY, 0x4c, KEY_MEDIA},
 	{KE_KEY, 0x50, KEY_EMAIL},
 	{KE_KEY, 0x51, KEY_WWW},
 	{KE_KEY, 0x5C, KEY_SCREENLOCK},  /* Screenlock */
-- 
1.6.4


