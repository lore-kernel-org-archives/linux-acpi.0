From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/30] eeepc-laptop: Add support for extended hotkeys
Date: Sat, 07 Feb 2009 01:41:19 -0500
Message-ID: <b5f6f26550700445dcc125bbf75b9104e779d353.1233988824.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12159 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbZBGGlx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:53 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00J67NXD9EZ1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:39 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Newer Eees have extra hotkeys above the function keys. This patch adds support
for sending them through the input layer.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 66d611b..d153871 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -161,6 +161,10 @@ static struct key_entry eeepc_keymap[] = {
 	{KE_KEY, 0x13, KEY_MUTE },
 	{KE_KEY, 0x14, KEY_VOLUMEDOWN },
 	{KE_KEY, 0x15, KEY_VOLUMEUP },
+	{KE_KEY, 0x1a, KEY_COFFEE },
+	{KE_KEY, 0x1b, KEY_ZOOM },
+	{KE_KEY, 0x1c, KEY_PROG2 },
+	{KE_KEY, 0x1d, KEY_PROG3 },
 	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },
-- 
1.5.6.6

