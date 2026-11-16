Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824794;
	b=YCZDCNz3HitabRdAaX0IwJvRsPb4FsHYq0juHCOqAbhcjgnWURhha8ZpHEIs2uWzsMiR
	 CnzFqpBhUufyEVv4jvRK9V1IjceEGfqMvTNtzf5jbN7avTnXa/+/rHt2MxuxxfLxxd9qW
	 aM60idqnwIWORL6S0Yd6hbb1EcDdwcxNIxso3H64KI1caQQ0ThepTw1URXb9HoRihXDYg
	 Npz8NLHgdVyyfZWNY//wHWIHmKpY1t/QK2tFzWIlWoMP9bmnDsqzkoxq0yQRmhv1/EROL
	 nKbUVlABL51BQdhceZWu4r+7lEUWfb/8at7+K/usC9pahtgdogfAMsueNd+7BFiDCnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824794;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b5uk04KO1e7ZUuEaYfQC6j2jyf4zt2TryIoPvf6G75c=;
	b=tWVeeLXw8Qp3XoPvDtoK1bIp2JVlINlF2+Xu8NwyF9I5oDfIh7NqJtv7GJ4pFL51y919
	 JyUb7CpB8tiQaTacGRDvokjRQnzO7pc2p6K0VKxHmJTBIXyykEZcy9xlCnQsSyoy4shg4
	 oq1xHZY/kRhpeBfD7Sd2nIA5CFct+2Yp9LCj3eEtlLZ77iVmhd8yV0l1EUAD9FBNNaO4v
	 7VLqjaGx6o2btTDq5Ga2Bg5h8hcB0Ze77Z+HH0pL18yczsvG9C7RG8px3Tz8a7h4efMfw
	 tCro34CAnS5TI13xjlthcurQic/RBd5Ts9y+ROUwae4a2Aiw52kHQB/B/NEq//RgJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=bs8t3nS4;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0801606A323;
	Mon, 16 Nov 2026 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0801606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=bs8t3nS4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=b5uk04KO1e7ZUuEaYfQC6j2jyf4zt2TryIoPvf6G75c=;
	t=1794824793; x=2110184793; b=bs8t3nS4P/D0bic+u7db1iES6idd4RsTS1v/WwP10zqWeW3
	6bWNcMfFB1MWBTobp4EPcsJrwqKsnjEZWo0SxAimWn2NQNOxUDfqVFjG1qI7HnQRdrAZckoOlLGcP
	82W0YUa8DXNlkmYjmSkHCryUtuz7R0J6Iek2AJjalWNBUUsxox95TdqD35B9OPpWvbp7BnRUmEzLk
	dLqdF7hUcEYUvx07SKWKqnsTrUvmgKgo2uG+3NlgS8jlG5rWltOB+LDZjYSf0+NeCEsfjTVaHv/b6
	nPh5zw+ibYdRECBt1OrpVn2uOiAo/njfBewWigM0fFCEhn2PGXTTqEEdUy/y1/ig==;
Received: from [103.238.108.137] (helo=uajain.bbrouter)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xStux-00000000958-4Bpl;
	Mon, 16 Nov 2026 11:26:32 +0100
From: Umang Jain <uajain@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v4 1/1] acpi: battery: Read Battery charge time("_BCT") for Steamdeck devices
Date: Mon, 16 Nov 2026 15:57:52 +0530
Message-ID: <20261116102752.520062-2-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116102752.520062-1-uajain@igalia.com>
References: <20261116102752.520062-1-uajain@igalia.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valve steamdeck devices can report battery status as
charging, even when low-powered power supply is connected
to the device. The battery status is reported as charging
through sysfs, even though in reality, it is discharging.

To address this, introduce a battery quirk for Valve Steamdeck devices
ACPI_BATTERY_QUIRK_VALVE_STEAMDECK. This is required to detect
if a low-power supply unit is connected to the device.
To handle this case, read out Battery charge time ("_BCT")
as it is reported accurately on these devices and use that
information for report charging vs discharging status.
Battery charge time ("_BCT") with an eligible power supply unit
will have valid values whereas with a low-powered supply unit,
it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
differentiator to determine, whether the battery of steamdeck
devices is really charging or not.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 drivers/acpi/battery.c | 49 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6edea559a5bc..458c2b23a05a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -94,6 +94,15 @@ enum {
 	 * on a full charge, but showing degradation in full charge cap.
 	 */
 	ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE,
+	/*
+	 * Valve steamdeck devices can get discharged even when battery status
+	 * is charging. This happens typically when low power supply unit is
+	 * connected. To accurately determine this scenario, we shall read
+	 * battery charge time ("_BCT") and set this quirk. This is the key
+	 * differentiator to determine whether the steamdeck is actually
+	 * charging or not.
+	 */
+	ACPI_BATTERY_QUIRK_VALVE_STEAMDECK,
 };
 
 struct acpi_battery {
@@ -234,7 +243,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 					: POWER_SUPPLY_STATUS_DISCHARGING;
 				return 0;
 			}
-		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
+		else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
 			/* Check the rate and capacity to validate the status. */
 			if (!acpi_battery_is_full(battery) ||
 			    (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -244,6 +253,27 @@ static int acpi_battery_get_property(struct power_supply *psy,
 				/* Full and zero rate. */
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			}
+
+			if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags)) {
+				unsigned long long bct;
+				acpi_status status;
+				union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+				struct acpi_object_list args = { 1, &arg0 };
+
+				arg0.integer.value = 100;
+				status = acpi_evaluate_integer(battery->device->handle, "_BCT",
+							       &args, &bct);
+				if (ACPI_FAILURE(status))
+					acpi_handle_debug(battery->device->handle,
+							  "_BCT evaluation failed: %s",
+							  acpi_format_exception(status));
+				else if (bct > ACPI_UINT32_MAX)
+					acpi_handle_debug(battery->device->handle,
+							  "_BCT value is invalid");
+				else if (bct == ACPI_BATTERY_VALUE_UNKNOWN)
+					val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			}
+		}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
@@ -1150,6 +1180,23 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 		set_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery->flags);
 		battery->capacity_now = battery->full_charge_capacity;
 	}
+
+	if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags))
+		return;
+
+	/*
+	 * For Valve Steamdeck devices, determine _BCT presence as well before
+	 * setting its battery quirk.
+	 */
+	if (dmi_name_in_vendors("Valve") &&
+	    acpi_has_method(battery->device->handle, "_BCT")) {
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

