From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 6/8] eeepc-laptop: check the 3G rfkill state on resume
Date: Sun, 02 Aug 2009 16:57:02 +0100
Message-ID: <4A75B74E.1070309@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35842 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZHBP5E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:57:04 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so2535576ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:57:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

All the rfkill devices are treated as "persistent", 3G is no exception.
This means their state may change over hibernation.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 7f7573a..8a32004 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -842,6 +842,9 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 	if (ehotk->bluetooth_rfkill)
 		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
 				    get_acpi(CM_ASL_BLUETOOTH) != 1);
+	if (ehotk->wwan3g_rfkill)
+		rfkill_set_sw_state(ehotk->wwan3g_rfkill,
+				    get_acpi(CM_ASL_3G) != 1);
 
 	return 0;
 }
-- 
1.6.3.2

