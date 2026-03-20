Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD079396589;
	Fri, 20 Mar 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002998; cv=none; b=o5wn1aXlm2DuUzYBH1qDZVcklhywZFCHLlg0rSWNHs1Na0EpqJcHiFmPLR81CYn5HPqiMNjqILhFH7o5TTARcvuO78L8NWW+NmPT//dJBAqMy7bWtc+dLba1DgAaAMTMp05z99d7SSTbWF8l0LgR3N7z0PmrS6zOCx0TGBkky5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002998; c=relaxed/simple;
	bh=zRfCRsTGDY9+As67gK5rpiRSMotNN35Ew9p9Sg2K7a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQJ8jQmWzZaUXOSpWob6mpyYyz4km/SsntuMQL6DD28CZnVsk/3KACWUN9GKQ0L2Y0JS+KKvB7S0b8I1b8dmWPD8lImCUB5d9bv2Yzr9YrQEtE2vRUnq6xPtnxX6MA6v+tL8GeOnUivWWDv7NSzdc1L0nYLnCTD988dSK2O6kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsTB1cNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsTB1cNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B589C4CEF7;
	Fri, 20 Mar 2026 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774002998;
	bh=zRfCRsTGDY9+As67gK5rpiRSMotNN35Ew9p9Sg2K7a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsTB1cNVOW+kkYVHq9SveBhlNpQ5OmORR6XhV+qF5diHwQzbjCtQcDuR8Sq6EIVBP
	 6S7RQEqaqcv6rvwi6dzMUmnYaO/vmYUEiJd86MEhat+23uVFMzxBO+rwn/MrqGILqE
	 gzRKcjlWA+ae2uWZTJTmoVWQMhEtlU1W1noxjzVtFbYMZxHWtvTZwmMDmy7uxyJkuL
	 lEqvik8KbOpbcAc/fci9xwkI/5xfPMNZ7V0vhnKWMkZv+Q43w3+H3zmI4YgacqnKVC
	 B3BDbgQ2Rv+umZN+uqzb8Cd+/hA44DVRTIfN6YjgJ8J0i8VX/7j4ywxH91FNWIHzwH
	 af5X1Rl5krEAg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v4 4/5] platform/x86: panasonic-laptop: Register ACPI notify handler
 directly
Date: Fri, 20 Mar 2026 11:34:06 +0100
Message-ID: <13979037.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983583.DvuYhMxLoT@rafael.j.wysocki>
References: <5983583.DvuYhMxLoT@rafael.j.wysocki>
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

v2 -> v4: No changes

v1 -> v2: Adjust remove code ordering to match probe rollback code
   ordering (Ilpo)

---
 drivers/platform/x86/panasonic-laptop.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 188ec597a14e..e563298a6672 100644
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
@@ -1070,13 +1069,18 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
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
@@ -1093,6 +1097,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 out_platform:
 	platform_device_unregister(pcc->platform);
+out_notify_handler:
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_pcc_hotkey_notify);
 out_sysfs:
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 out_backlight:
@@ -1119,6 +1126,9 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 		platform_device_unregister(pcc->platform);
 	}
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_pcc_hotkey_notify);
+
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
 	backlight_device_unregister(pcc->backlight);
-- 
2.51.0




