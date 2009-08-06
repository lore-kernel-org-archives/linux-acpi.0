From: akpm@linux-foundation.org
Subject: [patch 4/9] toshiba_acpi: return on a fail path
Date: Thu, 06 Aug 2009 15:57:51 -0700
Message-ID: <200908062257.n76MvpoF024228@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34100 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755951AbZHFXAC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 19:00:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, jirislaby@gmail.com, hmh@hmh.eng.br, johannes@sipsolutions.net, len.brown@intel.com, linville@tuxdriver.com

From: Jiri Slaby <jirislaby@gmail.com>

Return from bt_rfkill_poll() when hci_get_radio_state() fails.

value is invalid in that case and should not be assigned to the rfkill
state.

This also fixes a double unlock bug.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/toshiba_acpi.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-return-on-a-fail-path drivers/platform/x86/toshiba_acpi.c
--- a/drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-return-on-a-fail-path
+++ a/drivers/platform/x86/toshiba_acpi.c
@@ -335,6 +335,7 @@ static void bt_rfkill_poll(struct rfkill
 	if (hci_result != HCI_SUCCESS) {
 		/* Can't do anything useful */
 		mutex_unlock(&dev->mutex);
+		return;
 	}
 
 	new_rfk_state = value;
_
