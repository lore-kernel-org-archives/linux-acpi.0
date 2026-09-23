Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7871459AD7;
	Wed, 23 Sep 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152095; cv=none; b=PdbHo4KNfVvy5LbiRQGmILHMH8VBukNNDbG9GK5qIoGHc1VToqXcU15Gp/MnQA/1xmp68WAF8MQCBiyYBZYPNxxht86raeViiE13awGcXz+Q4vXcCyis2grANdUpPcU73/kLzCkc38YZBHsdrM2Cno4nIXN+M8vLzuRnsE6JDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152095; c=relaxed/simple;
	bh=xu7eCm2wiUuwwsp1Sp08fp54ex+WHpBjB1zNRo8zEhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWeYrc/h+JC0S/pjORJd9iC2q74oChAqSDaPLIQAbulYT5IKgxsdkIHgLM+gOgzmTnNoD5ax50vxAh5MqZReY22TbE8kbEZOqJKUwqm1G6QeI12kJ7W9M/AsiBlgXbl9J55igu/7H2D5812j0bSd7tFswI0jxLs3+ktCmsctEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BLg1XGCW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BLg1XGCW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=dyhhoglvo+ZbD/vcPTks6f8e4VSzeedt6wF9tqF0GA0=; b=
	BLg1XGCW3TgCF8ScoU7nq+filpmn0jEI6//pADk8uYKtrCMFGFjPV0QIvpsXjQ5DKJqHvY2kYELph
	0g8Y5Rv0ECSqB+m707rxs3IjLgYfmwGiECUxs6PwMb6I/TlQrAngHyWJEd8QTlu8wv9eOmtHe2hyD
	SXuTfSDFQGQnFWHpzQIygy47UhWlYL2R9KHw0RLNw6WwPAgYY0RVql8y69XCwlHUwb5ISpKLD0Gmo
	uCompj4zDFwI92pH5o3i4BlXVJy8QFUNoGLyD/KUEX8IJ/JcxQPreOGO8/K2m1fZ7SYamcZyiZheU
	twI9yvOJmfLLl8zou46dolmwpGdyuGpzAQ==;
Received: from [49.36.127.125] (helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x9IKi-00628i-FF; Wed, 23 Sep 2026 10:28:04 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v2 2/2] acpi: battery: Handle Valve steamdeck devices quirk
Date: Wed, 23 Sep 2026 13:59:32 +0530
Message-ID: <20260923082932.1049270-3-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923082932.1049270-1-uajain@igalia.com>
References: <20260923082932.1049270-1-uajain@igalia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valve steamdeck devices can report battery status as
charging, even when low-powered power supply is connected
to the device. The battery status is reported as charging
through sysfs, even though in reality, it is discharging.

To handle this case, we introduce a battery quirk for steamdeck
devices ACPI_BATTERY_QUIRK_VALVE_STEAMDECK. Additionally, it has been
found that on such devices, Battery Charge Time ("_BCT") is reported
accurately, hence use that information for report charging vs
discharging status. Battery Charge Time("_BCT") with an eligible power
supply unit will have valid values whereas with a low-powered supply
unit, it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
differentiator to determine, whether the battery of steamdeck devices
is really charging or not.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 drivers/acpi/battery.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index a1b7a821abaf..8defafd2b7c7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -95,6 +95,14 @@ enum {
 	 * on a full charge, but showing degradation in full charge cap.
 	 */
 	ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE,
+	/*
+	 * Valve steamdeck devices can get discharged even when battery status
+	 * is charging. This happens typically when low power supply unit is
+	 * connected. To accurately determine this scenario, we shall read
+	 * battery charge time ("_BCT"). This is the key differentiator to
+	 * determine whether the steamdeck is actually charging or not.
+	 */
+	ACPI_BATTERY_QUIRK_VALVE_STEAMDECK,
 };
 
 struct acpi_battery {
@@ -236,7 +244,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 					: POWER_SUPPLY_STATUS_DISCHARGING;
 				return 0;
 			}
-		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
+		else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
 			/* Check the rate and capacity to validate the status. */
 			if (!acpi_battery_is_full(battery) ||
 			    (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -246,6 +254,12 @@ static int acpi_battery_get_property(struct power_supply *psy,
 				/* Full and zero rate. */
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			}
+
+			if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags) &&
+			    test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags) &&
+			    battery->charge_time == ACPI_BATTERY_VALUE_UNKNOWN)
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
@@ -1072,6 +1086,18 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 		set_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery->flags);
 		battery->capacity_now = battery->full_charge_capacity;
 	}
+
+	if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags))
+		return;
+
+	if (dmi_name_in_vendors("Valve")) {
+		const char *name;
+
+		name = dmi_get_system_info(DMI_PRODUCT_NAME);
+		if ((name && (!strncmp("Jupiter", name, 7))) ||
+		    (name && (!strncmp("Galileo", name, 7))))
+			set_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags);
+	}
 }
 
 static int acpi_battery_update(struct acpi_battery *battery, bool resume)
-- 
2.55.0

