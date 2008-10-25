From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/9] toshiba_acpi: always call input_sync() after
 input_report_switch()
Date: Sat, 25 Oct 2008 04:13:36 -0400
Message-ID: <cab08969188e2da09923fe9c4a99ec9b934b0708.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:55373 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYJYINo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9A00JMLC6VE8Q4@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:44 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/toshiba_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index 2a632f8..66aac06 100644
--- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -371,6 +371,7 @@ static void bt_poll_rfkill(struct input_polled_dev *poll_dev)
 				   RFKILL_STATE_HARD_BLOCKED);
 		input_report_switch(poll_dev->input, SW_RFKILL_ALL,
 				    new_rfk_state);
+		input_sync(poll_dev->input);
 	}
 }
 
@@ -842,6 +843,7 @@ static int __init toshiba_acpi_init(void)
 	set_bit(EV_SW, toshiba_acpi.poll_dev->input->evbit);
 	set_bit(SW_RFKILL_ALL, toshiba_acpi.poll_dev->input->swbit);
 	input_report_switch(toshiba_acpi.poll_dev->input, SW_RFKILL_ALL, TRUE);
+	input_sync(toshiba_acpi.poll_dev->input);
 
 	ret = input_register_polled_device(toshiba_acpi.poll_dev);
 	if (ret) {
-- 
1.5.6.5

