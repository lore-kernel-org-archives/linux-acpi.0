Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8F3A4538;
	Thu, 12 Mar 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314572; cv=none; b=SU85NbCogstl2VbFS4vcxn6FNckcaSBU06Nvew63dZvD5Rwb2hjC/okFmX0RG0eH2P9HwzEHl/dcMPFSoXonDfkG15Rx5iGjOhRbBdLnCUCfBguC01KnahxEytjfa2wx62TZGtLbd1PXPJR43WyGShGxp4tjSbpqxwAE2bYpwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314572; c=relaxed/simple;
	bh=z1rSlolLYfZeTsgj5kSRFZv+4n7rmLPxLyxVyQctzMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRJWY/t77JVCpIvVCcl0t9zCSSBaiD1rDGZcI1NTFToQlPDBteVArEq798ZFzICgdzXAjMrMtAio/oCNMKSgkGrEdxhvi7comNm0ySLu0jLS1jUE/dnwmblcQlVglRMwBdFolCuRzKnoRkfZ8Ey7sTYa3qNoRPWvDlcET0pV3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiuErgJb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiuErgJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8B1C4CEF7;
	Thu, 12 Mar 2026 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314572;
	bh=z1rSlolLYfZeTsgj5kSRFZv+4n7rmLPxLyxVyQctzMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiuErgJbcaf2f09+Ij3pExqRCSB0+ZNVd1BfkIJityTkoiTBx0xtupEIgZ3aKLt0V
	 A7dfV34VnNrx28q1MHbr/Rf70XaruMrJTJEnQApMOmGaxTokSUkbzzhk3FeXGFY83D
	 rEG958n2UtQIXhaWy4fVj8YZJZd4h3y6Y4kbDjAGmWhnQApz3uJO3+iDwuNcMH6knE
	 czTn2KcZMpmFKA3Ef/mCTYjE1tHIxa0Q+I4WdQNCmQwO3RK+HCoh6CfpCC/zqLodfR
	 iCUfqjAoakGGDxonJqFvr50mA0PckVK3xkGLG/zOT2fLsHZo/Kul0KR0gx+LwHtXAB
	 EQRCnm8kmbRWQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v1 2/3] platform/x86: panasonic-laptop: Register ACPI notify handler
 directly
Date: Thu, 12 Mar 2026 12:21:15 +0100
Message-ID: <4508640.ejJDZkT8p0@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3616223.QJadu78ljV@rafael.j.wysocki>
References: <3616223.QJadu78ljV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 64195ff0f40e..4bd83b987761 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -185,7 +185,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 
 static int acpi_pcc_hotkey_add(struct acpi_device *device);
 static void acpi_pcc_hotkey_remove(struct acpi_device *device);
-static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
+static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id pcc_device_ids[] = {
 	{ "MAT0012", 0},
@@ -208,7 +208,6 @@ static struct acpi_driver acpi_pcc_driver = {
 	.ops =		{
 				.add =		acpi_pcc_hotkey_add,
 				.remove =	acpi_pcc_hotkey_remove,
-				.notify =	acpi_pcc_hotkey_notify,
 			},
 	.drv.pm =	&acpi_pcc_hotkey_pm,
 };
@@ -869,9 +868,9 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 		pr_err("Unknown hotkey event: 0x%04llx\n", result);
 }
 
-static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
+static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct pcc_acpi *pcc = acpi_driver_data(device);
+	struct pcc_acpi *pcc = data;
 
 	switch (event) {
 	case HKEY_NOTIFY:
@@ -1073,13 +1072,18 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	if (result)
 		goto out_backlight;
 
+	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+						 acpi_pcc_hotkey_notify, pcc);
+	if (result)
+		goto out_sysfs;
+
 	/* optical drive initialization */
 	if (ACPI_SUCCESS(check_optd_present())) {
 		pcc->platform = platform_device_register_simple("panasonic",
 			PLATFORM_DEVID_NONE, NULL, 0);
 		if (IS_ERR(pcc->platform)) {
 			result = PTR_ERR(pcc->platform);
-			goto out_sysfs;
+			goto out_notify_handler;
 		}
 		result = device_create_file(&pcc->platform->dev,
 			&dev_attr_cdpower);
@@ -1095,6 +1099,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 out_platform:
 	platform_device_unregister(pcc->platform);
+out_notify_handler:
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_pcc_hotkey_notify);
 out_sysfs:
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 out_backlight:
@@ -1123,6 +1130,9 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_pcc_hotkey_notify);
+
 	backlight_device_unregister(pcc->backlight);
 
 	input_unregister_device(pcc->input_dev);
-- 
2.51.0




