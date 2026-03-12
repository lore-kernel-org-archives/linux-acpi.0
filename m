Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7E3A4538;
	Thu, 12 Mar 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314568; cv=none; b=pbMq78xc9avDVSTaLkix5c9u7YCbv5PzMRlgWPpeHhcj2d7mYqcTVl1scN9iNaLBgNzRKCBmv37TTzp+bczNRgWhg6xQQrPWXkIHiWCSpmJ8OvJ9HSYBKcTLkO8HwNw2NCTA7n2CjWzSXB4pqbqVogQXSDWjEdLtrMv4c5Cgl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314568; c=relaxed/simple;
	bh=7Uyz4Qbpa0MgFmz8C6y64f7wdSvnvxJl2SMddv/TkaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVhrGZXULlRIAriBV225sPODS8FmifRUTxTe79f/b93MQDhsRMFeuaRHtZDV4QrgccE4WAp+mrfKCxAjmLgc4EbTTZlMf92EpVumzq1g0gige8tvN4tfR3fmpRiM3eCa1rYxHQOaU2netszSo4DDbxAfS2jp1oTy10dLyLkMdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gru4LSS5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gru4LSS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D45C4CEF7;
	Thu, 12 Mar 2026 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314568;
	bh=7Uyz4Qbpa0MgFmz8C6y64f7wdSvnvxJl2SMddv/TkaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gru4LSS5DZfv252VDAgOGowQ3sBQf/n02ITEgX/BrJBbNThFAcCCEvJQK4ORMP9bR
	 AoVBzTIO4hFpNJRwsWzV2guAokhDDQR4U8OLCMrO9jEDoNmoIBK67R0aHxWL6v4lT0
	 GE8tMHLQ5PK78GGNUMdX2OP1OiRXGbkrRErSf9LEEKCahNJFbawxoh8nKfCoudz4Br
	 Ge1ayb5kHiVciiTlSYvic6s9d4LL6R+Qc3PWpK6Z23b70t2F8gsfvIod/tirIP/f6d
	 cw/LzqvfRB3ygIexFX2waFgGk2215VtydR5rlB4OquWm82osbdY7/S4dmm5Ka8C9As
	 MkEuenoRaQiug==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v1 3/3] platform/x86: panasonic-laptop: Convert ACPI driver to a
 platform one
Date: Thu, 12 Mar 2026 12:22:20 +0100
Message-ID: <3760406.R56niFO833@rafael.j.wysocki>
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

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Panasonic laptop ACPI driver to a platform
one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

To maintain backwards compatibility with possibly existing user space,
the sysfs attributes created by the driver under the ACPI device object
used by it are not relocated.  Accordingly, the driver will continue to
use the driver_data pointer in struct acpi_device which needs to be
cleared on driver removal.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 4bd83b987761..632d05adb6f3 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -183,8 +183,8 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 	};
 /* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
 
-static int acpi_pcc_hotkey_add(struct acpi_device *device);
-static void acpi_pcc_hotkey_remove(struct acpi_device *device);
+static int acpi_pcc_hotkey_probe(struct platform_device *pdev);
+static void acpi_pcc_hotkey_remove(struct platform_device *pdev);
 static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id pcc_device_ids[] = {
@@ -201,15 +201,14 @@ static int acpi_pcc_hotkey_resume(struct device *dev);
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_pcc_hotkey_pm, NULL, acpi_pcc_hotkey_resume);
 
-static struct acpi_driver acpi_pcc_driver = {
-	.name =		ACPI_PCC_DRIVER_NAME,
-	.class =	ACPI_PCC_CLASS,
-	.ids =		pcc_device_ids,
-	.ops =		{
-				.add =		acpi_pcc_hotkey_add,
-				.remove =	acpi_pcc_hotkey_remove,
-			},
-	.drv.pm =	&acpi_pcc_hotkey_pm,
+static struct platform_driver acpi_pcc_driver = {
+	.probe = acpi_pcc_hotkey_probe,
+	.remove = acpi_pcc_hotkey_remove,
+	.driver = {
+		.name = ACPI_PCC_DRIVER_NAME,
+		.acpi_match_table = pcc_device_ids,
+		.pm = &acpi_pcc_hotkey_pm,
+	},
 };
 
 static const struct key_entry panasonic_keymap[] = {
@@ -967,7 +966,7 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_pcc_hotkey_resume(struct device *dev)
 {
-	struct pcc_acpi *pcc = acpi_driver_data(to_acpi_device(dev));
+	struct pcc_acpi *pcc = acpi_driver_data(ACPI_COMPANION(dev));
 
 	if (pcc->num_sifr > SINF_MUTE)
 		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
@@ -983,8 +982,9 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 }
 #endif
 
-static int acpi_pcc_hotkey_add(struct acpi_device *device)
+static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct backlight_properties props;
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
@@ -1116,8 +1116,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	return result;
 }
 
-static void acpi_pcc_hotkey_remove(struct acpi_device *device)
+static void acpi_pcc_hotkey_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
 	i8042_remove_filter(panasonic_i8042_filter);
@@ -1137,8 +1138,10 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 
 	input_unregister_device(pcc->input_dev);
 
+	device->driver_data = NULL;
+
 	kfree(pcc->sinf);
 	kfree(pcc);
 }
 
-module_acpi_driver(acpi_pcc_driver);
+module_platform_driver(acpi_pcc_driver);
-- 
2.51.0




