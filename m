Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F8364021;
	Sat, 25 Apr 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154275; cv=none; b=tUg7mhTofpraYrQ+oAsrjeU4S5bqBibgbH1yNauY1h6AUPeOrZPUY6GnHfEcnXppvOdS/y6U988PLEGxS5eYry3r5Gt6/Wphv/NYZ3/uwloiqdDiPtrsTvnzVta5oSlXM3zwo108UQnNNLC/PWBXsdH3TS1R5fOl4R71jZLX+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154275; c=relaxed/simple;
	bh=YD2uJqjynXYZ5kbG6NjfdGBit/uYJrRq5xHZ4pUB8D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srVPJdCS24hOOZ8Jn/Mbx5iTTDNcisfcBKS17yFNsPbluoCME14LjdnN46r1/0MC5KqB+mAizZHYvkOTp12zcixqtN7Il8AkWX3JYukscYG0gUCTFTp9Go4eRKkKOCUXkzW2GXABjtJqkAc5M7iNNNBaywFuvHJ1ka1MkN67t2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kBndYnJk; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kBndYnJk"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 42A33C1839;
	Sun, 26 Apr 2026 00:57:47 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id B83CFC1818;
	Sun, 26 Apr 2026 00:57:46 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 62BFD1FD3F5;
	Sun, 26 Apr 2026 00:57:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154266;
	bh=6NFWgb50ety8JDzGpmqrkBu/w2C6asiylhwI3zG12Rk=; h=From:To:Subject;
	b=kBndYnJkN6qwxdvEJhg8LQnadxoaYt+QzAYvyOb0QX3OaTUv1WqHyf6GbTyySHyKD
	 dolMQLhUV7OcKVQFF838kENTKlixV3WxwYIARVmWIC5jvS02Uf+BD88D6zW8Bho3bi
	 hfbv04hYTeGDMJUSRTzwrXCPmsFqzCrbaPDuKnRrYY8UQ/ogWpx/ukLuMblkcCcwNl
	 Je8qbhLPDgLhWZTzutsLYryeNJAbtxSKqp2N2wLc7eG1nRqPp7HI0lWGnmb/7ZCYX3
	 nxKYBs354vOJfbTV0DFBREVwPTdUMYCMSTnpC2nDoM0iTPHKTG1Rf8f8W+mHmWZSLc
	 EkCoRR/LdCYLA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v2 04/10] platform/x86: asus-wmi: add s2idle begin delay for
 Ally devices
Date: Sat, 25 Apr 2026 23:57:28 +0200
Message-ID: <20260425215734.14116-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
References: <20260425215734.14116-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715426636.3678028.7224113446620385481@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Asus ROG Ally devices have a small fade animation during their suspend
sequence. This animation is triggered by the Display Off firmware
notification. After it, they power off, disconnect, and save their
state. Without a delay after that notification, if the device is placed
into D3, it causes it to reboot during resume, or particularly for
original Allies, also leave the xpad device connected, causing spurious
wakeups when a gamepad button is pressed and higher standby drain.

Therefore, introduce a small delay quirk and bind it to an s2idle dev
ops device. Place this quirk in the asus-wmi driver, as the USB gamepad
disconnects, making it hard to place in hid-asus, and to allow for
proper functionality when the hid-asus driver is blacklisted.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 40 ++++++++++++++++++++++++++++++
 drivers/platform/x86/asus-wmi.c    | 12 +++++++++
 drivers/platform/x86/asus-wmi.h    | 14 +++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b4677c5bba5b..da963f3a17b1 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -155,6 +155,10 @@ static struct quirk_entry quirk_asus_z13 = {
 	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
+static struct quirk_entry quirk_ally = {
+	.lps0_begin_delay = 500,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -553,6 +557,42 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_z13,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Ally",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
+		},
+		.driver_data = (void *)&quirk_ally,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Ally X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
+		},
+		.driver_data = (void *)&quirk_ally,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Xbox Ally",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "RC73Y"),
+		},
+		.driver_data = (void *)&quirk_ally,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Xbox Ally X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "RC73X"),
+		},
+		.driver_data = (void *)&quirk_ally,
+	},
 	{},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7c0915e097ba..3316415abbdf 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -337,6 +337,8 @@ struct asus_wmi {
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
+
+	struct acpi_s2idle_dev_ops s2idle_dev_ops;
 };
 
 /* Global to allow setting externally without requiring driver data */
@@ -5030,6 +5032,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	if (asus->driver->quirks->lps0_begin_delay) {
+		asus->s2idle_dev_ops.begin_delay =
+			asus->driver->quirks->lps0_begin_delay;
+		acpi_register_lps0_dev(&asus->s2idle_dev_ops);
+	}
+
 	if (use_ally_mcu_hack == ASUS_WMI_ALLY_MCU_HACK_INIT) {
 		if (acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
 					&& dmi_check_system(asus_rog_ally_device))
@@ -5184,6 +5192,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 fail_fan_boost_mode:
+	if (asus->driver->quirks->lps0_begin_delay)
+		acpi_unregister_lps0_dev(&asus->s2idle_dev_ops);
 fail_platform:
 	kfree(asus);
 	return err;
@@ -5207,6 +5217,8 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_fan_set_auto(asus);
 	throttle_thermal_policy_set_default(asus);
 	asus_wmi_battery_exit(asus);
+	if (asus->driver->quirks->lps0_begin_delay)
+		acpi_unregister_lps0_dev(&asus->s2idle_dev_ops);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 5cd4392b964e..2a8c51d39bf8 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -52,6 +52,20 @@ struct quirk_entry {
 	 */
 	int no_display_toggle;
 	u32 xusb2pr;
+	/*
+	 * Ally devices uninitialize after the display off DSM of modern
+	 * stanby, after a predetermined fade animation on their RGB.
+	 * If the USB subsystem puts the controller into D3 before that,
+	 * it loses its state and (i) for original allies, it leaves the
+	 * xpad device connected, causing spurious wake-ups and higher
+	 * power draw, (ii) for newer allies using the adaptive protocol
+	 * causes the controller to reboot on resume if mcu_powersave is
+	 * false. Therefore, allow adding a delay for the affected devices.
+	 * (if MCU powersave is true the controller always reboots, but
+	 * this also causes an unwelcome 5-7s delay on resume, this issue
+	 * is present on all firmwares)
+	 */
+	int lps0_begin_delay;
 };
 
 struct asus_wmi_driver {
-- 
2.53.0


