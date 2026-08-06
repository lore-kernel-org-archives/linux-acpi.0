Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFC49321A;
	Thu,  6 Aug 2026 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059510; cv=none; b=HgdZEHvFwVIobiE+9k4H8wGbTcLmUuTcvcSToZHQM9QPmzWBwIDP8aitFZE5NVX8YfQ2ZtIkMK9aKQUO0idjLS5aJcTI2zS2QvhW3skCLC59yDLyyDfQaz/jk7dm4aiPX23dVdqlmUqroiCwRcrQPWQC+HF/Fo2PtBub/Ru6MKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059510; c=relaxed/simple;
	bh=exveYJCeKf/J4CldEdhKHj6K8IEP5KFi9U6l0cwysVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QzkyDTzJp23kQol30r1F71u0gBimKj4agOXdFjw+X4gcM0JjyTk6zMariFQDibjTS9vPf8U0LGadV4uPA6NSznRSqr68cBY5B3kyGsMZ7EIngHQl9X7ikYEZ/kbA4lp07sX+dq+bPAxDv5R620GqF/XNhLsDBrvFLdM7qURs5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=la8I+ogx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="la8I+ogx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786059505; x=1786664305; i=w_armin@gmx.de;
	bh=05qZ5TCbdM/ea6gwcNiEmQ3Sz41GY1v2yEXTrMERAx4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=la8I+ogxPhcUqmTmxsq6pvGMCD1DA2ZCG00h7BfkuHJ3FBhpvJTKM6kCNi0tmNEz
	 hsLfxqmx8PJBxL191hGYi2ojQ3Sj2CF7DlXgDUHUqCZyXxqezJiWTcSkFnwqLjyqJ
	 uZWtllkgiF3SFiVlCL7NGH2L1Kz8sVpUa1a+kqdrYKCj6dCtaHIsel2jfAq8UdPbS
	 Otfth4pU7rlSg7k3TMJCi3kJVi1LxfZbmnM+IK8Bc8F3CPRCVaAIEZ1unndQbyCy6
	 +T32RGD+yn1fMfx/ZRDqg6O5wMHdUBdQtx5HYSQzAEoHkEFNGONH2Nif4MF9Euzn+
	 UevcNmKCiS71REoH9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1wgJHr3hmB-000b3V; Fri, 07
 Aug 2026 01:38:24 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH] ACPI: battery: Fix bogus cycle count values on systems without _BIX
Date: Fri,  7 Aug 2026 01:38:17 +0200
Message-Id: <20260806233817.622975-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V1+vIVeEXQpHDXol2RNN5U3TNG/NwTUYk9q7qNvQZT+9S2ttEBO
 aMiWno+ytqbmM2pZfgf8cV3IhX63vwe4o/5+rLcfrxudSCnLdc+7ziN+G62nVVFHCCzcKi9
 YjOWe9n7yLd+EB31fBpVTRtqaNFA2cfX4wCm3d/p2FQMZal6e4p3hZ8/28bso7JctLO5/Gw
 4d7rAx2xYYM3s+tXTSkRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:retA2RaQBzA=;MFwgtP9WsYsOnAFl3Dkv/Msf3CF
 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
 62jmmpATTL9FIQNWWmqGRrqn/TJA=

Devices supporting only the legacy _BIF ACPI control method cannot
know the cycle count of the associated battery, so cycle_count always
remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
such devices can thus mislead userspace applications and prevents
power supply extensions from supplying correct cycle count values.

Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
on devices without _BIX.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 131 +++++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 0084f308b790..b64f876f93cb 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -324,7 +324,9 @@ static int acpi_battery_get_property(struct power_supp=
ly *psy,
 	return ret;
 }
=20
-static const enum power_supply_property charge_battery_props[] =3D {
+/* For devices supporting the _BIX ACPI control method */
+
+static const enum power_supply_property charge_battery_extended_props[] =
=3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -342,7 +344,7 @@ static const enum power_supply_property charge_battery=
_props[] =3D {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
=20
-static const enum power_supply_property charge_battery_full_cap_broken_pr=
ops[] =3D {
+static const enum power_supply_property charge_battery_full_cap_broken_ex=
tended_props[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -356,7 +358,7 @@ static const enum power_supply_property charge_battery=
_full_cap_broken_props[] =3D
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
=20
-static const enum power_supply_property energy_battery_props[] =3D {
+static const enum power_supply_property energy_battery_extended_props[] =
=3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -374,7 +376,7 @@ static const enum power_supply_property energy_battery=
_props[] =3D {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
=20
-static const enum power_supply_property energy_battery_full_cap_broken_pr=
ops[] =3D {
+static const enum power_supply_property energy_battery_full_cap_broken_ex=
tended_props[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -388,6 +390,68 @@ static const enum power_supply_property energy_batter=
y_full_cap_broken_props[] =3D
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
=20
+/* For devices supporting only the _BIF ACPI control method */
+
+static const enum power_supply_property charge_battery_props[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const enum power_supply_property charge_battery_full_cap_broken_pr=
ops[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const enum power_supply_property energy_battery_props[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const enum power_supply_property energy_battery_full_cap_broken_pr=
ops[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
 /* Battery Management */
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
@@ -875,6 +939,7 @@ static void __exit battery_hook_exit(void)
=20
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
+	bool extended_info_available =3D test_bit(ACPI_BATTERY_XINFO_PRESENT, &b=
attery->flags);
 	struct power_supply_config psy_cfg =3D {
 		.drv_data =3D battery,
 		.attr_grp =3D acpi_battery_groups,
@@ -888,25 +953,55 @@ static int sysfs_add_battery(struct acpi_battery *ba=
ttery)
=20
 	if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
 		if (full_cap_broken) {
-			battery->bat_desc.properties =3D
-			    charge_battery_full_cap_broken_props;
-			battery->bat_desc.num_properties =3D
-			    ARRAY_SIZE(charge_battery_full_cap_broken_props);
+			if (extended_info_available) {
+				battery->bat_desc.properties =3D
+					charge_battery_full_cap_broken_extended_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(charge_battery_full_cap_broken_extended_props);
+			} else {
+				battery->bat_desc.properties =3D
+					charge_battery_full_cap_broken_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(charge_battery_full_cap_broken_props);
+			}
 		} else {
-			battery->bat_desc.properties =3D charge_battery_props;
-			battery->bat_desc.num_properties =3D
-			    ARRAY_SIZE(charge_battery_props);
+			if (extended_info_available) {
+				battery->bat_desc.properties =3D
+					charge_battery_extended_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(charge_battery_extended_props);
+			} else {
+				battery->bat_desc.properties =3D
+					charge_battery_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(charge_battery_props);
+			}
 		}
 	} else {
 		if (full_cap_broken) {
-			battery->bat_desc.properties =3D
-			    energy_battery_full_cap_broken_props;
-			battery->bat_desc.num_properties =3D
-			    ARRAY_SIZE(energy_battery_full_cap_broken_props);
+			if (extended_info_available) {
+				battery->bat_desc.properties =3D
+					energy_battery_full_cap_broken_extended_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(energy_battery_full_cap_broken_extended_props);
+			} else {
+				battery->bat_desc.properties =3D
+					energy_battery_full_cap_broken_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(energy_battery_full_cap_broken_props);
+			}
 		} else {
-			battery->bat_desc.properties =3D energy_battery_props;
-			battery->bat_desc.num_properties =3D
-			    ARRAY_SIZE(energy_battery_props);
+			if (extended_info_available) {
+				battery->bat_desc.properties =3D
+					energy_battery_extended_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(energy_battery_extended_props);
+			} else {
+				battery->bat_desc.properties =3D
+					energy_battery_props;
+				battery->bat_desc.num_properties =3D
+					ARRAY_SIZE(energy_battery_props);
+			}
 		}
 	}
=20
=2D-=20
2.39.5

