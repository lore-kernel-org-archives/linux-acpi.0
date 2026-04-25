Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E23624BA;
	Sat, 25 Apr 2026 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154275; cv=none; b=kYai4W5OxYo8fsLvTo51vjqBFlD0Ef3iBdJb87dR5HvsMMPRqOmXq7HR4Wox83/ALtwQeg+a+4rOVwQdNWNIt8TLXJ+bLCnBlBwPxMobFVNDlD62HMeDacVX9D3rDDQpvSn+vxekiEyNNB4uxzM13uMZIPDTgfqcv7qPxE0JAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154275; c=relaxed/simple;
	bh=HiJCzb9okeo00q1x6tCFqB+QDJUhLSUHehqK4oLogZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0lWXx1+gmPZTvRniW5HJJ6fZxXz0giBUsOu7F/TdfjCO2U61AfxK+2GvEBRAjiESs1VuNnrByg20gjxUTRE+gvQUaRYU1rYTuUH1Gi4OCsCzjesYsZwV3zGmJLHauS6WWtLFC35yLBVQjstV8CRWskpM8tx9kGtqGBFHtQ03wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XIFHl8Rl; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XIFHl8Rl"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id B8E77C186F;
	Sun, 26 Apr 2026 00:57:49 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 05D0AC1834;
	Sun, 26 Apr 2026 00:57:49 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D31FC1FD3FD;
	Sun, 26 Apr 2026 00:57:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154268;
	bh=UT6tSU5gvSv2Y7sPiVe/IObxyHQxW4gU9ixTtrKvIac=; h=From:To:Subject;
	b=XIFHl8RlAw1yLFZZTUrIOtt3dkMMxtmVpXVYDn88hGhHddAipWD9YzGOTaxPvvtWb
	 jCUhW5yechbzpD8ddzm4hMNyjU9IoBMKHP6QbdWT4dsc64iYGAOoPl9aSpftJy0kdI
	 ko3p6jCqHm+QOsxSb5ZxG7qGAoFreezEkF8Doj96RbCcR5uiKoJfoC+2RLGNQaDHZ1
	 ScuYzwkqONcqYC9pmDStLcSDG+zwW3Qq5vuisGeTA2jemJ4UTQCPYjMPTH/r3qMiCm
	 THUZVpCobMWzQ2nWt7iYYiswnitYVug/chWbiAUFwiQQd/q9mYzo+fSoo7VASBXEnw
	 AdUXlpR3WRmiQ==
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
Subject: [RFC v2 06/10] platform/x86: asus-wmi: Remove Ally s2idle resume
 fixes
Date: Sat, 25 Apr 2026 23:57:30 +0200
Message-ID: <20260425215734.14116-7-lkml@antheas.dev>
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
 <177715426860.3678178.697834581548293844@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Ally device controllers had suspend issues due to the faulty s2idle
ordering present in the kernel, causing a failure to resume. These
issues were partially addressed with a firmware update, leading to
the introduction of a version check in hid-asus and accompanying calls
in this driver.

However, after fixing the call ordering in s2idle and adding a small
delay particularly for Ally devices, the controller for these devices
is universally fixed for all firmware versions, including the spurious
resume bug requiring set_ally_mcu_powersave(True) for the controller to
function correctly on newer firmwares.

Therefore, remove the calls, suspend quirks with CSEE duplicate calling
(it was always called by s2idle through the Display Off _DSM but ignored
while the USB subsystem was down and these calls took place), and
cleanup the driver.

Noteworthy is that we no longer force mcu_powersave to be on boot. This
way, the user's choice in e.g. Windows or from userspace software is
respected. Downstream distributions that care about the additional power
draw in lieu of the significant additional delay in resume introduced by
the setting can enable it with a udev rule (the canonical handling for
this functionality).

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-wmi.c            | 124 ---------------------
 include/linux/platform_data/x86/asus-wmi.h |   8 --
 2 files changed, 132 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3316415abbdf..70c725ca0edd 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -140,33 +140,10 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_MINI_LED_2024_STRONG	0x01
 #define ASUS_MINI_LED_2024_OFF		0x02
 
-#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
-/*
- * The period required to wait after screen off/on/s2idle.check in MS.
- * Time here greatly impacts the wake behaviour. Used in suspend/wake.
- */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT	600
-#define ASUS_USB0_PWR_EC0_CSEE_OFF	0xB7
-#define ASUS_USB0_PWR_EC0_CSEE_ON	0xB8
-
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
-static const struct dmi_system_id asus_rog_ally_device[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
-		},
-	},
-	{ },
-};
-
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -341,9 +318,6 @@ struct asus_wmi {
 	struct acpi_s2idle_dev_ops s2idle_dev_ops;
 };
 
-/* Global to allow setting externally without requiring driver data */
-static enum asus_ally_mcu_hack use_ally_mcu_hack = ASUS_WMI_ALLY_MCU_HACK_INIT;
-
 #if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static void asus_wmi_show_deprecated(void)
 {
@@ -1436,43 +1410,6 @@ static DEVICE_ATTR_RW(nv_temp_target);
 
 /* Ally MCU Powersave ********************************************************/
 
-/*
- * The HID driver needs to check MCU version and set this to false if the MCU FW
- * version is >= the minimum requirements. New FW do not need the hacks.
- */
-void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
-{
-	use_ally_mcu_hack = status;
-	pr_debug("%s Ally MCU suspend quirk\n",
-		 status == ASUS_WMI_ALLY_MCU_HACK_ENABLED ? "Enabled" : "Disabled");
-}
-EXPORT_SYMBOL_NS_GPL(set_ally_mcu_hack, "ASUS_WMI");
-
-/*
- * mcu_powersave should be enabled always, as it is fixed in MCU FW versions:
- * - v313 for Ally X
- * - v319 for Ally 1
- * The HID driver checks MCU versions and so should set this if requirements match
- */
-void set_ally_mcu_powersave(bool enabled)
-{
-	int result, err;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, enabled, &result);
-	if (err) {
-		pr_warn("Failed to set MCU powersave: %d\n", err);
-		return;
-	}
-	if (result > 1) {
-		pr_warn("Failed to set MCU powersave (result): 0x%x\n", result);
-		return;
-	}
-
-	pr_debug("%s MCU Powersave\n",
-		 enabled ? "Enabled" : "Disabled");
-}
-EXPORT_SYMBOL_NS_GPL(set_ally_mcu_powersave, "ASUS_WMI");
-
 #if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t mcu_powersave_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -5038,21 +4975,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 		acpi_register_lps0_dev(&asus->s2idle_dev_ops);
 	}
 
-	if (use_ally_mcu_hack == ASUS_WMI_ALLY_MCU_HACK_INIT) {
-		if (acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-					&& dmi_check_system(asus_rog_ally_device))
-			use_ally_mcu_hack = ASUS_WMI_ALLY_MCU_HACK_ENABLED;
-		if (dmi_match(DMI_BOARD_NAME, "RC71")) {
-			/*
-			 * These steps ensure the device is in a valid good state, this is
-			 * especially important for the Ally 1 after a reboot.
-			 */
-			acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE,
-						   ASUS_USB0_PWR_EC0_CSEE_ON);
-			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-		}
-	}
-
 	/* ensure defaults for tunables */
 #if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 	asus->ppt_pl2_sppt = 5;
@@ -5306,51 +5228,10 @@ static int asus_hotk_restore(struct device *device)
 	return 0;
 }
 
-static int asus_hotk_prepare(struct device *device)
-{
-	if (use_ally_mcu_hack == ASUS_WMI_ALLY_MCU_HACK_ENABLED) {
-		acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE,
-					   ASUS_USB0_PWR_EC0_CSEE_OFF);
-		msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-	}
-	return 0;
-}
-
-#if defined(CONFIG_SUSPEND)
-static void asus_ally_s2idle_restore(void)
-{
-	if (use_ally_mcu_hack == ASUS_WMI_ALLY_MCU_HACK_ENABLED) {
-		acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE,
-					   ASUS_USB0_PWR_EC0_CSEE_ON);
-		msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-	}
-}
-
-/* Use only for Ally devices due to the wake_on_ac */
-static struct acpi_s2idle_dev_ops asus_ally_s2idle_dev_ops = {
-	.restore = asus_ally_s2idle_restore,
-};
-
-static void asus_s2idle_check_register(void)
-{
-	if (acpi_register_lps0_dev(&asus_ally_s2idle_dev_ops))
-		pr_warn("failed to register LPS0 sleep handler in asus-wmi\n");
-}
-
-static void asus_s2idle_check_unregister(void)
-{
-	acpi_unregister_lps0_dev(&asus_ally_s2idle_dev_ops);
-}
-#else
-static void asus_s2idle_check_register(void) {}
-static void asus_s2idle_check_unregister(void) {}
-#endif /* CONFIG_SUSPEND */
-
 static const struct dev_pm_ops asus_pm_ops = {
 	.thaw = asus_hotk_thaw,
 	.restore = asus_hotk_restore,
 	.resume = asus_hotk_resume,
-	.prepare = asus_hotk_prepare,
 };
 
 /* Registration ***************************************************************/
@@ -5377,11 +5258,7 @@ static int asus_wmi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	asus_s2idle_check_register();
-
 	ret = asus_wmi_add(pdev);
-	if (ret)
-		asus_s2idle_check_unregister();
 
 	return ret;
 }
@@ -5418,7 +5295,6 @@ EXPORT_SYMBOL_GPL(asus_wmi_register_driver);
 void asus_wmi_unregister_driver(struct asus_wmi_driver *driver)
 {
 	guard(mutex)(&register_mutex);
-	asus_s2idle_check_unregister();
 
 	platform_device_unregister(driver->platform_device);
 	platform_driver_unregister(&driver->platform_driver);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 554f41b827e1..938a27c6f66e 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -188,8 +188,6 @@ enum asus_hid_event {
 #define ASUS_EV_MAX_BRIGHTNESS 3
 
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
-void set_ally_mcu_hack(enum asus_ally_mcu_hack status);
-void set_ally_mcu_powersave(bool enabled);
 int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
 int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
@@ -197,12 +195,6 @@ int asus_hid_register_listener(struct asus_hid_listener *cdev);
 void asus_hid_unregister_listener(struct asus_hid_listener *cdev);
 int asus_hid_event(enum asus_hid_event event);
 #else
-static inline void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
-{
-}
-static inline void set_ally_mcu_powersave(bool enabled)
-{
-}
 static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return -ENODEV;
-- 
2.53.0


