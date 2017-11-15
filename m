From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] ACPI: button: Add an info message when we're sending a LID closed event
Date: Wed, 15 Nov 2017 15:07:17 +0100
Message-ID: <20171115140718.13026-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757465AbdKOOHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Nov 2017 09:07:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

I've been debugging some spurious suspend issues on various devices,
at least on some devices these spurious suspends are caused by surious
LID closed events being send to userspace.

Running e.g. evemu-record after noticing a spurious suspend is too late
to detect that a LID closed event it the (probable) cause of this.
This commit adds a pr_info("ACPI LID closed\n") call to help debugging.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ef1856b15488..07da60fe9cae 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -210,6 +210,9 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	}
 	/* Send the platform triggered reliable event */
 	if (do_update) {
+		if (!state)
+			pr_info("ACPI LID closed\n");
+
 		input_report_switch(button->input, SW_LID, !state);
 		input_sync(button->input);
 		button->last_state = !!state;
-- 
2.14.3

