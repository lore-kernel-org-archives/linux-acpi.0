From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] ACPI: button: Add a debug message when we're sending a LID event
Date: Wed, 22 Nov 2017 16:06:11 +0100
Message-ID: <20171122150612.16999-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdKVPGP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Nov 2017 10:06:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

I've been debugging some spurious suspend issues on various devices,
at least on some devices these spurious suspends are caused by surious
LID closed events being send to userspace.

Running e.g. evemu-record after noticing a spurious suspend is too late
to detect that a LID closed event it the (probable) cause of this.

This commit adds an acpi_handle_debug call to help debugging this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use acpi_handle_debug instead of pr_info
---
 drivers/acpi/button.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index bf8e4d371fa7..aac81f40e28e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -210,6 +210,8 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	}
 	/* Send the platform triggered reliable event */
 	if (do_update) {
+		acpi_handle_debug(device->handle, "ACPI LID %s\n",
+				  state ? "open" : "closed");
 		input_report_switch(button->input, SW_LID, !state);
 		input_sync(button->input);
 		button->last_state = !!state;
-- 
2.14.3

