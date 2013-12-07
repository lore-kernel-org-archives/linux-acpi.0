From: Jan Vcelak <jan.vcelak@nic.cz>
Subject: [PATCH] ACPI: full battery charge cannot exceed current one
Date: Sat,  7 Dec 2013 13:36:41 +0100
Message-ID: <1386419801-10091-1-git-send-email-jan.vcelak@nic.cz>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:43129 "EHLO mail.nic.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab3LGMpH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 7 Dec 2013 07:45:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Some degraded batteries report maximal capacity to be smaller than
current charge of the battery. This can confuse some user space
applications (like upower).

This patch handles the situation by increasing maximal capacity
of the battery if it exceedes current charge.

Signed-off-by: Jan Vcelak <jan.vcelak@nic.cz>
---

upower: fully charged battery reported as 0% charged
https://bugzilla.redhat.com/show_bug.cgi?id=1025980

 drivers/acpi/battery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fbf1ace..71ec1f6 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -494,6 +494,11 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		battery->capacity_now = battery->capacity_now *
 		    10000 / battery->design_voltage;
 	}
+
+	/* Some degraded batteries report lower full charge than current one. */
+	if (battery->capacity_now > battery->full_charge_capacity)
+		battery->full_charge_capacity = battery->capacity_now;
+
 	return result;
 }
 
-- 
1.8.4.2

