From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/3] toshiba_acpi: return on a fail path
Date: Fri, 28 Aug 2009 20:18:02 -0400
Message-ID: <82e7784f57a81faf673b09bc468e736d582fe754.1251505014.git.len.brown@intel.com>
References: <1251505083-24354-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47162 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZH2ASW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 20:18:22 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP4009M33ICZB83@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 Aug 2009 19:18:18 -0500 (CDT)
In-reply-to: <1251505083-24354-1-git-send-email-lenb@kernel.org>
In-reply-to: <b0de22bdffa2e9a8e280d769c59f866605268484.1251505014.git.len.brown@intel.com>
References: <b0de22bdffa2e9a8e280d769c59f866605268484.1251505014.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jiri Slaby <jirislaby@gmail.com>, "John W. Linville" <linville@tuxdriver.com>, Johannes Berg <johannes@sipsolutions.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Jiri Slaby <jirislaby@gmail.com>

Return from bt_rfkill_poll() when hci_get_radio_state() fails.

value is invalid in that case and should not be assigned to the rfkill
state.

This also fixes a double unlock bug.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/toshiba_acpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 81d31ea..51c0a8b 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -335,6 +335,7 @@ static void bt_rfkill_poll(struct rfkill *rfkill, void *data)
 	if (hci_result != HCI_SUCCESS) {
 		/* Can't do anything useful */
 		mutex_unlock(&dev->mutex);
+		return;
 	}
 
 	new_rfk_state = value;
-- 
1.6.0.6

