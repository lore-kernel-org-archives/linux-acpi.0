Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AB4AB1B3;
	Wed, 14 Oct 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010675; cv=none; b=m6D0pmDK1HI4Ac1dB7E8zicllvnHR7wtFVythv22PTvnu4cZaHQjYG6I8lI7VPt49qiZJHyZ9A6ydVNWbx/q9wt+fXxqQIQqeT619zqgxMODdNB0lIwg+z0KRRhv4BSNDQZVz3bxuCQzW2iN6LCEqEkqY2OFyN7hdwPVSn8SvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010675; c=relaxed/simple;
	bh=sd/roBGhi1hY7CH9JxX9XL7rCnWbcy4RQ7onUoweJ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H22UA4Gco2qv9gypGYW3JWUMZu2WWGQNDGia0hy1XxQi5CmUSBs/d1E2BrpP89MW9o3nvuqNiLaY1EWI6hokjpNkEXHoqd3tDECRkK7sxQVaPP7UjtKuxEv+cd0N27yzVdI/OWA1VJ17VtXq07BwE0V5uXO3O9OA16LE2cRO530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=q90IGsYu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q90IGsYu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=3ZENNU0JAWNT6Xua+kU1wRFJ19oaxSnfTKEMzwil+1Y=; b=
	q90IGsYudD6OdfMcg4NSjE66ZZ6EXxwe3kfHyStkUuWPsOc7eZ5ayuUjZ21Ue/64LpxeU33XZ2Hf2
	TKbm5Fc0SoGRCeXFJafsYLwv6o7f1lYnee4ZV0vFt/K1jLB91+f2Am/QiVbliPfwZzCXwuFt1arNu
	WXjPRexQLaTKtGEo/WHOmptTcQ+P9ciHTTKO757fryYYdAlELfBNikZ3ZlJBxCFpijc8jonu3XdUo
	nBPNGqdEljtiGo25Ay/IRpN2etp9/WdZd9/wrZ+NDrT4Upbo/KP+L45Qm70BkqfcYwwH63nigk0Rg
	TpUsYxhRS4m4yVeKKGPy/0JmGxNhe1QHyA==;
Received: from ip-86-49-238-151.bb.vodafone.cz ([86.49.238.151] helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xH5pq-000Dyf-Sn; Wed, 14 Oct 2026 22:44:27 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v3 1/2] acpi: battery: Introduce Valve steamdeck devices quirk
Date: Wed, 14 Oct 2026 22:45:57 +0200
Message-ID: <20261014204558.466130-2-uajain@igalia.com>
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

Introduce a battery quirk for Valve Steamdeck devices
ACPI_BATTERY_QUIRK_VALVE_STEAMDECK. This is required to detect
if a low-power supply unit is connected to the device, which can
report charging status through sysfs as "charging", even though in
reality, it is discharging. We shall read Battery Charge Time ("_BCT")
information to handle these cases, in a subsequent commit.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 drivers/acpi/battery.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d..fa20900bea0e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -94,6 +94,14 @@ enum {
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
@@ -1057,6 +1065,18 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
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

