From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL
 when power lead plugged in (resend)
Date: Wed, 28 Jan 2009 13:20:11 +0000
Message-ID: <1233148811.4231.0.camel@hughsie-work.lan>
References: <1232729843.3504.6.camel@hughsie-work.lan>
	 <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net>
	 <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>
	 <20090124124158.GC5325@khazad-dum.debian.net> <497B43D3.80703@suse.de>
	 <1232879297.3518.26.camel@hughsie-work.lan>
	 <20090125134203.GA12776@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-FuJh2O5GCh8DZkwXUfWX"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:54020 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZA1NUy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jan 2009 08:20:54 -0500
Received: by qyk4 with SMTP id 4so7894517qyk.13
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2009 05:20:52 -0800 (PST)
In-Reply-To: <20090125134203.GA12776@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>, Len Brown <lenb@kernel.org>


--=-FuJh2O5GCh8DZkwXUfWX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2009-01-25 at 11:42 -0200, Henrique de Moraes Holschuh wrote:
>  So, the above test will still break on any proper battery subsystem with the
> high watermark set below 100%, as those systems update full_charge_capacity
> *only* when the cells really are full (and not because the EC decided to
> stop the charging before they were full).

This is what I observed when testing my patch.

The attached patch checks the last full and design charge, as this seems
to work in all cases I have here. In the case of broken batteries or
broken hardware, we just return UNKNOWN in this "settling" state, which
is much better for userspace than falling back to full.

With the attached patch userspace gets the right states. In the future,
maybe we can do some sort of metric over time (watching to see if the
present charge changes) but for the most part the patch fixes things up
for userspace.

Please review,

Richard.


--=-FuJh2O5GCh8DZkwXUfWX
Content-Disposition: attachment; filename="0001-battery-don-t-assume-we-are-fully-charged-when-not.patch"
Content-Type: text/x-patch; name="0001-battery-don-t-assume-we-are-fully-charged-when-not.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 3b0fb1239e5bc064766ffa3d7a45265e722fb9eb Mon Sep 17 00:00:00 2001
From: Richard Hughes <hughsient@gmail.com>
Date: Sun, 25 Jan 2009 15:05:50 +0000
Subject: [PATCH] battery: don't assume we are fully charged when not charging or discharging

On hardware like the T61 it can take a couple of seconds for the battery
to start charging after the power is connected, and we incorrectly tell
userspace that we are fully charged, and then go back to charging.

Only mark a battery as fully charged when the preset charge matches either
the last full charge, or the design charge.

Signed-off-by: Richard Hughes <hughsient@gmail.com>
---
 drivers/acpi/battery.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65132f9..69cbc57 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -138,6 +138,29 @@ static int acpi_battery_technology(struct acpi_battery *battery)
 
 static int acpi_battery_get_state(struct acpi_battery *battery);
 
+static int acpi_battery_is_charged(struct acpi_battery *battery)
+{
+	/* either charging or discharging */
+	if (battery->state != 0)
+		return 0;
+
+	/* battery not reporting charge */
+	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN ||
+	    battery->capacity_now == 0)
+		return 0;
+
+	/* good batteries update full_charge as the batteries degrade */
+	if (battery->full_charge_capacity == battery->capacity_now)
+		return 1;
+
+	/* fallback to using design values for broken batteries */
+	if (battery->design_capacity == battery->capacity_now)
+		return 1;
+
+	/* we don't do any sort of metric based on percentages */
+	return 0;
+}
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -155,7 +178,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else if (battery->state & 0x02)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (battery->state == 0)
+		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
 		else
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
-- 
1.6.0.6


--=-FuJh2O5GCh8DZkwXUfWX--

