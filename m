Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647738756E;
	Thu, 19 Mar 2026 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920014; cv=none; b=BnQxvdSrwSyU3mpWO4UGJsoh7ZbQ2lfFQhmYgVUvTYQ9k7Hj26cchKeGllOFbTOgpYZect8UlecoDz5p/uvDc0mII20E3yzCR4LZHFIDm0kuX9CswjZG7VlFYrpXenDykmzpEUcOCQU6NKLe9/NcLi94bwZqw+wRtic7E6nIjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920014; c=relaxed/simple;
	bh=hGg+SZteV3n4BqW/3k3sBTKPFWK1pGTm/PwaqMF5+Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTmSe4y0Q258sKKm/ogUOaB9RFvXjMV/zfngZbdBgZqV4OB2UAvyyoJ2bFv7UPMbWorJ8YERblUG/7Yk1R0ElPtzonBNRcjLrYh2kMSQEx0GR0dFL/zKmib5+jNcFI7pEy9eTJoAXdAw2fZQ06WDopZhGhgSdAALBJHQKVNAMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNFcUytD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNFcUytD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BC8C19424;
	Thu, 19 Mar 2026 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920014;
	bh=hGg+SZteV3n4BqW/3k3sBTKPFWK1pGTm/PwaqMF5+Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNFcUytD1QQA4D0hBdouiv8Lsl+B6ETV3JNvzxOHH9rRDxhjxXL9e3pRjyUmT9tsY
	 xN/Ia2lPSeYIl6SJmaR0O6CrKnm/TZzZnDr1T0f1jSc/V61/6bhAK8wolNfI4b0T3U
	 0ktdVOh+Qu+Gpp7orAFczWbqRlpn+nNO0HNERZJ1ibRzqvTZxbcRiG4+Wg8P6YvHiF
	 RGQ6IbsCufypa7webIaBDJVPIqrDC2EhSKUS3xmmYTrhKHLvSpUjxMByrozzdNjNgN
	 HCAS9TE/X7mU7JFr/Dpb1G06qzvPYdAaSkAdimk1dJu2QayGbkDgtfgte7qHlXNYmd
	 2I8ZfapICHW2A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v3 4/5] platform/x86: panasonic-laptop: Register ACPI notify handler
 directly
Date: Thu, 19 Mar 2026 12:30:58 +0100
Message-ID: <3413594.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863246.O9o76ZdvQC@rafael.j.wysocki>
References: <12863246.O9o76ZdvQC@rafael.j.wysocki>
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

v2 -> v3: No changes

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




