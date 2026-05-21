Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12517557E;
	Thu, 21 May 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372765; cv=none; b=q3iMQYrchV+uI2775ILGd+iJpIfgRyOJWP3dTnUAWxDekNNX+zOCMXYxZy0krHOmpB0YLF0s1tm9mFfaD8E73iYbLeCAI/jR2Mgm0iAHPumiLZCdKKR7bqIAtlb/4DUs4buprZbj12AkuQdCRvrVkKl/aElt3/G8TpKdAhulx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372765; c=relaxed/simple;
	bh=7u3Xq1A5e3rekZV9p2VkqwzsCG4ESgwm0HFDzWKaeic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epkiNczMYM5O7+xJGm3Z5IQI/rEdPLskwpUJyrx1kStzqYDcDDpXsUQ9rsx1ORX4exkNjFgtpsFUJ0wM1Xg8WD/9MJhzbgGnGzaiirAXzyzGLRtKAIkrejsIEml6KoZeo7MP+7xbzsIHoT1ThmGOFufbgKSMt7fdoSg22yEQL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr7U/z8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr7U/z8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFC61F000E9;
	Thu, 21 May 2026 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372763;
	bh=L4pKi+6qO6Jsly0pKJhuJw33Q93Di3Ti7WaFJic1YfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pr7U/z8taWZuAg7/4HTQiHoK2jDn3VhFahpr6nB9+4XuyvyU0TR9N5wD4umwomV1J
	 J03KtRMB+zWEv80TkFmr5FBwvU/+6430cMCJ0dLTZwIVAHgp3IS4TOjUSsa2sxEaqQ
	 vSTjgK/+2SKtH45lEFhdbxzKN+bTWSFkg7ByAAieWvFLnKSYKdejmdk4hSosN9RKO2
	 zybInDcfE8RSndC2detECr+V5wIoE5SHHSA4TbJFaykGnw4DKvsnwm4FaoLJcRhv0S
	 foeu8G2Q+/xEnSAtCE5aDMDXdA9yGvWhiePO4279vLhzFXu8BZ/A4PXzLrqY0T3lAp
	 hd47Rc3HZAOtg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 03/17] ACPI: AC: Switch over to devres-based resource management
Date: Thu, 21 May 2026 16:02:00 +0200
Message-ID: <3422377.44csPzL39Z@rafael.j.wysocki>
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

Use devm_kzalloc() for allocating memory, devm_power_supply_register()
for registering a power supply class device and the newly introduced
devm_acpi_install_notify_handler() for installing an ACPI notify handler.

Note that the code ordering change related to the third of the above
modifications does not matter because there is no order dependency
between the battery notifier and the ACPI notify handler.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 27f31744f29e..f19d6dd43473 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -193,6 +193,7 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 static int acpi_ac_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
+	struct device *dev = &pdev->dev;
 	struct acpi_device *adev;
 	struct acpi_ac *ac;
 	int result;
@@ -201,7 +202,7 @@ static int acpi_ac_probe(struct platform_device *pdev)
 	if (!adev)
 		return -ENODEV;
 
-	ac = kzalloc_obj(struct acpi_ac);
+	ac = devm_kzalloc(dev, sizeof(*ac), GFP_KERNEL);
 	if (!ac)
 		return -ENOMEM;
 
@@ -211,7 +212,7 @@ static int acpi_ac_probe(struct platform_device *pdev)
 
 	result = acpi_ac_get_state(ac);
 	if (result)
-		goto err_release_ac;
+		return result;
 
 	psy_cfg.drv_data = ac;
 
@@ -220,33 +221,22 @@ static int acpi_ac_probe(struct platform_device *pdev)
 	ac->charger_desc.properties = ac_props;
 	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger_desc.get_property = get_ac_property;
-	ac->charger = power_supply_register(&pdev->dev,
-					    &ac->charger_desc, &psy_cfg);
-	if (IS_ERR(ac->charger)) {
-		result = PTR_ERR(ac->charger);
-		goto err_release_ac;
-	}
+	ac->charger = devm_power_supply_register(dev, &ac->charger_desc, &psy_cfg);
+	if (IS_ERR(ac->charger))
+		return PTR_ERR(ac->charger);
 
 	pr_info("AC Adapter [%s] (%s-line)\n", acpi_device_bid(adev),
 		str_on_off(ac->state));
 
+	result = devm_acpi_install_notify_handler(dev, ACPI_ALL_NOTIFY,
+						  acpi_ac_notify, ac);
+	if (result)
+		return result;
+
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
 
-	result = acpi_dev_install_notify_handler(adev, ACPI_ALL_NOTIFY,
-						 acpi_ac_notify, ac);
-	if (result)
-		goto err_unregister;
-
 	return 0;
-
-err_unregister:
-	power_supply_unregister(ac->charger);
-	unregister_acpi_notifier(&ac->battery_nb);
-err_release_ac:
-	kfree(ac);
-
-	return result;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -271,12 +261,7 @@ static void acpi_ac_remove(struct platform_device *pdev)
 {
 	struct acpi_ac *ac = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(ac->device, ACPI_ALL_NOTIFY,
-				       acpi_ac_notify);
-	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
-
-	kfree(ac);
 }
 
 static struct platform_driver acpi_ac_driver = {
-- 
2.51.0




