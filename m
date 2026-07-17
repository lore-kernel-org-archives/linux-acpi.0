Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330D3AF64F;
	Fri, 17 Jul 2026 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329904; cv=pass; b=j59VZb5EHAs/eRmp47dNE4Gfvj4tbs+rNlDdXuc7QgnkhUpdz8rPxpSygqyDFK/HmGs/DxontS+bE12hN3A63jDQjARy8XauGCvJ7Z92mZLLenVW6BudvuGlt5g/T4j4OgoLpDyayB9pAPsT9/4eficBR1SobPi66lrMDcsNaAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329904; c=relaxed/simple;
	bh=PnzJtAhDdzKNYBwJLj+RiCWoGtHxMGOj+NkSllUQAnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWaYcihyZVKHeCSmUT+Ll8OqZB3juIHk7bpH6+BlTJAUNJouXiVzXFx3x+VwpTAORYVx0trOfYGrJgKqVww1ELpBlNRQku/aqgLsXxcJ5jwIA6oxnA2ZeQFB9kR7Y7GNYpkRuIMCZu1aMNwd4ex1ndINwXj0oNYLsNb5WTZLJvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=mGSbTdJL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="mGSbTdJL"
ARC-Seal: i=1; a=rsa-sha256; t=1784329859; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EVefwslzrcaIXt6JWszB0bVDHzvvI579NWrKyL+BIQdkSLquSaoQQYTSPSSAH0vmJnFkeYiHxmUymlSi7sPp25Rg5efpfkinVhGlc6yeVRTpXzbKgWCVPCHjn9A1MhsljZ8YEDtB8gzQdSYPBVkgcRCDDi/GOvHwcE7cGu6IBj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784329859; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F55ovocLE6+UjldktEfBoe4z0RCR2uJwgCDHUTTEYD4=; 
	b=n6ZRNkmG4++z53txwF9XWNMYEcrn7TQuZSKZqJjKeW+E5eYFB4AfxANgA6sT8PT1iIFw9crtIp2KbWVNOYk3IElml4nrWxKRs2cPeBcf7wljWuB4+8/gSRoIF5+jTMTHtviXDRbrr0e9ak/V7c5x6ZhM9jq32Itd1dUcbEPDj4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784329859;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=F55ovocLE6+UjldktEfBoe4z0RCR2uJwgCDHUTTEYD4=;
	b=mGSbTdJLKJwe8QZLMyFYjHpwmazSLbGptLGuE2csQEVcw02B+NrT3CPza16Rog+b
	Rm+vxaQxJ0OV+0JuP5HkEgZzj6cpP0ZfZWJVroMSzcKc0QmpIYyS6/kheHPAsWBX7CL
	iuhNdH3gWqY8G5y0bXlubB4Q0Uk/2gcAJdql6SKFX8PFxbHLwGtQLXCJ2iDMMvacrBa
	AxjtBVx9yYrw7HblRal2VECkMeV9bgM5txrtUEYEKFwI+xqUBkCKTOWCdQyxSZZVLAu
	LesXpUgiLpmp3qIqiZfGeYkBGzIX49Il2v1Qwj8dbL0bFOrzf5UANIhayRMrVaWaW3U
	F4OHVvKc/Q==
Received: by mx.zohomail.com with SMTPS id 1784329855640560.6243003999492;
	Fri, 17 Jul 2026 16:10:55 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sat, 18 Jul 2026 07:10:21 +0800
Subject: [PATCH v4 3/3] ACPI: battery: Protect all properties with a
 separated mutex
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-b4-acpi-battery-notification-v4-3-599c8ed1072f@rong.moe>
References: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
In-Reply-To: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Avraham Hollander <anhollander516@gmail.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-4217c
X-ZohoMailClient: External

The acpi_battery_get_property() callback calls acpi_battery_get_state()
without any lock held, which could lead to race conditions, e.g., when
multiple tasks read power supply properties simultaneously, or when
other callbacks are called during its execution.

Moreover, some devices' _BST method relies on a heavily shared ACPI
mutex which protects EC accesses, so it cannot tolerate too much
pressure or else other methods will time out. The lack of
synchronization sometimes nullifies the cache mechanism of
acpi_battery_get_state() when multiple processes read power supply
properties simultaneously, which usually happens after a uevent.
Normally, emitting a uevent implies that the cache must have been
refreshed due to power_supply_uevent() reading all properties, so the
mentioned processes should have seen cache hits. Unfortunately, these
fragile devices' power_supply_ext properties are somehow slow to read
after battery events, resulting in cache expiration before
power_supply_uevent() finishes. Hence, once the uevent reaches
userspace, the _BST method will be executed multiple times within a
short period due to userspace processes reading all properties again.
The coincidence causes lock starvation, resulting in a catastrophic
situation that a lot of ACPI methods fail to acquire the shared ACPI
mutex due to timeout and return garbage data thanks to the firmware's
poorly designed error paths.

The said "other synchronized methods" are protected by update_lock,
leaving acpi_battery_get_property() to be the last desynchronized code
path. Unfortunately, update_lock is not applicapable for
acpi_battery_get_property(), as it protects too many fields, far more
than necessary. What's worse, some code path could call or wait for
acpi_battery_get_property() while an outer functions holding
update_lock.

Therefore, introduce a mutex to protect all accesses to battery
properties, so that acpi_battery_get_property() can take the advantage
of the mutex and synchronize itself. The helper function
acpi_battery_handle_discharging() for quirky devices has to be inlined
due to the change, as the mutex must be unlocked before calling the
expensive power_supply_is_system_supplied() helper function.

Tested-by: Avraham Hollander <anhollander516@gmail.com>
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Address Sashiko's concerns on my last-minute changes:
  - Do not overwrite the initial value of `ret' in
    acpi_battery_get_property()
  - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151%40rong.moe

Changes in v2:
- Address Sashiko's concerns:
  - Use a separated mutex to protect all properties instead of reusing
    update_lock
  - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b%40rong.moe
- Dropped Tested-by due to massive rewrite
---
 drivers/acpi/battery.c | 147 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 101 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index bd7fa93ff16f..3ad4acf3d44d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -104,6 +105,9 @@ struct acpi_battery {
 	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
 	struct list_head list;
+	unsigned long flags;
+
+	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
 	int revision;
 	int rate_now;
@@ -130,7 +134,6 @@ struct acpi_battery {
 	char oem_info[MAX_STRING_LENGTH];
 	int state;
 	int power_unit;
-	unsigned long flags;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -187,20 +190,6 @@ static bool acpi_battery_is_degraded(struct acpi_battery *battery)
 		battery->full_charge_capacity < battery->design_capacity;
 }
 
-static int acpi_battery_handle_discharging(struct acpi_battery *battery)
-{
-	/*
-	 * Some devices wrongly report discharging if the battery's charge level
-	 * was above the device's start charging threshold atm the AC adapter
-	 * was plugged in and the device thus did not start a new charge cycle.
-	 */
-	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
-	    battery->rate_now == 0)
-		return POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-	return POWER_SUPPLY_STATUS_DISCHARGING;
-}
-
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -208,15 +197,41 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	int full_capacity = ACPI_BATTERY_VALUE_UNKNOWN, ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
-	if (acpi_battery_present(battery)) {
-		/* run battery update only if it is present */
-		acpi_battery_get_state(battery);
-	} else if (psp != POWER_SUPPLY_PROP_PRESENT)
-		return -ENODEV;
+	/* run battery update only if it is present */
+	if (!acpi_battery_present(battery)) {
+		switch (psp) {
+		case POWER_SUPPLY_PROP_PRESENT:
+			val->intval = 0;
+			return 0;
+		default:
+			return -ENODEV;
+		}
+	}
+
+	mutex_lock(&battery->property_lock);
+
+	acpi_battery_get_state(battery);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
+		/*
+		 * Some devices wrongly report discharging if the battery's charge level
+		 * was above the device's start charging threshold atm the AC adapter
+		 * was plugged in and the device thus did not start a new charge cycle.
+		 */
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
-			val->intval = acpi_battery_handle_discharging(battery);
+			if (battery->rate_now != 0) {
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			} else if (battery_ac_is_broken) {
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			} else {
+				mutex_unlock(&battery->property_lock);
+
+				val->intval = power_supply_is_system_supplied()
+					? POWER_SUPPLY_STATUS_NOT_CHARGING
+					: POWER_SUPPLY_STATUS_DISCHARGING;
+				return 0;
+			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
 			/* Validate the status by checking the current. */
 			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -318,6 +333,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	default:
 		ret = -EINVAL;
 	}
+
+	mutex_unlock(&battery->property_lock);
 	return ret;
 }
 
@@ -540,6 +557,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	int use_bix;
 	int result = -ENODEV;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -579,6 +598,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -632,6 +653,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	acpi_status status = 0;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery) ||
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
@@ -649,6 +672,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 
 static int acpi_battery_init_alarm(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	/* See if alarms are supported, and if so, set default */
 	if (!acpi_has_method(battery->device->handle, "_BTP")) {
 		clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
@@ -666,6 +691,8 @@ static ssize_t acpi_battery_alarm_show(struct device *dev,
 {
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
 
+	guard(mutex)(&battery->property_lock);
+
 	return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
 }
 
@@ -681,6 +708,8 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&battery->property_lock);
+
 	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
@@ -865,12 +894,17 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		.no_wakeup_source = true,
 	};
 	bool full_cap_broken = false;
+	int power_unit;
 
-	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
-	    !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
-		full_cap_broken = true;
+	scoped_guard(mutex, &battery->property_lock) {
+		power_unit = battery->power_unit;
 
-	if (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
+		if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
+		    !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
+			full_cap_broken = true;
+	}
+
+	if (power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
 		if (full_cap_broken) {
 			battery->bat_desc.properties =
 			    charge_battery_full_cap_broken_props;
@@ -924,6 +958,9 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 static void find_battery(const struct dmi_header *dm, void *private)
 {
 	struct acpi_battery *battery = (struct acpi_battery *)private;
+
+	lockdep_assert_held(&battery->property_lock);
+
 	/* Note: the hardcoded offsets below have been extracted from
 	 * the source code of dmidecode.
 	 */
@@ -955,6 +992,8 @@ static void find_battery(const struct dmi_header *dm, void *private)
  */
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		return;
 
@@ -1007,30 +1046,38 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 {
 	int result = acpi_battery_get_status(battery);
+	bool wakeup;
 
 	if (result)
 		return result;
 
 	if (!acpi_battery_present(battery)) {
 		sysfs_remove_battery(battery);
-		battery->update_time = 0;
+		scoped_guard(mutex, &battery->property_lock)
+			battery->update_time = 0;
 		return 0;
 	}
 
 	if (resume)
 		return 0;
 
-	if (!battery->update_time) {
-		result = acpi_battery_get_info(battery);
+	scoped_guard(mutex, &battery->property_lock) {
+		if (!battery->update_time) {
+			result = acpi_battery_get_info(battery);
+			if (result)
+				return result;
+			acpi_battery_init_alarm(battery);
+		}
+
+		result = acpi_battery_get_state(battery);
 		if (result)
 			return result;
-		acpi_battery_init_alarm(battery);
-	}
+		acpi_battery_quirks(battery);
 
-	result = acpi_battery_get_state(battery);
-	if (result)
-		return result;
-	acpi_battery_quirks(battery);
+		wakeup = ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
+			  (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
+			   (battery->capacity_now <= battery->alarm)));
+	}
 
 	if (!battery->bat) {
 		result = sysfs_add_battery(battery);
@@ -1042,9 +1089,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	 * Wakeup the system if battery is critical low
 	 * or lower than the alarm level
 	 */
-	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
-	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-	     (battery->capacity_now <= battery->alarm)))
+	if (wakeup)
 		acpi_pm_wakeup_event(battery->phys_dev);
 
 	return result;
@@ -1057,12 +1102,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 	if (!battery->bat)
 		return;
 
-	power_unit = battery->power_unit;
+	scoped_guard(mutex, &battery->property_lock) {
+		power_unit = battery->power_unit;
 
-	acpi_battery_get_info(battery);
+		acpi_battery_get_info(battery);
 
-	if (power_unit == battery->power_unit)
-		return;
+		if (power_unit == battery->power_unit)
+			return;
+	}
 
 	/* The battery has changed its reporting units. */
 	sysfs_remove_battery(battery);
@@ -1154,17 +1201,21 @@ static int battery_notify(struct notifier_block *nb,
 		} else {
 			int result;
 
-			result = acpi_battery_get_info(battery);
-			if (result)
-				return result;
+			scoped_guard(mutex, &battery->property_lock) {
+				result = acpi_battery_get_info(battery);
+				if (result)
+					return result;
+			}
 
 			result = sysfs_add_battery(battery);
 			if (result)
 				return result;
 		}
 
-		acpi_battery_init_alarm(battery);
-		acpi_battery_get_state(battery);
+		scoped_guard(mutex, &battery->property_lock) {
+			acpi_battery_init_alarm(battery);
+			acpi_battery_get_state(battery);
+		}
 	}
 
 	return 0;
@@ -1329,6 +1380,10 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	if (result)
 		return result;
 
+	result = devm_mutex_init(&pdev->dev, &battery->property_lock);
+	if (result)
+		return result;
+
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 

-- 
2.53.0

