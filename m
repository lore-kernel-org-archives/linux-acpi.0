From: Josef Gajdusek <atx@atx.name>
Subject: Re: [PATCH] acpi/battery: fix wrong value of capacity_now reported
 by few battery types when fully charged (resend)
Date: Tue, 17 Jun 2014 18:41:54 +0200
Message-ID: <20140617164154.GA21113@dashie>
References: <20140612145813.GB14085@dashie>
 <3564280.IKKn41NV0x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3564280.IKKn41NV0x@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It seems that some batteries (noticed on DELL JYPJ136) assume 
capacity_now = design_capacity when fully charged. This causes 
reported capacity to suddenly jump to >full_charge_capacity (and that 
means capacity reported to userspace is >100% and incorrect) 
values after 99%. This patch attempts to detect this bug, notifies 
userspace and trims the value to full_charge_capacity.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
Relaxed the check as you suggested and added printk_once.

> Why don't you use the
>
>    battery->capacity_now > battery->full_charge_capacity
>
> check here?  That would be more robust, wouldn't it?

To allow userspace to see that there is some unknown bug we do not know yet 
with the battery. This is taken care of much more elegantly by the printk 
now.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e48fc98..57a800c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -532,6 +532,18 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			" invalid.\n");
 	}
 
+	/* When fully charged, some batteries wrongly report
+	 * capacity_now = design_capacity instead of = full_charge_capacity
+	 */
+	if (battery->capacity_now > battery->full_charge_capacity) {
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
