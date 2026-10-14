Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7C4AB1B6;
	Wed, 14 Oct 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010689; cv=none; b=iyHfVdYUrUcAe0sIEzf24jA1Z/tPBATCunCtdSvGjAcVhPe+egFxbtt9HucdE83/TiRnkk5xlggIUK7KGR+zUA4tuJK9L+MNjNXj6oWm9C9+3yOPQ5p+lKwZxxV6ydk5taFy8p6444aG7oMTgxvjzY9zbN6W1HLVf0beM+e0PLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010689; c=relaxed/simple;
	bh=UW/3zrYFbtIu0VcfYb3Sgb6+OXktoZpWQtxZCH5rIJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjE6TkVvh8EcX6MZR3JIZrnjwNhaEqSxaewdSBrIhYBUbWoReAiRkfc6bMr8VTCqg9vpXj+bBOqw2qFXrEP4Lsd2IdrXBfuQaxhrNhh5eqD9uEUZkwxtCRkHJn1vdWUHIjzOAGt/JaphtBQiKJmmxupyksq1K51rbS+1h3BHtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lowRUyAq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lowRUyAq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=4ELn44YOIFwwaRlmuuTP6v9ebpA77IBSIet2VdSId0Q=; b=
	lowRUyAqYVVWTZXACHFjn3Kz7ijUa1UIHM+Cst2dKHs9yWWrdu7NtXQ9BQP3UxJGq50LqS+C3sMHY
	rpCPwszrY4trKhlM38nMWQjfQKQhI+Pv8BalKRKvhJ/daV4Pj4bmD2H4s77QqhWV87Fe8FYMAl7GV
	Y874w5BmjIGZhxFka/s/IxAXmdBtlCXlX74w2xgXCsu9vTlcqBagxhp9xnNcBH/N8hg71W4bY0C7a
	yXMBf/0+Q5nclS1Qs3lwx+Flfy2OxpaO8wcnizFxro2gGC7Fi9/HA4mvhkNUecZTXArD7aNy/HUay
	j5iZRnRXL8n9cS+Ud0TU2ABiJryDmrCafw==;
Received: from ip-86-49-238-151.bb.vodafone.cz ([86.49.238.151] helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xH5pr-000Dyf-ES; Wed, 14 Oct 2026 22:44:27 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v3 2/2] acpi: battery: Read Battery charge time for Steamdeck devices
Date: Wed, 14 Oct 2026 22:45:58 +0200
Message-ID: <20261014204558.466130-3-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014204558.466130-1-uajain@igalia.com>
References: <20261014204558.466130-1-uajain@igalia.com>
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

To handle this case, read out Battery charge time ("_BCT")
as it is reported accurately on these devices, hence use that
information for report charging vs discharging status.
Battery charge time ("_BCT") with an eligible power supply unit
will have valid values whereas with a low-powered supply unit,
it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
differentiator to determine, whether the battery of steamdeck
devices is really charging or not.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 drivers/acpi/battery.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fa20900bea0e..b7818695b6cb 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -242,7 +242,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 					: POWER_SUPPLY_STATUS_DISCHARGING;
 				return 0;
 			}
-		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
+		else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
 			/* Check the rate and capacity to validate the status. */
 			if (!acpi_battery_is_full(battery) ||
 			    (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -252,6 +252,29 @@ static int acpi_battery_get_property(struct power_supply *psy,
 				/* Full and zero rate. */
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			}
+
+			/*
+			 * For Valve Steamdeck devices, evaluate _BCT to determine
+			 * if we are really charging.
+			 */
+			if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags) &&
+			    acpi_has_method(battery->device->handle, "_BCT")) {
+				unsigned long long bct;
+				acpi_status status;
+				union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+				struct acpi_object_list args = { 1, &arg0 };
+
+				arg0.integer.value = 100;
+				status = acpi_evaluate_integer(battery->device->handle, "_BCT",
+							       &args, &bct);
+				if (ACPI_FAILURE(status) || bct > ACPI_UINT32_MAX)
+					acpi_handle_info(battery->device->handle,
+							 "_BCT evaluation failed: %s",
+							 acpi_format_exception(status));
+				else if (bct == ACPI_BATTERY_VALUE_UNKNOWN)
+					val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			}
+		}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
-- 
2.55.0

