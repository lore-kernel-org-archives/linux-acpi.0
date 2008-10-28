From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.26,27.stable] ACPI: Always report a sync event after a lid
 state change
Date: Tue, 28 Oct 2008 01:34:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810280131390.24123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_oXKkQfHhNHeRvXurkear/Q)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:49245 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYJ1Fe3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 01:34:29 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9F00LTVOTFU498@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Oct 2008 00:34:28 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_oXKkQfHhNHeRvXurkear/Q)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

From: Guillem Jover <guillem.jover@nokia.com>
upstream commit df316e939100e789b3c5d4d102619ccf5834bd00

Currently not always an EV_SYN event is reported to userland
after the EV_SW SW_LID event has been sent. This is easy to verify
by using “input-events” from input-utils and just closing and opening
the lid.

Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9d568d4..cb046c3 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -262,6 +262,7 @@ static int acpi_lid_send_state(struct acpi_button *button)
 		return -ENODEV;
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
+	input_sync(button->input);
 	return 0;
 }
 
@@ -285,8 +286,8 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 			input_report_key(input, keycode, 1);
 			input_sync(input);
 			input_report_key(input, keycode, 0);
+			input_sync(input);
 		}
-		input_sync(input);
 
 		acpi_bus_generate_proc_event(button->device, event,
 					++button->pushed);
-- 
1.5.6.5

--Boundary_(ID_oXKkQfHhNHeRvXurkear/Q)--
