From: Richard Hughes <hughsient@gmail.com>
Subject: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when
 power lead plugged in
Date: Sun, 25 Jan 2009 10:28:17 +0000
Message-ID: <1232879297.3518.26.camel@hughsie-work.lan>
References: <1232729843.3504.6.camel@hughsie-work.lan>
	 <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net>
	 <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>
	 <20090124124158.GC5325@khazad-dum.debian.net>  <497B43D3.80703@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RaOD6vEwQ7mJ6DSGxmu+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f10.google.com ([209.85.219.10]:38985 "EHLO
	mail-ew0-f10.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZAYKf6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jan 2009 05:35:58 -0500
Received: by ewy3 with SMTP id 3so407783ewy.13
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jan 2009 02:35:56 -0800 (PST)
In-Reply-To: <497B43D3.80703@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>


--=-RaOD6vEwQ7mJ6DSGxmu+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2009-01-24 at 19:37 +0300, Alexey Starikovskiy wrote:
> > I don't understand, why this guesswork over fully charged?  If you cannot
> > detect fully charged, then *don't*.
> > 
> > But if you must sinthesize it, and you can get an up-to-date "last full
> > capacity" from the battery when comparing, I suggest:
> > 
> > full = (current capacity == last full capacity) && !charging &&
> >        !discharging
> certainly, 90% is wrong, but 100% makes a day...

I think we need some sort of logic like this.
 
> > That would *still* be wrong in a few corner cases, but at least they're rare
> > corner cases that happens only when the pack recalibrates its fuel gauge.
> full in this case is not exact term. As any other term beside current_now and voltage_now.
> Capacity of the battery is estimated, so any number that was depending on it, is estimated too.

Right, never underestimate the brokenness of some people's batteries out
there. Coupled with broken BIOS's, some of the fix-up code in HAL is
'interesting'. I think all the fix-up code in HAL belongs in in the
kernel.

> > If there isn't a reliable way to detect the "full" state, just drop the
> > fully charged detection altogether.
> People are used to see "full" state of the battery. I think we could tolerate not-full-enough 
> for sub-second interval instead of dropping full state altogether.

We shouldn't drop the full state, we should just add some metric like
above. What about something like the attached (untested) patch? Would
something this be accepted?

Richard.


--=-RaOD6vEwQ7mJ6DSGxmu+
Content-Disposition: attachment; filename="acpi-battery-charged.patch"
Content-Type: text/x-patch; name="acpi-battery-charged.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65132f9..d400a11 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -138,6 +138,38 @@ static int acpi_battery_technology(struct acpi_battery *battery)
 
 static int acpi_battery_get_state(struct acpi_battery *battery);
 
+static int acpi_battery_is_charged(struct acpi_battery *battery)
+{
+	int percentage;
+
+	/* either charging or discharging */
+	if (battery->state != 0)
+		return 0;
+
+	/* battery not reporting charge */
+	if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN ||
+	    battery->capacity_now == 0)
+		return 0;
+
+	/* good batteries update full_charge as the batteries degrade */
+	if (battery->full_charge_capacity != ACPI_BATTERY_VALUE_UNKNOWN &&
+	    battery->full_charge_capacity != 0) {
+		percentage = (100 * battery->capacity_now) / battery->full_charge_capacity;
+		if (percentage > 90)
+			return 1;
+	}
+
+	/* fallback to using design values for broken batteries */
+	if (battery->design_capacity != ACPI_BATTERY_VALUE_UNKNOWN &&
+	    battery->design_capacity != 0) {
+		percentage = (100 * battery->capacity_now) / battery->design_capacity;
+		if (percentage > 90)
+			return 1;
+	}
+
+	return 0;
+}
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -155,7 +187,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else if (battery->state & 0x02)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (battery->state == 0)
+		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
 		else
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;

--=-RaOD6vEwQ7mJ6DSGxmu+--

