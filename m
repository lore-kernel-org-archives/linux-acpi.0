From: Josef Gajdusek <atx@atx.name>
Subject: [PATCH] acpi/battery: fix wrong value of capacity_now reported by
 few battery types when fully charged (resend)
Date: Thu, 12 Jun 2014 16:58:13 +0200
Message-ID: <20140612145813.GB14085@dashie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:55646 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752898AbaFLO6b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 10:58:31 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

It seems that some batteries (noticed on DELL JYPJ136) assume 
capacity_now = design_capacity when fully charged. This causes 
reported capacity to suddenly jump to >full_charge_capacity (and that 
means capacity reported to userspace is >100% and incorrect) 
values after 99%. This patch attempts to detect this bug and trims 
capacity_now properly.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
Oops, I forgot to sign the previous one.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e48fc98..3338dd5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -532,6 +532,14 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			" invalid.\n");
 	}
 
+	/* When fully charged, some batteries wrongly report
+	 * capacity_now = design_capacity instead of = full_charge_capacity
+	 */
+	if (battery->capacity_now == battery->design_capacity &&
+	    battery->full_charge_capacity != ACPI_BATTERY_VALUE_UNKNOWN)
+		battery->capacity_now = battery->full_charge_capacity;
+
+
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
 	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
 		battery->capacity_now = (battery->capacity_now *

