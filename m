Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.55.232.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799904;
	b=wWXXDaJuXiSl6+XDGuxg06c1jDi2jbsaG6tVeZwuuSBMob/EAVqa524PdI69a30sxFVG
	 5lgGM9UvunWOHI76ijJL2J3mkQ2yiLswf1orBnL3u+csBAjKuyjOXtskoIrEl1FI6w6Nd
	 ZohQ64dFcXyn/1pnNVsqtm+1MWy43e9s5Jbv4twJKMH1GgMfPIHVwKua5umNMweJhBgsT
	 GE8PjnUTLuZZLzuTWQ4ISDkeEimY4b3AkLsrW/9hbJQ0aWfKTH2O0cJvB1A9KBhFX7+MD
	 f5XjOze3p3EkPNKCNwCOYGhJPWxnXRQXz2q6rWYNyBMPw8Qzxh5kHgB2c+/G2SJ2Sxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799904;
	h=DMARC-Filter:DKIM-Signature:X-Mailgun-Sid:Received:
	 X-Mailgun-Sending-Ip:Sender:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U9q6ulQ8EsZQeKd2Hx+C9E7Egn67ZdHVnPPz22Pp8qA=;
	b=aRBgNfK2FnfmnUfaMzJeK8PZdRpAWWAd/yFUaFHvJJUDo40L1kD2W90z6Yq7HcayjCJ+
	 TMAWhqCqyU/XtqCEtd3LL+l+kxdK+NMkhQAhzR1732WeW2gBy8xyBhRf3z3cganAiRxRX
	 jQmdTbi+kpLABJTzTXzG7d3C35ybaEXzrrBhh8RLmNCxJ8YYAsjz9WnV2WJ6QfdpIVTSp
	 9Ue2U8kKl6RatUAPnW4VfRxUvfr9vc+7Ox0jFGhihqtBUwyZo0TYQdp0/KSmGq2SMx9nN
	 xt+zU6hXLCMGTLKAos4AK+UL68AJ4TosQTBKidvSNJrWJmHPJZHNAwRLkVDcPclWT7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=elijahmock.com;
	spf=pass smtp.mailfrom=elijahmock.com;
	dkim=pass header.d=elijahmock.com header.i=@elijahmock.com header.a=rsa-sha256 header.s=k1 header.b=ddGv8Jjn;
	arc=none smtp.remote-ip=143.55.232.4
Received: from v54.v5f06b487.use4.send.mailgun.net (v54.v5f06b487.use4.send.mailgun.net [143.55.232.4])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AA0E3606A31C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 17:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA0E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahmock.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahmock.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=elijahmock.com header.i=@elijahmock.com header.a=rsa-sha256 header.s=k1 header.b=ddGv8Jjn
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=elijahmock.com; q=dns/txt; s=k1; t=1795799902; x=1795807102;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=U9q6ulQ8EsZQeKd2Hx+C9E7Egn67ZdHVnPPz22Pp8qA=;
 b=ddGv8Jjn38zyDyffKFe/AAQnQgiwPud42C5y2rIf3lphBCXVE30mxsxnnvx6SvhNrS1aTV1sJ3goNwjFFcf3HUpDr8ppAh16Sb2WehIow27NeSiVp9PUO51sYkAGKTURG9AR9/KBkEPkcPt4LM19jmdVGl8ueCo4Mbp80x++L5c=
X-Mailgun-Sid: WyJkMjhkYyIsImxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnIiwiMzdlMTdhYyJd
Received: from MENTATL04-3 (host-39-195.ilsjcolo.stjoesph.il.us.clients.pavlovmedia.net
 [173.230.39.195]) by
 bb88357b52f232183c3d3d25690ffce3ce658099ffb6182f37754c03f1110822 with SMTP id
 6b09bb5e050caec93e7d9db3 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 27 Nov 2026 17:18:22 GMT
X-Mailgun-Sending-Ip: 143.55.232.4
Sender: elijah@elijahmock.com
From: Elijah Mock <elijah@elijahmock.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: button: Disable default lid wakeup on MSI MS-15FK
Date: Fri, 27 Nov 2026 11:18:01 -0600
Message-ID: <20261127171801.5814-1-elijah@elijahmock.com>
X-Mailer: git-send-email 2.56.1
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

On the MSI Creator A16 AI+ A3HVFG (board MS-15FK), the system fails to
enter s2idle hardware sleep due to a firmware quirk exposed in v7.0.

ACPI behavior of the device: LID0 (PNP0C0D) defines a _PRW package
referencing GPE 0x03 with wake state S0 and no AML handler (_L03/_E03);
the status bit for GPE 0x03 remains 1 regardless of the physical lid
state. Lid open/close detection via the Embedded Controller (GPE 0x0A)
functions correctly.

Following commit 52d864019636 ("ACPI: button: Convert the driver to a
platform one") and commit 57c31e6d620f ("ACPI: scan: Use
acpi_setup_gpe_for_wake() for buttons"), GPE 0x03 is armed for wakeup
during suspend, which immediately causes a spurious wakeup (regardless
of whether the lid is open or closed) [1].

To prevent this issue, add a DMI quirk for board MS-15FK so that
devm_acpi_button_init_wakeup() marks LID0 as wakeup-capable via
device_set_wakeup_capable(dev, true) but does not enable wakeup by
default with device_init_wakeup(dev, true); instead, the EC lid
detection delivers necessary wakeup events. This fixes
suspend-to-idle while preserving normal lid state reporting and
preserving the lid wakeup event handler for user space.

Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one")
Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5283 [1]
Cc: stable@vger.kernel.org
Signed-off-by: Elijah Mock <elijah@elijahmock.com>
---
v1 -> v2: Added new quirk into existing quirk array, using a struct to
specify lid init state and wakeup overrides. Only one DMI check via a
static var to track lid_no_wakeup. (Per review feedback.)

v1: https://lore.kernel.org/linux-acpi/20261124182046.33252-1-elijah@elijahmock.com/

Testing:
- Tested on MSI Creator A16 AI+ A3HVFG (BIOS E15FKAMS.321, 09/17/2026)
  on top of mainline (v7.4-rc4+)
- Verified hardware sleep with lid open and lid closed, using amd-s2idle
  test
- Verified awake lid state reporting (/proc/acpi/button/lid/LID0/state)

Notes for reviewers:
- I am supposing that this is a firmware quirk matching MS-15FK (largely
  due to this issue not being widely reported) and not a generic ACPI
  kernel issue
- The Fixes: tags reference the commits that exposed this firmware
  quirk; let me know if they are not appropriate

 drivers/acpi/button.c | 81 +++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 91a4e9698f7..962e08b2c2a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -48,6 +48,24 @@ enum {
 	ACPI_BUTTON_LID_INIT_DISABLED,
 };
 
+struct acpi_lid_quirk {
+	long init_state;
+	bool no_wakeup;
+};
+
+static const struct acpi_lid_quirk lid_quirk_disabled = {
+	.init_state = ACPI_BUTTON_LID_INIT_DISABLED,
+};
+
+static const struct acpi_lid_quirk lid_quirk_open = {
+	.init_state = ACPI_BUTTON_LID_INIT_OPEN,
+};
+
+static const struct acpi_lid_quirk lid_quirk_no_wakeup = {
+	.init_state = ACPI_BUTTON_LID_INIT_METHOD,
+	.no_wakeup = true,
+};
+
 static const char * const lid_init_state_str[] = {
 	[ACPI_BUTTON_LID_INIT_IGNORE]		= "ignore",
 	[ACPI_BUTTON_LID_INIT_OPEN]		= "open",
@@ -78,7 +96,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "T701"),
 			DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+		.driver_data = (void *)&lid_quirk_disabled,
 	},
 	{
 		/* Nextbook Ares 8A tablet, _LID device always reports lid closed */
@@ -87,7 +105,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
 			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+		.driver_data = (void *)&lid_quirk_disabled,
 	},
 	{
 		/*
@@ -98,7 +116,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82BG"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
 	},
 	{
 		/*
@@ -109,7 +127,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "E2215T"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
 	},
 	{
 		/*
@@ -120,7 +138,21 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "E2228T"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
+	},
+	{
+		/*
+		 * MSI Creator A16 AI+ A3HVFG (MS-15FK): LID0 declares a
+		 * handlerless _PRW GPE (0x03) with S0 wake state whose status
+		 * bit stays asserted regardless of lid state, aborting s2idle
+		 * immediately when armed for wakeup.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR,
+				  "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-15FK"),
+		},
+		.driver_data = (void *)&lid_quirk_no_wakeup,
 	},
 	{
 		/*
@@ -131,7 +163,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
 	},
 	{
 		/*
@@ -142,7 +174,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Blade Pro 17 (Early 2020) - RZ09-0329"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
 	},
 	{
 		/*
@@ -154,7 +186,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Blade Stealth 13 (Early 2020) - RZ09-0310"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
 	},
 	{
 		/*
@@ -165,7 +197,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
 		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+		.driver_data = (void *)&lid_quirk_open,
 	},
 	{}
 };
@@ -209,6 +241,8 @@ struct acpi_button {
 
 static long lid_init_state = -1;
 
+static bool lid_no_wakeup;
+
 static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
@@ -570,9 +604,14 @@ static void acpi_button_wakeup_cleanup(void *data)
 	device_init_wakeup(data, false);
 }
 
-static int devm_acpi_button_init_wakeup(struct device *dev)
+static int devm_acpi_button_init_wakeup(struct device *dev, u8 button_type)
 {
-	device_init_wakeup(dev, true);
+	if (lid_no_wakeup && button_type == ACPI_BUTTON_TYPE_LID) {
+		dev_info(dev, "Disabling default wakeup due to DMI quirk\n");
+		device_set_wakeup_capable(dev, true);
+	} else {
+		device_init_wakeup(dev, true);
+	}
 	return devm_add_action_or_reset(dev, acpi_button_wakeup_cleanup, dev);
 }
 
@@ -747,7 +786,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = devm_acpi_button_init_wakeup(dev);
+	error = devm_acpi_button_init_wakeup(dev, button_type);
 	if (error)
 		return error;
 
@@ -812,14 +851,18 @@ MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
 static int __init acpi_button_init(void)
 {
-	const struct dmi_system_id *dmi_id;
+	const struct dmi_system_id *dmi_id = dmi_first_match(dmi_lid_quirks);
 
-	if (lid_init_state == -1) {
-		dmi_id = dmi_first_match(dmi_lid_quirks);
-		if (dmi_id)
-			lid_init_state = (long)dmi_id->driver_data;
-		else
-			lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+	if (dmi_id) {
+		const struct acpi_lid_quirk *quirk = dmi_id->driver_data;
+
+		if (quirk->no_wakeup)
+			lid_no_wakeup = true;
+
+		if (lid_init_state == -1)
+			lid_init_state = quirk->init_state;
+	} else if (lid_init_state == -1) {
+		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 	}
 
 	/*

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1

