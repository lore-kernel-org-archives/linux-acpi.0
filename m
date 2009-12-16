From: Len Brown <lenb@kernel.org>
Subject: [PATCH 046/103] eeepc-laptop: map keys found on newer eeepc
Date: Wed, 16 Dec 2009 03:35:57 -0500
Message-ID: <b39b85e74acfd62a22afc33a88a7bda36beb3367.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761884AbZLPJGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:12 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:56 -0600 (CST)
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
 drivers/platform/x86/eeepc-laptop.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 935ec44..920d9d9 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -136,6 +136,7 @@ static const struct key_entry eeepc_keymap[] = {
 	{KE_KEY, 0x13, KEY_MUTE },
 	{KE_KEY, 0x14, KEY_VOLUMEDOWN },
 	{KE_KEY, 0x15, KEY_VOLUMEUP },
+	{KE_KEY, 0x16, KEY_DISPLAY_OFF },
 	{KE_KEY, 0x1a, KEY_COFFEE },
 	{KE_KEY, 0x1b, KEY_ZOOM },
 	{KE_KEY, 0x1c, KEY_PROG2 },
@@ -145,6 +146,8 @@ static const struct key_entry eeepc_keymap[] = {
 	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },
+	{KE_KEY, 0x37, KEY_F13 }, /* Disable Touchpad */
+	{KE_KEY, 0x38, KEY_F14 },
 	{KE_END, 0},
 };
 
-- 
1.6.0.6

