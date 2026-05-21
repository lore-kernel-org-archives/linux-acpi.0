Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5E3E5EEB;
	Thu, 21 May 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372760; cv=none; b=YxsK3gc5u+1KrXhvIqe8w1Qv+TFMmnZ0QGW8CfhPQ8oAWRbxTBSk7kFD6LMndBwvSja21drv/mwKyhs2sQR7D/yK17fvMi99Np8M+MH0lw4LDFgqo2kk/pVK5vfdwbQ/N1Ih7Wh2FFfmdREyXrjeiIE4SpsBjAullTLx5uJrjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372760; c=relaxed/simple;
	bh=35Dcqg29+uPvRTTlopJojkm+n/BbrIq7il60vbZyK9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7T5aAYsN7aE8ZW8IQJr2lB3ChbI5n4ygSglqtYd1oV+ZvB+L55/GYc5W0U9v0ecJLubVJBOZ2CDpPYdehNZoLgSbT+BiM82CH3O7HVn3E+44KrbxMC3lP7gs+147RJafoK5EfT4Xdu+IGWESMH4Rwt55/PUA7VuStLdtvYJ9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCSdH0l1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCSdH0l1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888F21F000E9;
	Thu, 21 May 2026 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372759;
	bh=Ixigyk0J3V09XnEgVRJqP8McDtyuFXx0rD2jDuEgSzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCSdH0l19xyGDYgJ691NUImlaTa3R24k+VTPJo3j13u+Yk1cVU/1WUQ9YfJhfaiYY
	 R3mpqg0pTUsuEiOl/Rbvarn7z7PaLCH5w1rcwY6amL7dPJ+bKjBetqXUnyLJCfkPPY
	 TUxXwHN7QSVKSgMjSARTOX0Yvq48gcS+YyMSyzL+/WcdUOx+/T5yWFtm9LHa7Gg4cO
	 WxGUXpfnolKcl2WR0Ccr/iO5FCZIRqjPpWeGkoH/2zrH4PIiH+io3S7E3iw1bRnd4Y
	 hikHQaUw5+XXQhSg+fzWVhGK13lejKwWKJWtOvDuVaB/NTb6ae/GoR69reDUNclskl
	 495xSFZFdTlGA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 04/17] ACPI: battery: Switch over to devres-based resource
 management
Date: Thu, 21 May 2026 16:02:44 +0200
Message-ID: <10856906.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI battery driver already uses devm_kzalloc() for allocating
memory and devm_mutex_init() for mutex initialization, but it still
carries out some manual rollback in acpi_battery_probe().

Switch it over to devres-based resource management completely by
making three changes:

 * Rename acpi_battery_update_retry() to devm_acpi_battery_update_retry(),
   turn sysfs_battery_cleanup() into a devm action and modify the former
   to add it.

 * Add devm_acpi_battery_init_wakeup() for initializing the wakeup
   source and make it add a custom devm action to automatically remove
   the wakeup source registered by it.

 * Make acpi_battery_probe() use devm_acpi_install_notify_handler()
   that has just been introduced for installing an ACPI notify handler.

Note that the code ordering change related to the last of the above
changes does not matter because there is no functional dependency
between the PM notifier and the wakeup source or the ACPI notify
handler.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c | 75 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b82dd67d98c9..f5e0eb299610 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1182,6 +1182,26 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{},
 };
 
+static void acpi_battery_wakeup_cleanup(void *data)
+{
+	device_init_wakeup(data, false);
+}
+
+static int devm_acpi_battery_init_wakeup(struct device *dev)
+{
+	device_init_wakeup(dev, true);
+	return devm_add_action_or_reset(dev, acpi_battery_wakeup_cleanup, dev);
+}
+
+static void sysfs_battery_cleanup(void *data)
+{
+	struct acpi_battery *battery = data;
+
+	guard(mutex)(&battery->update_lock);
+
+	sysfs_remove_battery(battery);
+}
+
 /*
  * Some machines'(E,G Lenovo Z480) ECs are not stable
  * during boot up and this causes battery driver fails to be
@@ -1190,10 +1210,15 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
  * may work. So add retry code here and 20ms sleep between
  * every retries.
  */
-static int acpi_battery_update_retry(struct acpi_battery *battery)
+static int devm_acpi_battery_update_retry(struct device *dev,
+					  struct acpi_battery *battery)
 {
 	int retry, ret;
 
+	ret = devm_add_action(dev, sysfs_battery_cleanup, battery);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&battery->update_lock);
 
 	for (retry = 5; retry; retry--) {
@@ -1206,27 +1231,21 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 	return ret;
 }
 
-static void sysfs_battery_cleanup(struct acpi_battery *battery)
-{
-	guard(mutex)(&battery->update_lock);
-
-	sysfs_remove_battery(battery);
-}
-
 static int acpi_battery_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct acpi_battery *battery;
 	struct acpi_device *device;
 	int result;
 
-	device = ACPI_COMPANION(&pdev->dev);
+	device = ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
 
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
-	battery = devm_kzalloc(&pdev->dev, sizeof(*battery), GFP_KERNEL);
+	battery = devm_kzalloc(dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
 
@@ -1235,54 +1254,38 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	battery->phys_dev = &pdev->dev;
 	battery->device = device;
 
-	result = devm_mutex_init(&pdev->dev, &battery->update_lock);
+	result = devm_mutex_init(dev, &battery->update_lock);
 	if (result)
 		return result;
 
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
-	result = acpi_battery_update_retry(battery);
+	result = devm_acpi_battery_update_retry(dev, battery);
 	if (result)
-		goto fail;
+		return result;
 
 	pr_info("Slot [%s] (battery %s)\n", acpi_device_bid(device),
 		device->status.battery_present ? "present" : "absent");
 
-	battery->pm_nb.notifier_call = battery_notify;
-	result = register_pm_notifier(&battery->pm_nb);
+	result = devm_acpi_battery_init_wakeup(dev);
 	if (result)
-		goto fail;
-
-	device_init_wakeup(&pdev->dev, true);
+		return result;
 
-	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_battery_notify, battery);
+	result = devm_acpi_install_notify_handler(dev, ACPI_ALL_NOTIFY,
+						  acpi_battery_notify, battery);
 	if (result)
-		goto fail_pm;
-
-	return 0;
-
-fail_pm:
-	device_init_wakeup(&pdev->dev, false);
-	unregister_pm_notifier(&battery->pm_nb);
-fail:
-	sysfs_battery_cleanup(battery);
+		return result;
 
-	return result;
+	battery->pm_nb.notifier_call = battery_notify;
+	return register_pm_notifier(&battery->pm_nb);
 }
 
 static void acpi_battery_remove(struct platform_device *pdev)
 {
 	struct acpi_battery *battery = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(battery->device, ACPI_ALL_NOTIFY,
-				       acpi_battery_notify);
-
-	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
-
-	sysfs_battery_cleanup(battery);
 }
 
 /* this is needed to learn about changes made in suspended state */
-- 
2.51.0




