Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EB2C08AD;
	Fri, 20 Mar 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002994; cv=none; b=NmeQi7Ca8jdpY95XIDciZ87sEWJZxJPw2ZBxGoAmOW205S0XVOiZOnKPntogiHhhQQzXLZrvovqEsM15CeYpMu5dxA4hBi6LMqimx0NflHCtZffQ5UMxMrKYKSXqlJnuZniUv480w/RFXNxGTaRqu5UhjIX+Q2QD5XKa47vL/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002994; c=relaxed/simple;
	bh=51T1Y85kq2tY1wWu4pWqfkhO2W6py4pr5YHSxW+Yap4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z23VXjmyoUW9LRwiFD/TCDFUFirwf/gFgKCwe+GYpuipQPnujrceWYaSdEchDdm0y6f3l44hsVcM+VFwqIPS6z+CqrytjU6R5CS0kgBch4o+zA+0epVtBFFsqy9V56pqirdSv43CNFZijQH1jkqHKqRbGeVt2EqG76F0vgVjeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKKlDbgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKKlDbgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445B2C4CEF7;
	Fri, 20 Mar 2026 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774002993;
	bh=51T1Y85kq2tY1wWu4pWqfkhO2W6py4pr5YHSxW+Yap4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKKlDbgHbL2lO/bQu4536dXP69htqvVxDli7svlju5tPtnwn59NuPT/KRhTzBSLop
	 VmIXVysfjO8RSwabFuFTfUbSxc/G9xb4aFe331f1h//5Zhgt7uH91VujGcKHJBCzc+
	 EvM61/BhLOmFCWHs6XgxNRpD4RTq0dgPTxJHnBJva6am2p/RsHng/FYN8XCSYaQlhZ
	 /BKCZaiYOBtavdu/KN5QiX1mQTdRtxx25sxp/ezDuwXM+hxuBTGGmQIe+r8fw0DlHg
	 gEE4qWAAj4Unmpmu7qK92AzOXSqMR1X4RmK/wf6llHyz7IQ14ywTdV0++U1z6/f5Du
	 fa47BVff4P95g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v4 5/5] platform/x86: panasonic-laptop: Convert ACPI driver to a
 platform one
Date: Fri, 20 Mar 2026 11:35:54 +0100
Message-ID: <8664183.T7Z3S40VBb@rafael.j.wysocki>
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

v3 -> v4: Clear device->driver_data in the probe rollback path

v1 -> v3: No changes

---
 drivers/platform/x86/panasonic-laptop.c | 34 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index e563298a6672..1337f7c49805 100644
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
@@ -964,7 +963,7 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_pcc_hotkey_resume(struct device *dev)
 {
-	struct pcc_acpi *pcc = acpi_driver_data(to_acpi_device(dev));
+	struct pcc_acpi *pcc = acpi_driver_data(ACPI_COMPANION(dev));
 
 	if (pcc->num_sifr > SINF_MUTE)
 		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
@@ -980,8 +979,9 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 }
 #endif
 
-static int acpi_pcc_hotkey_add(struct acpi_device *device)
+static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct backlight_properties props;
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
@@ -1107,6 +1107,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 out_input:
 	input_unregister_device(pcc->input_dev);
 out_sinf:
+	device->driver_data = NULL;
 	kfree(pcc->sinf);
 out_hotkey:
 	kfree(pcc);
@@ -1114,8 +1115,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	return result;
 }
 
-static void acpi_pcc_hotkey_remove(struct acpi_device *device)
+static void acpi_pcc_hotkey_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
 	i8042_remove_filter(panasonic_i8042_filter);
@@ -1135,8 +1137,10 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 
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




