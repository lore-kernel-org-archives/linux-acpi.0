From: Len Brown <lenb@kernel.org>
Subject: [PATCH 045/103] asus-laptop: Add wlan switch found on V6V
Date: Wed, 16 Dec 2009 03:35:56 -0500
Message-ID: <1f0233eee9b385d78fda78626136c43e045082f7.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761847AbZLPJFy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:05:54 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:49 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 83948df..3348cc6 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -323,6 +323,7 @@ static struct key_entry asus_keymap[] = {
 	{KE_KEY, 0x63, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x6B, KEY_F13}, /* Lock Touchpad */
 	{KE_KEY, 0x82, KEY_CAMERA},
+	{KE_KEY, 0x88, KEY_WLAN },
 	{KE_KEY, 0x8A, KEY_PROG1},
 	{KE_KEY, 0x95, KEY_MEDIA},
 	{KE_KEY, 0x99, KEY_PHONE},
-- 
1.6.0.6

