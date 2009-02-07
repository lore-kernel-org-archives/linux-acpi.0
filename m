From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/30] panasonic-laptop: fix X[ ARRAY_SIZE(X) ]
Date: Sat, 07 Feb 2009 01:41:12 -0500
Message-ID: <2b190e76def5233c542f6025b4a133b1d4bd1a37.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:17179 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbZBGGls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00L68NXLZHV2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:46 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>, Len Brown <len.brown@intel.com>

From: Roel Kluin <roel.kluin@gmail.com>

Ensure pcc->keymap[ ARRAY_SIZE(pcc->keymap) ] does not occur.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index f30db36..c47a44d 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -507,7 +507,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 
 	hkey_num = result & 0xf;
 
-	if (hkey_num < 0 || hkey_num > ARRAY_SIZE(pcc->keymap)) {
+	if (hkey_num < 0 || hkey_num >= ARRAY_SIZE(pcc->keymap)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "hotkey number out of range: %d\n",
 				  hkey_num));
-- 
1.5.6.6

