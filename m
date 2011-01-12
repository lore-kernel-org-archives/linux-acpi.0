From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/48] ACPI / PM: Report wakeup events from buttons
Date: Wed, 12 Jan 2011 05:19:17 -0500
Message-ID: <1f83511bd8f44b8a9e2d82263b2c95f26a625fcc.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1ALRA2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:28 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:23 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Since ACPI buttons and lids can be configured to wake up the system
from sleep states, report wakeup events from these devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 234c104..76bbb78 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -279,6 +279,9 @@ static int acpi_lid_send_state(struct acpi_device *device)
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
 
+	if (state)
+		pm_wakeup_event(&device->dev, 0);
+
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
 		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
@@ -314,6 +317,8 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			input_sync(input);
 			input_report_key(input, keycode, 0);
 			input_sync(input);
+
+			pm_wakeup_event(&device->dev, 0);
 		}
 
 		acpi_bus_generate_proc_event(device, event, ++button->pushed);
-- 
1.7.4.rc1.7.g2cf08

