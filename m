Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9ED35C69D;
	Fri, 18 Sep 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739710; cv=none; b=Lc2TiSuLnBoFxpaU1T2FxHm16nGNGWv0Ul17I4DLZTUyTTzN3fyKTbVGsmvgNAgYGMdY4izRBGK4l3ek7ym0NpFf+ROfCMJowXqdUPUuIWJSVfvrz1NIEbL1xfMv7F0lZnEa9lmxXZ3PpGdXPbjL5hj8ygh0BRkk3FB/1KXTQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739710; c=relaxed/simple;
	bh=te7/qahIKl/ZjT4+vvlMeaMmZN/2FNifFVb4EixyiLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9dpso62wdsaXIGIR9psk5LJJYmyNebf8CS6I3YJxJteSuSbmiLme5IvNptuZrh5Fosr7IrcHoG1IW9jy60Mq6XiSmL+TUny8cXH3McU32vBFS70t9Q7lXZ3Gu4p4z9cZnctqR2mCIIcT4kx10kaP74TUecRuKHScGiMJ2KVe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XkpM/MGP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XkpM/MGP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=lkKMrxqvVDVTk7WISHQu8FkHxXnnnC67kQoP6Dx9eis=; b=
	XkpM/MGP4RUfKaaK39SemxroXS/MVzPouQ9rB7t046CHL4EnGyxPg7/Zhzk9yOsZFIDmZVuy7x15+
	APZLYJjPS07HWlxtpZ//XxmJEfH16oBZoUjMw+V7xhT8uLghClIO5Cuv4dt4lOp6j4rSpnQ/Yab4B
	DB5VQjnWdSx91QiGiyW4k/+a1rv6NT0UecgE9ZrX3X/DB73Zv7ZQvME6FjEsxPb46RS3gC6UbjlMk
	YVcNUOBqEdVbon7WWgffVctBA79MbDN4x+FYx4rnEXISCbfQRmUhtbqCtI80Kma+PQ35B7zEJb3aF
	ULLCUF30ULLf1upHzBMTzrt98+rXxZa3Tg==;
Received: from [49.36.127.125] (helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7Z3M-003yEB-9l; Fri, 18 Sep 2026 15:55:00 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH] acpi: battery: Handle Valve steamdeck devices quirk
Date: Fri, 18 Sep 2026 19:26:28 +0530
Message-ID: <20260918135628.2322188-1-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
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

To handle this case, first we introduce a battery quirk
for steamdeck devices ACPI_BATTERY_QUIRK_VALVE_STEAMDECK.
Additionally, it has been found that on such devices,
Battery Charge Time ("_BCT") is reported accurately, hence
use that information for report charging vs discharging status.
Battery Charge Time with an eligible power supply unit will have
valid values whereas with a low-powered supply unit, it shall report
ACPI_BATTERY_VALUE_UNKNOWN. Use this as a differentiator to
determine, whether the battery of steamdeck devices is really
charging or not.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 drivers/acpi/battery.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d..db611f3302c4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
 	ACPI_BATTERY_XINFO_PRESENT,
+	ACPI_BATTERY_BCT_PRESENT,
 	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 	/* On Lenovo Thinkpad models from 2010 and 2011, the power unit
 	 * switches between mWh and mAh depending on whether the system
@@ -94,6 +95,14 @@ enum {
 	 * on a full charge, but showing degradation in full charge cap.
 	 */
 	ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE,
+	/*
+	 * Valve steamdeck devices can get discharged even when battery status
+	 * is charging. This happens typically low power supply unit is
+	 * connected. To accurate determine this scenario, we shall read
+	 * battery charge time ("_BCT") to know whether the steamdeck is
+	 * really charging with the power supply unit.
+	 */
+	ACPI_BATTERY_QUIRK_VALVE_STEAMDECK,
 };
 
 struct acpi_battery {
@@ -110,6 +119,7 @@ struct acpi_battery {
 
 	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
+	unsigned long long charge_time;
 	int revision;
 	int rate_now;
 	int capacity_now;
@@ -234,7 +244,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 					: POWER_SUPPLY_STATUS_DISCHARGING;
 				return 0;
 			}
-		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
+		else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
 			/* Check the rate and capacity to validate the status. */
 			if (!acpi_battery_is_full(battery) ||
 			    (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -244,6 +254,12 @@ static int acpi_battery_get_property(struct power_supply *psy,
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
@@ -613,6 +629,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+
+	arg0.integer.value = 100;
 
 	lockdep_assert_held(&battery->property_lock);
 
@@ -638,6 +658,15 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 
+	if (test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags)) {
+		status = acpi_evaluate_integer(battery->device->handle, "_BCT",
+					       &args, &battery->charge_time);
+		if (ACPI_FAILURE(status))
+			acpi_handle_info(battery->device->handle,
+					 "_BCT evaluation failed: %s",
+					 acpi_format_exception(status));
+	}
+
 	/* For buggy DSDTs that report negative 16-bit values for either
 	 * charging or discharging current and/or report 0 as 65536
 	 * due to bad math.
@@ -1057,6 +1086,15 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 		set_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery->flags);
 		battery->capacity_now = battery->full_charge_capacity;
 	}
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
@@ -1083,6 +1121,8 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 			if (result)
 				return result;
 			acpi_battery_init_alarm(battery);
+			if (acpi_has_method(battery->device->handle, "_BCT"))
+				set_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags);
 		}
 
 		result = acpi_battery_get_state(battery);
-- 
2.55.0

