From: Josef Gajdusek <atx@atx.name>
Subject: Re: [PATCH] acpi/battery: fix wrong value of capacity_now reported
 by few battery types when fully charged (resend)
Date: Tue, 17 Jun 2014 22:14:00 +0200
Message-ID: <20140617201359.GA6988@dashie>
References: <20140612145813.GB14085@dashie>
 <3564280.IKKn41NV0x@vostro.rjw.lan>
 <20140617164154.GA21113@dashie>
 <4697863.VH2Gj7n1J0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:55200 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932927AbaFQUOR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2014 16:14:17 -0400
Content-Disposition: inline
In-Reply-To: <4697863.VH2Gj7n1J0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

It seems that some batteries (noticed on DELL JYPJ136) assume 
capacity_now = design_capacity when fully charged. This causes 
reported capacity to suddenly jump to >full_charge_capacity (and that 
means capacity reported to userspace is >100% and incorrect) 
values after 99%. This patch attempts to detect this bug, notifies 
userspace and trims the value to full_charge_capacity.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
> 
> But it still is necessary to check if battery->full_charge_capacity is
> not ACPI_BATTERY_VALUE_UNKNOWN, isn't it?
> 

Fixed, my mistake. When changing the checks, I somehow missed that the values 
are not unsigned.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e48fc98..2e8f699 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -532,6 +532,19 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			" invalid.\n");
 	}
 
+	/* When fully charged, some batteries wrongly report
+	 * capacity_now = design_capacity instead of = full_charge_capacity
+	 */
+	if (battery->capacity_now > battery->full_charge_capacity &&
+		battery->full_charge_capacity != ACPI_BATTERY_VALUE_UNKNOWN) {
+		battery->capacity_now = battery->full_charge_capacity;
+		printk_once(KERN_WARNING FW_BUG
+			"battery: reported current charge level (%d) "
+			"is higher than reported maximum charge level (%d)."
+			"This is normal on some systems.\n",
+			battery->capacity_now, battery->full_charge_capacity);
+	}
+
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
 	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
 		battery->capacity_now = (battery->capacity_now *

