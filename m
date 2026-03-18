Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCE3F54A1;
	Wed, 18 Mar 2026 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862913; cv=none; b=WLWZVsJWP9th0ZstPhvGvsd3qBHcJx0UVgksTh2veuTbmIn3RUEo718QK//PDm/2Vofkj93QXIRvTS+2LyckA7eK6pkyrHX9aUYCAOhs1uiMEe5uiP/nXhw4S8h+wLMB3444aGQ2s1APWp3HUrsV7vlh6ySfmJ+GO7Wb7hTtWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862913; c=relaxed/simple;
	bh=WdFpObdX3K+SrahdSN6Thlpa17PD7bpIQCO5+p1yFhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuVHKve3oOKt9PjiMgz7RSBrbYJ0Guo7DsFQNQjiqbzQ7Kn4+PetsUb9r+fVKIr+dAD80q1MFbNIo9gQfTkgTDt1dNDtOx8f+Z6WZkzweXLEgpGhEggbbsUMEaOnF37FUtDsd8ApQ45lDXHf4WleLZujmaYQDNRD7DjDn48KeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsTaoxc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsTaoxc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1873DC2BC9E;
	Wed, 18 Mar 2026 19:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773862913;
	bh=WdFpObdX3K+SrahdSN6Thlpa17PD7bpIQCO5+p1yFhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsTaoxc7NCCnfoouxv+zKWoF43mxhMWWRMc1Dt5Q2rAl3L65Z4wTSP0mJN/bILPpx
	 juB2Il/rMSulqbrxeu2VBQgX+MO/Ah55VcHS6V6CYjC/y5fAnmaWSQ9tDxmWAiVmwB
	 yYCyBe464jWZNgFOpVEooRlHDJzN+1Y4OsX1lTJ2PK03bDz4s9qqI1sWJ6a4Ene3Dk
	 QQLOeXMr3m7XEM6eSG5b37q3GSvvfuWJDmU6Dd52THzlkcERrue7E3QDgog4095x2U
	 6JNjImAykYfA05w7G+6za9GqsoTWRsRFog2Dru/8lE+gpkMsTis4Ab/ZFXnXXjE6TH
	 VdCXfk+qPKTzQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v2 3/4] platform/x86: panasonic-laptop: Register ACPI notify handler
 directly
Date: Wed, 18 Mar 2026 20:40:13 +0100
Message-ID: <3039115.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5979471.DvuYhMxLoT@rafael.j.wysocki>
References: <5979471.DvuYhMxLoT@rafael.j.wysocki>
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

v1 -> v2: Adjust remove code ordering to match probe rollback code
   ordering (Ilpo)

---
 drivers/platform/x86/panasonic-laptop.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 8825142ea9de..6d776bb1c5d1 100644
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
@@ -1100,6 +1104,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 out_platform:
 	platform_device_unregister(pcc->platform);
+out_notify_handler:
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_pcc_hotkey_notify);
 out_sysfs:
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 out_backlight:
@@ -1126,6 +1133,9 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 		platform_device_unregister(pcc->platform);
 	}
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_pcc_hotkey_notify);
+
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
 	backlight_device_unregister(pcc->backlight);
-- 
2.51.0




