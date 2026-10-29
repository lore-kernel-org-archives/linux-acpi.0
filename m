Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286874;
	b=NpAByEIXdCACSWw9KZJbLH/RC+iQFVvENOGiKd3iod+Yebs47KgyvAJOW2rF1FODuyOk
	 FcH2im64NrE1SI0c99H9b9rAf4Y/5AxE/Ib0twxhUgl51oZUMM9ze7h4tkuzPWc6lMhV6
	 61EKyjytFU9FiYvvBiTYrGdrKhfSgoUbk69vUAffSPaBCGq/pWo2fRkhJoyaQ9P+9PE6q
	 JJono1n/09csHa6fPSYc/wgQrCVG1H7VgIZpOtvihX4WT3+g4xVufslZ8j41dnIVtsvCI
	 CyEMvIbzNcvnVMs+gNZQFEdiAx2G6CFuFdG6eadvje46TOliw2DFZGY/sB538HbXk8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=656z9fhQ5cGnqtPuc95+Ef4gq6f7TVUGHYROSC69+kM=;
	b=oq19YOAQJyc6kqrCDwlAQWAl415RiYubKHntCH1TywRqShrWz5t2IfE9zIJZcHZcmA9q
	 KtOlGBXNuwAuOd1cAEnUDKlGlNy17LAgo4uORiBr1bWkjN0IxCLF9IhcQEJmpNs2guALa
	 BGM8R62Cok45NRDeyPolZMCLwiCj+OrKl8xslIAyyYXPnPMj9lYh5hkhrsbffxNj1ey/F
	 fH9abNRIKw2F8INRLwvMliRaUuPp3DmRjO7inUrDjkRZeLieX76VqhB/HGewT1evMMWqz
	 NInHFysFIJNCq8g4aCG0YPTvOjzJg3hHfb/hg/7f6KpKa6JUH2pq/N6lkFHOifC+XbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fireburn.co.uk;
	spf=none smtp.mailfrom=fireburn.co.uk;
	dkim=pass header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pplmasxf;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64C606A32C
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 15:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB64C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pplmasxf
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1315925f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793286872; x=1793891672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=656z9fhQ5cGnqtPuc95+Ef4gq6f7TVUGHYROSC69+kM=;
        b=PplmasxfMVqu/03omaiPwWqfYhc/HSspGiptKX9Jplg5TBCNzqTg6WUX4QhaNgtbbO
         SUrL4uOWc5Qr/W5SQJy3L9OIMcirbqV1fJUAuEnIeu6ZOxAaylRpVT3WLImylqcpsmpA
         zm5b7yM4fZgLSjF4BJvlgmVPiCoOvhKPFG8tOrlRe2zbN+Uxbsllg4fhpqcmVqTknyI2
         2kLNYYGK4VvCJUBEIDSIrPzQ+09OFhLyh/uHu8PIJPxIU/lPQypNbcWGY/SRE5GrBx5h
         YBhrAAqekmtMpYAYLhTS+QdCbSC71gfnIencqH7VFIBXWdzgLzNYi97GER3NZIYeNTgg
         IvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286872; x=1793891672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=656z9fhQ5cGnqtPuc95+Ef4gq6f7TVUGHYROSC69+kM=;
        b=H5YRovohA1fqtlx99Y3uV+pA4sXiA3B78nYmsoH5gLsSGl05/mLbmursG+a4XIV2Rt
         evrA8r3NhYuKAn4z127l3uFwQejlXTgIK45Dgt0BM+o/L4q7JJBOJJNW8mtW9pDV1mVw
         RNT+OJ68ucTcY8bLR3RgRkPoTB+jEPaxCFQIUSHj/TQot10mDxexf41T5JH4Fav0aRsI
         vjPrtOMQ49HloPFsMikAN7Ds34yrFA2sqEzBURRU6ruu7NcNssM7OHag8u02M9JFKOKG
         GJDEJlkhaZ1M98m6q124U04MdQ+Gi6q/h05o4fN7inn0mt/xDGDpDRaCP0AdCx+73TxW
         snRw==
X-Forwarded-Encrypted: i=1; AKwUvBzxf/CZXtx/8/3uZy1ME6iKK2X3sJybceW4ieUMqO7eNWZHeE7Mwz7zsiv6M5qPf+DrWJLn3tSpj50R@vger.kernel.org
X-Gm-Message-State: AFq9FYKDkKZZYMo6rznHPRSyfLR2jJ6UYOMbO6gTkgtcgmvC/vFbUoFZ
	4KPi909WsuuY2wPkj27Eg20sJCRff9/3oG7sN/oLnIBaBfE2vSWqYYlIovZTWjl/OLkQtruSHgW
	12xAf/FR6
X-Gm-Gg: AYBFou1wSL+9In2pLj5y11prQZ+QY324nhAsqOSA90eO/ZI04guDeFnJ++XNodMXF2W
	ziVHVyh1PZ2lx9oDWZJmefnbVK2KmJfCewtYJzQVr+yVtb2WBCkdyY0fJbM06F8oejmevFELoZa
	QhU9iz0k1pRZ40j2DHR2Pn9sOYJWX9C9jxNGsJXeSw3J8Nr/ndiAZ0R5LZkF+GukkYJIzE7herJ
	hOxZ50cn2Mbe9lqElq0CMBVFrcwzVdw3WwssZ1IGiM4MRb8oNA7yHCTuKtPxrW93cLI2PyHZzPv
	G5ORPU0KI2nkT+pPzVvm+WuVJh50iSRV5Q2nO/o4YhTV6a8I1c2ZwPEkmk6FnNPgpD9onK220J6
	OKXBHdUrP0c7rCBDD1pKSDBQKaKg7UEB/bP0VZNhsXM4jvePJWxw1fuZe+fqXmo7Q+nGnOTKq9J
	czClBNUxYcCKxQY0bBePYFVIl5rv63xoxcO4ezZKrNlz+QIC/XSDq+ZAONOCmHrg+x5PnT4H84T
	aAWzpBlFPU8S6/uBZhT9CZeIDdiVKQddKvIORviAw7K2OVG3RH0Z66IkCgFBVvOzuBLw7LXZAXk
	lmEQWJrqIxZx4eNPVD6NYASx1WelplzJcghsxHBZkKqPX70mNV11dgIz51CcERKdArr344AYOrp
	ytngz9+mQNcZiHh/uQpZ7rw==
X-Received: by 2002:a05:6000:161d:b0:48e:641b:477a with SMTP id ffacd0b85a97d-48e641b47bamr5341390f8f.52.1793286872058;
        Thu, 29 Oct 2026 08:14:32 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb851sm30191373f8f.26.2026.10.29.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:14:31 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: superm1@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS ROG Strix G513QY
Date: Thu, 29 Oct 2026 15:14:22 +0000
Message-ID: <20261029151422.56791-3-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029151422.56791-1-mike@fireburn.co.uk>
References: <20261029151422.56791-1-mike@fireburn.co.uk>
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

The AMD CPM D3cold table on the G513QY (BIOS 335) handles the dGPU
hotplug GPE with:

  Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }

On this board the Navi 22 sits behind its on-package PCIe switch, so
the dGPU node is \_SB.PCI0.GPP0.SWUS.SWDS.VGA_ and every hotplug on the
USB-C DP alt mode port while the dGPU is in D3cold logs:

  ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP0.VGA], AE_NOT_FOUND
  ACPI Error: Aborting method \_GPE._L05 due to previous error (AE_NOT_FOUND)
  ACPI Error: AE_NOT_FOUND, while evaluating GPE method [_L05]

The notify is lost, the dGPU stays powered off and the external
displays stay dark. Masking the GPE (acpi_mask_gpe=0x05), the usual
workaround, removes the errors but also the hotplug.

On boards listed in a DMI table, and only when the notify target does
not resolve, install a handler for the GPE in place of the _Lxx method.
It requests a runtime resume of the dGPU, which re-detects all links and
sends a hotplug event, and re-arms the level-triggered GPE from a
delayed work so it cannot storm while the dGPU powers up. If the
firmware is fixed, or the path is supplied by an SSDT override, the
firmware method is left in charge.

Other boards using the same CPM table may need adding to the list.

Link: https://forum.endeavouros.com/t/boots-into-black-screen-unresponsive-amd/49430
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 103 ++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index deb63122828d..d8a7fea8be9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -642,6 +642,9 @@ struct amdgpu_device {
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
 	bool				acpi_dgpu_notify;
+	bool				acpi_hpd_gpe_installed;
+	u32				acpi_hpd_gpe;
+	struct delayed_work		acpi_hpd_gpe_work;
 	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper debugfs_vbios_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index a4041f90b374..182791f4cc86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/backlight.h>
+#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <linux/power_supply.h>
@@ -1297,6 +1298,103 @@ static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, void *data)
 	pm_request_resume(adev->dev);
 }
 
+/*
+ * Some AMD CPM D3cold tables handle the dGPU hotplug GPE with
+ * Notify(\_SB.PCI0.GPP0.VGA, 0x81), but on boards where the dGPU sits behind
+ * an on-package PCIe switch the node is \_SB.PCI0.GPP0.SWUS.SWDS.VGA_, so the
+ * _Lxx method aborts with AE_NOT_FOUND and the dGPU is never woken. On those
+ * boards take over the GPE and do what the notify would have done.
+ */
+struct amdgpu_acpi_hpd_gpe_quirk {
+	const char *notify_path;
+	u32 gpe;
+};
+
+static const struct amdgpu_acpi_hpd_gpe_quirk g513qy_hpd_gpe = {
+	.notify_path = "\\_SB.PCI0.GPP0.VGA",
+	.gpe = 0x05,
+};
+
+static const struct dmi_system_id amdgpu_acpi_hpd_gpe_quirks[] = {
+	{
+		.ident = "ASUS ROG Strix G513QY",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "G513QY"),
+		},
+		.driver_data = (void *)&g513qy_hpd_gpe,
+	},
+	{}
+};
+
+/* GPE handlers run in interrupt context; the GPE stays disabled until the work re-arms it */
+static u32 amdgpu_acpi_hpd_gpe_handler(acpi_handle gpe_device, u32 gpe, void *data)
+{
+	struct amdgpu_device *adev = data;
+
+	pm_request_resume(adev->dev);
+	schedule_delayed_work(&adev->acpi_hpd_gpe_work, msecs_to_jiffies(500));
+
+	return 0;
+}
+
+/*
+ * Re-arm after a delay: the GPE is level triggered and may stay asserted
+ * while the dGPU powers up, so this bounds the rate at which it refires.
+ */
+static void amdgpu_acpi_hpd_gpe_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, acpi_hpd_gpe_work.work);
+
+	acpi_finish_gpe(NULL, adev->acpi_hpd_gpe);
+}
+
+static void amdgpu_acpi_hpd_gpe_init(struct amdgpu_device *adev)
+{
+	const struct amdgpu_acpi_hpd_gpe_quirk *quirk;
+	const struct dmi_system_id *id;
+	acpi_handle handle;
+
+	id = dmi_first_match(amdgpu_acpi_hpd_gpe_quirks);
+	if (!id)
+		return;
+	quirk = id->driver_data;
+
+	/* Firmware (or a table override) already provides the notify target */
+	if (ACPI_SUCCESS(acpi_get_handle(NULL, quirk->notify_path, &handle)))
+		return;
+
+	adev->acpi_hpd_gpe = quirk->gpe;
+	INIT_DELAYED_WORK(&adev->acpi_hpd_gpe_work, amdgpu_acpi_hpd_gpe_work);
+	if (ACPI_FAILURE(acpi_install_gpe_handler(NULL, quirk->gpe,
+						  ACPI_GPE_LEVEL_TRIGGERED,
+						  amdgpu_acpi_hpd_gpe_handler,
+						  adev)))
+		return;
+	if (ACPI_FAILURE(acpi_enable_gpe(NULL, quirk->gpe))) {
+		acpi_remove_gpe_handler(NULL, quirk->gpe,
+					amdgpu_acpi_hpd_gpe_handler);
+		return;
+	}
+
+	adev->acpi_hpd_gpe_installed = true;
+	dev_info(adev->dev, "handling dGPU hotplug GPE 0x%02x (%s missing)\n",
+		 quirk->gpe, quirk->notify_path);
+}
+
+static void amdgpu_acpi_hpd_gpe_fini(struct amdgpu_device *adev)
+{
+	if (!adev->acpi_hpd_gpe_installed)
+		return;
+
+	acpi_disable_gpe(NULL, adev->acpi_hpd_gpe);
+	cancel_delayed_work_sync(&adev->acpi_hpd_gpe_work);
+	acpi_remove_gpe_handler(NULL, adev->acpi_hpd_gpe,
+				amdgpu_acpi_hpd_gpe_handler);
+	adev->acpi_hpd_gpe_installed = false;
+}
+
 /* Call all ACPI methods here */
 /**
  * amdgpu_acpi_init - init driver acpi support
@@ -1343,12 +1441,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	register_acpi_notifier(&adev->acpi_nb);
 
 	if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
-	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		adev->acpi_dgpu_notify =
 			!acpi_dev_install_notify_handler(ACPI_COMPANION(adev->dev),
 							 ACPI_DEVICE_NOTIFY,
 							 amdgpu_acpi_dgpu_notify,
 							 adev);
+		amdgpu_acpi_hpd_gpe_init(adev);
+	}
 
 	return 0;
 }
@@ -1369,6 +1469,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
  */
 void amdgpu_acpi_fini(struct amdgpu_device *adev)
 {
+	amdgpu_acpi_hpd_gpe_fini(adev);
 	if (adev->acpi_dgpu_notify) {
 		acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
 					       ACPI_DEVICE_NOTIFY,
-- 
2.56.0

