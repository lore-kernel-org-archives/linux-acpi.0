From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/41] ACPI: video: Fix null pointer in appledisplay driver
Date: Tue, 13 Feb 2007 00:49:28 -0500
Message-ID: <11713458163685-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751055AbXBMFuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:17 -0500
In-Reply-To: <11713458152188-git-send-email-lenb@kernel.org>
Message-Id: <d78112e1f1da2a8be1ac0d7b583dcc25aa4f079c.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, Len Brown <len.brown@intel.com>

From: Michael Hanselmann <linux-kernel@hansmi.ch>

commit "ACPI: video: Add dev argument for backlight_device_register"
519ab5f2be65b72cf12ae99c89752bbe79b44df6
broke the apple display driver.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/usb/misc/appledisplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index a7932a7..31ab83c 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -281,7 +281,7 @@ static int appledisplay_probe(struct usb_interface *iface,
 	/* Register backlight device */
 	snprintf(bl_name, sizeof(bl_name), "appledisplay%d",
 		atomic_inc_return(&count_displays) - 1);
-	pdata->bd = backlight_device_register(bl_name, NULL, NULL,
+	pdata->bd = backlight_device_register(bl_name, NULL, pdata
 						&appledisplay_bl_data);
 	if (IS_ERR(pdata->bd)) {
 		err("appledisplay: Backlight registration failed");
-- 
1.5.0.rc4.345.gb4d2
