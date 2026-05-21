Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E243E00B6;
	Thu, 21 May 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372749; cv=none; b=Z4bhm3R2oU4y3/ys3AjQad9GmD+Zl4r21JwO/aVoF1rzv3IAg/nKBsKd/jNi4SoPE/sGqYUX3tUb1bTVNUvhbcNNqMHy122oATWalrwHYnojCWdHr8zIRjDX9Rrfhm3v9W/+I7wRp/gM9+FJdoga90yT/+oyCCk9v9Z0iHMsZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372749; c=relaxed/simple;
	bh=V7ony2FtNFnzLciVod1phxBwKSOP600MoU3j7RZ7bJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOCAEU+jjKKOKxOyCE8jqHuZl5HMrSbIhLaroe5ihNrhLWnb7ZGRCMU/YmyCEEetXmYb4UOUH+B+Uki1nQYMehXH+zJQL8/f2sf9Mb2eLtzlGR5ZaJ5lwMjhpMT1NPZb01DUCXimiW5rSURS2GGR0746Qm0GN6wbc6/y4xDWs8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW0Dg6sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW0Dg6sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349B01F000E9;
	Thu, 21 May 2026 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372748;
	bh=8p8sWVqM2BJXzLlNC4oq3qLps7KkE0nM7EpgebO+k3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OW0Dg6snnh54pzmLB/EvsJoadJq8Q3ypH3D+Mffd5fvjwc50FXUMxp4WA7Fa2V5jx
	 nxih2Preos1IsdtHSey+IVelAFrKgHdRp2bLgdissX5DjWGwHbhs+X3OaqcKCLbZZO
	 15hBVc96hLFG+7+jC0GKZ2zWeNWqLnv+IXT93TldcE7q3t2tHyBBRwE/zg7h45MyZa
	 uwJ1fL/+iQ6MJBUMuV7Isn9fq+YdmMLdBphhbssNVBfx4PZNoxrMv99Fxn5pCsLl/k
	 xBQFlfjWqru+IBZexpnOlHDQCNkAzJW9qWnaapUxQ4ZNbi53AfR2x5/6YsrLlBUnzN
	 z+Zecw/xDHfhQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 07/17] ACPI: thermal: Switch over to devres-based resource
 management
Date: Thu, 21 May 2026 16:04:45 +0200
Message-ID: <3698719.iIbC2pHGDl@rafael.j.wysocki>
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

Switch over the ACPI thermal zone driver to devres-based resource
management by making the following changes:

 * Turn acpi_thermal_zone_free() into a devm action added from
   acpi_thermal_probe() after allocating the struct acpi_thermal object.

 * Rename acpi_thermal_unregister_thermal_zone() to
   acpi_thermal_zone_unregister(), add acpi_thermal_pm_queue flushing to
   it, and turn it into a devm action added by acpi_thermal_probe()
   after calling acpi_thermal_register_thermal_zone().

 * Use the newly introduced devm_acpi_install_notify_handler() for
   installing an ACPI notify handler.

 * Drop acpi_thermal_remove() that is not necessary any more.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c | 53 +++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index dfc7daa809b5..dd7666c176a0 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -655,8 +655,12 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
 	return result;
 }
 
-static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
+static void acpi_thermal_zone_unregister(void *data)
 {
+	struct acpi_thermal *tz = data;
+
+	flush_workqueue(acpi_thermal_pm_queue);
+
 	thermal_zone_device_disable(tz->thermal_zone);
 	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
@@ -765,8 +769,9 @@ static void acpi_thermal_check_fn(struct work_struct *work)
 	mutex_unlock(&tz->thermal_check_lock);
 }
 
-static void acpi_thermal_free_thermal_zone(struct acpi_thermal *tz)
+static void acpi_thermal_zone_free(void *data)
 {
+	struct acpi_thermal *tz = data;
 	int i;
 
 	acpi_handle_list_free(&tz->trips.passive.trip.devices);
@@ -779,7 +784,8 @@ static void acpi_thermal_free_thermal_zone(struct acpi_thermal *tz)
 static int acpi_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_trip trip_table[ACPI_THERMAL_MAX_NR_TRIPS] = { 0 };
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_thermal_trip *acpi_trip;
 	struct thermal_trip *trip;
 	struct acpi_thermal *tz;
@@ -795,6 +801,10 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 	if (!tz)
 		return -ENOMEM;
 
+	result = devm_add_action_or_reset(dev, acpi_thermal_zone_free, tz);
+	if (result)
+		return result;
+
 	platform_set_drvdata(pdev, tz);
 
 	tz->device = device;
@@ -817,7 +827,7 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 	/* Get temperature [_TMP] (required). */
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
-		goto free_memory;
+		return result;
 
 	/* Determine the default polling frequency [_TZP]. */
 	if (tzp)
@@ -870,7 +880,11 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 						    trip - trip_table,
 						    passive_delay);
 	if (result)
-		goto free_memory;
+		return result;
+
+	result = devm_add_action_or_reset(dev, acpi_thermal_zone_unregister, tz);
+	if (result)
+		return result;
 
 	refcount_set(&tz->thermal_check_count, 3);
 	mutex_init(&tz->thermal_check_lock);
@@ -879,32 +893,8 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 	pr_info("Thermal Zone [%s] (%ld C)\n", acpi_device_bid(device),
 		deci_kelvin_to_celsius(tz->temp_dk));
 
-	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						 acpi_thermal_notify, tz);
-	if (result)
-		goto flush_wq;
-
-	return 0;
-
-flush_wq:
-	flush_workqueue(acpi_thermal_pm_queue);
-	acpi_thermal_unregister_thermal_zone(tz);
-free_memory:
-	acpi_thermal_free_thermal_zone(tz);
-
-	return result;
-}
-
-static void acpi_thermal_remove(struct platform_device *pdev)
-{
-	struct acpi_thermal *tz = platform_get_drvdata(pdev);
-
-	acpi_dev_remove_notify_handler(tz->device, ACPI_DEVICE_NOTIFY,
-				       acpi_thermal_notify);
-
-	flush_workqueue(acpi_thermal_pm_queue);
-	acpi_thermal_unregister_thermal_zone(tz);
-	acpi_thermal_free_thermal_zone(tz);
+	return devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
+						acpi_thermal_notify, tz);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -937,7 +927,6 @@ MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
 
 static struct platform_driver acpi_thermal_driver = {
 	.probe = acpi_thermal_probe,
-	.remove = acpi_thermal_remove,
 	.driver = {
 		.name = "acpi-thermal",
 		.acpi_match_table = thermal_device_ids,
-- 
2.51.0




