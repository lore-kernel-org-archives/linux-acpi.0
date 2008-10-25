From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/9] ACPI: Always report a sync event after a lid state change
Date: Sat, 25 Oct 2008 04:13:35 -0400
Message-ID: <df316e939100e789b3c5d4d102619ccf5834bd00.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33124 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYJYINq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9A00M87C6VUNF4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:44 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Guillem Jover <guillem.jover@nokia.com>, Len Brown <len.brown@intel.com>

=46rom: Guillem Jover <guillem.jover@nokia.com>

Currently not always an EV_SYN event is reported to userland
after the EV_SW SW_LID event has been sent. This is easy to verify
by using =E2=80=9Cinput-events=E2=80=9D from input-utils and just closi=
ng and opening
the lid.

Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9d568d4..cb046c3 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -262,6 +262,7 @@ static int acpi_lid_send_state(struct acpi_button *=
button)
 		return -ENODEV;
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
+	input_sync(button->input);
 	return 0;
 }
=20
@@ -285,8 +286,8 @@ static void acpi_button_notify(acpi_handle handle, =
u32 event, void *data)
 			input_report_key(input, keycode, 1);
 			input_sync(input);
 			input_report_key(input, keycode, 0);
+			input_sync(input);
 		}
-		input_sync(input);
=20
 		acpi_bus_generate_proc_event(button->device, event,
 					++button->pushed);
--=20
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
