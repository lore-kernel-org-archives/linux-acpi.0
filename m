Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA11E1A3D;
	Sat,  8 Aug 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786232669; cv=pass; b=Q4QCIMPPFk+0KJg6FxCPu7SG4qxL86VSmJjCLUAeGROYOQ3KhLA1KEF7MqW5XmWupnyAaJDAya8Q0c8FA0fjtGHXwvmFpI1nQEMhztMXv2z94hp5OlqKt6DvSTCfz/FRTCrhmsr1LLc8ttH63nMpjhtjS0KhLK2Sq3FZkE/z2HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786232669; c=relaxed/simple;
	bh=Mp6W5tm0hD1vzLHKRIob2jCX2/aQdWj/eTQ2R2NN6zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JUXYPY1MotqXaGrJsxI8JNfACOdA3+P4FzyvLyYs2OzWtgUEAzX3jOZiwiep7FcJ9imPrc0PFSctqJ8shdpTqhZ/oLYeKChjNsFEV7nNQ6mJCZIXb97moeVxiPQQmkci5zdNgGFwvqC65+pYDwCNbcdRDpbzeauVehAU95K+mMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=IDAgYr5T; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="IDAgYr5T"
ARC-Seal: i=1; a=rsa-sha256; t=1786232650; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cHgoKYlogdgtCT3jQ56WKmRpfydY7T+6vhuAufYrL85kHvKDypQ3xsACF2YT5MRENCsroItzjNg2X0SwFAoWjPmgajmGQVyxKELHNi9uk4hccK7708WK/ZFzBmBK97hi1/wWUMQ7iuh5nZLTIPtcraSQiZNMAwf6JD0+vGKfOyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786232650; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=51NGy5jl1mAFDb82ZBg1GWwe8iDqq1neCBIznTjdHpI=; 
	b=hWAFpFn14z1VcVKV4ISEZP2lXSrH9yL4dXeivbdkerrtXu8OXbOFotgmfChVrtUy7plpxaODWlfFVljKxlLElKEVGQ1vqW7vzxL4BlBLS1GQiZ/lQ0DqWgGrp92rFP0BPrEfPM2YXLZ9nflCqF+BwEfPx0+SYjW6UhiCuDHMKuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786232649;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=51NGy5jl1mAFDb82ZBg1GWwe8iDqq1neCBIznTjdHpI=;
	b=IDAgYr5Tqe6tLWjsu9AtiK+sGkrJLXNWzI2W5mqyaHFxsAP0uXH7jtUZexLpWCNk
	cJuSuAZeQaiSzos9ka/ipQ/9DVdCv7iMadSKoad2F2chTaKh9ZjSKCNBFKgo19mWcAO
	9GHgM4I2WykYxtZBtWrG0ISE9ktrLD2HUY/qDm9gK5i/3RCZIFl7ZoB7eWMp5xQvdG4
	DZymnusjUgjsH8ZbZdAVhhn8Ul0k9t53grSbpiuRE/HxF/Ss0jTTDATPtFK56GujM3w
	UpJENhfdJj0GFMWv8KB6UVWseKe8LSOr5b2OmvEx+fNiVQ/YAd8Ku1k+Z091htIK7Dr
	hr6qCe6DdA==
Received: by mx.zohomail.com with SMTPS id 1786232647402476.91941302388045;
	Sat, 8 Aug 2026 16:44:07 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sun, 09 Aug 2026 07:43:55 +0800
Subject: [PATCH v5] ACPI: battery: Protect all properties with a separated
 mutex
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-b4-acpi-battery-notification-v5-1-788d54fa2e35@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOzWoDIRQF4FcJrmvx+jNqVnmP0oU618RAx6B2a
 Ajz7nVSSkoWDVkeOPc790IqloSVbDcXUnBONeWpB/WyIeHgpj3SNPZMOOMDU5xRL6kLp0S9aw3
 LmU65pZiCa/2QWjZqA05EDpp04lQwpq8r//b+k+unP2Joq7k2Dqm2XM7X/RnW3u+U/n9qBsooF
 0x4HA0G5nclT/vXj4xkXZr5zRoAHli8WxINjoMCBwruLPGMJboVrbBMGB6Uk3eWvFkazANLdkt
 ZG/pnwDSPf6xlWb4B5Yv13b0BAAA=
X-Change-ID: 20260520-b4-acpi-battery-notification-90d781a3f217
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Avraham Hollander <anhollander516@gmail.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-2f6f2
X-ZohoMailClient: External

The acpi_battery_get_property() callback calls acpi_battery_get_state()
without any lock held. On some devices, it happens that the property
cache has expired before a uevent reaches userspace, triggering
simultaneous attempts to evaluate _BST. See [1] for an analysis to sysrq
stacktraces on one of the these devices.

In a few cases, including when the AML is sleeping or acquiring a mutex,
ACPICA drops the namespace and interpreter locks and allows the
evaluation of _BST to start while another task is still evaluating it.
This could somehow confuse the interpreter and lead to chaos in AML
mutexes on some devices, see [2] for an example.

Not holding the lock is also prone to race conditions, for example:

                CPU0                | 	         CPU1
acpi_battery_get_property()         |
  acpi_battery_get_state()          |
    [update_time expired]           |
    extract_package()               | acpi_battery_get_property()
    battery->update_time = jiffies  |   acpi_battery_get_state()
    kfree()                         |     [up to date]
                                    |   [read capacity_now]
    [fix capacity_now due to quirk] |

where CPU1 gets raw capacity_now before CPU0 fixes it to a meaningful
value.

The existing mutex update_lock is not applicapable for
acpi_battery_get_property(), as some code path could call or wait for
acpi_battery_get_property() while holding update_lock.

Therefore, introduce a mutex called property_lock to protect all
accesses to battery properties, so that acpi_battery_get_property() can
take the advantage of the mutex and synchronize itself. With the mutex,
acpi_battery_get_state() are synchronized in all code paths calling it,
and its cache mechanism can always clamp the frequency of _BST
evaluations according to cache_time.

The helper function acpi_battery_handle_discharging() for quirky devices
has to be inlined due to the change, as the mutex must be unlocked
before calling the expensive power_supply_is_system_supplied() helper
function.

Fixes: 86bfd21a0baf ("ACPI: battery: Drop redundant locking")
Tested-by: Avraham Hollander <anhollander516@gmail.com>
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065#c85 [1]
Reported-by: Avraham Hollander <anhollander516@gmail.com>
Closes: https://lore.kernel.org/linux-acpi/CAP1mzZReJCn6df5DwEPu-JCQUyr=Pu1cg5xKCMttWZkHCQtVmQ@mail.gmail.com [2]
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v5:
- Reword commit message (thanks Rafael J. Wysocki)
- Rebase onto linux-pm after other patches in the series have been
  applied
- Link to v4: https://patch.msgid.link/20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe

Changes in v4:
- Rebase and adopt devres-based resource management
- Refactor acpi_battery_notify() to hold the mutex across the entire
  function to improve readability and drop unnecessary variables (thanks
  Rafael J. Wysocki)
- Link to v3: https://patch.msgid.link/20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe

Changes in v3:
- Address Sashiko's concerns on my last-minute changes:
  - Set the number base to 10 in order not to break the ABI
  - Do not overwrite the initial value of `ret' in
    acpi_battery_get_property()
  - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151%40rong.moe
- Link to v2: https://patch.msgid.link/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe

Changes in v2:
- Address Sashiko's concerns:
  - Return from acpi_battery_notification_worker() early when the fifo
    is empty
  - Use pr_err_ratelimited() for potential event storms
  - Add missing `\n' in a printk message
  - Use a separated mutex to protect all properties instead of reusing
    update_lock
  - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b%40rong.moe
- Minimalize the critical section of acpi_battery_notify()
- Rearrange the series
- Dropped Tested-by from patch 3 due to massive rewrite
- Link to v1: https://patch.msgid.link/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe
---
 drivers/acpi/battery.c | 147 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 101 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 0084f308b790..670853ec3a4d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -105,6 +106,9 @@ struct acpi_battery {
 	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
 	struct list_head list;
+	unsigned long flags;
+
+	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
 	int revision;
 	int rate_now;
@@ -131,7 +135,6 @@ struct acpi_battery {
 	char oem_info[MAX_STRING_LENGTH];
 	int state;
 	int power_unit;
-	unsigned long flags;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -189,20 +192,6 @@ static bool acpi_battery_is_degraded(struct acpi_battery *battery)
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
@@ -210,15 +199,41 @@ static int acpi_battery_get_property(struct power_supply *psy,
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
 			/* Check the rate and capacity to validate the status. */
 			if (!acpi_battery_is_full(battery) ||
@@ -321,6 +336,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	default:
 		ret = -EINVAL;
 	}
+
+	mutex_unlock(&battery->property_lock);
 	return ret;
 }
 
@@ -556,6 +573,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	int use_bix;
 	int result = -ENODEV;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -595,6 +614,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -648,6 +669,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	acpi_status status = 0;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery) ||
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
@@ -665,6 +688,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 
 static int acpi_battery_init_alarm(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	/* See if alarms are supported, and if so, set default */
 	if (!acpi_has_method(battery->device->handle, "_BTP")) {
 		clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
@@ -682,6 +707,8 @@ static ssize_t acpi_battery_alarm_show(struct device *dev,
 {
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
 
+	guard(mutex)(&battery->property_lock);
+
 	return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
 }
 
@@ -697,6 +724,8 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&battery->property_lock);
+
 	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
@@ -881,12 +910,17 @@ static int sysfs_add_battery(struct acpi_battery *battery)
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
@@ -940,6 +974,9 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 static void find_battery(const struct dmi_header *dm, void *private)
 {
 	struct acpi_battery *battery = (struct acpi_battery *)private;
+
+	lockdep_assert_held(&battery->property_lock);
+
 	/* Note: the hardcoded offsets below have been extracted from
 	 * the source code of dmidecode.
 	 */
@@ -971,6 +1008,8 @@ static void find_battery(const struct dmi_header *dm, void *private)
  */
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		return;
 
@@ -1023,30 +1062,38 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
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
@@ -1058,9 +1105,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	 * Wakeup the system if battery is critical low
 	 * or lower than the alarm level
 	 */
-	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
-	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-	     (battery->capacity_now <= battery->alarm)))
+	if (wakeup)
 		acpi_pm_wakeup_event(battery->phys_dev);
 
 	return result;
@@ -1073,12 +1118,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
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
@@ -1170,17 +1217,21 @@ static int battery_notify(struct notifier_block *nb,
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
@@ -1345,6 +1396,10 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	if (result)
 		return result;
 
+	result = devm_mutex_init(&pdev->dev, &battery->property_lock);
+	if (result)
+		return result;
+
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 

---
base-commit: 92ec461acad4a92722634aafab38cfd3236e884d
change-id: 20260520-b4-acpi-battery-notification-90d781a3f217

Thanks,
Rong

