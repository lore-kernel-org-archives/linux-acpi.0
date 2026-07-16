Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA138B7BA;
	Thu, 16 Jul 2026 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245553; cv=none; b=IeCYk8kPGH+JmxDGRrngTn2xqPfbCd7ZTDbyMSdrT+LT70HCLsgIXGafMy0wXCJcav4Uk1gH5czzAZ10ZIAsANE3BWm3IZxZVOrXX3z9eQ74UepFlbccpaGp4xRsqz7SnGo8vCWBZtCO6w5PCqB6c0ndkn3+XwnRMT0wc7+uDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245553; c=relaxed/simple;
	bh=9ARj2YL3cF4ir7+lwIqav+BgEVJ1H0cMbZGfa1x0Rho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZpLuYtkGCp+iLngRpAb9vw5fhVkH4HjgAvRjLSZd1m0lypkn36vJkprrXQdI6ved7nnFUC42VK3ZY/TopOwWuAxMewAq0KDS9Xhj0B0oZ/VvKiVeIpH9RA1mcME4bcM2gZcMz6aXtuQ3J9drCGOV/Drpf4UuwvMAOYo8OkIB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=F52YjpFt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="F52YjpFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784245549; x=1784850349; i=w_armin@gmx.de;
	bh=1TfPn0AszdYUxY9KOnw4tBBBYnAuAdefwlggqyy5+TY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F52YjpFtOlrwvd+fZ+7Hljb2L55kssMm4URYkRDHyoNbPwFAJ2Q62rBoIKw4WtMD
	 hpMaeTQL7cIdaiXXxDDNnkVITPuUafz447YHu5z6ZO73c3mLFETrmJWTQGP7B2hIw
	 vulNH7KX/o5OwKXtkwiPEchVGx3Hhd/LPaOlwJYATdPlUeEILRPaUK+EGBc8/unuv
	 ILFRtGd+/D6LVH6jLHxuDqaSrSVCCqhlZGx/nElyUc1pyJLlsyE05+gU0EUUgWrCc
	 2gkhoZZrB94HtRXkLQ0W/QHzK/S/EjV3XGnXEQJo8PkVDtAuqSmaV4zUxSDhGqBVq
	 WCzNc+nryNPVDT9hSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1xBUsB1eYE-015t2S; Fri, 17
 Jul 2026 01:45:49 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
Date: Fri, 17 Jul 2026 01:45:37 +0200
Message-Id: <20260716234538.1303811-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260716234538.1303811-1-W_Armin@gmx.de>
References: <20260716234538.1303811-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pcbwh4JUb3ABwWQFWpAevYexj0YqCvKXlFIN8EO/1G33vsF3TMj
 kHXUbDnRXPbRvhpENJM6wHl3R1CGW9Pvj8uMOzivLyHuaGEfY85+naVGmSRpwQTWQl5AVBr
 +CphPLYygFnygPTGkOVzYoDTpC2QCIVqbuiOu8NS0zo621FXmjWvqZTTP6Y9fS1Ep+H/n+a
 SEpDtpI875IyWGyOMmiOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Z8DQ05PkGQ=;lGC/RyE+mhq28oqyEuKzFBoBq1f
 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

The WMI-ACPI driver now supports architectures other than x86.
Remove the CONFIG_X86 handling from video-detect and the associated
GPU drivers to simplify the resulting code.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/Kconfig               | 2 +-
 drivers/acpi/video_detect.c        | 8 --------
 drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
 drivers/gpu/drm/gma500/Kconfig     | 1 -
 drivers/gpu/drm/i915/Kconfig       | 1 -
 drivers/gpu/drm/radeon/Kconfig     | 4 +---
 drivers/gpu/drm/xe/Kconfig         | 5 ++---
 7 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..cc1e58fa664b 100644
=2D-- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -224,7 +224,7 @@ config ACPI_VIDEO
 	tristate "Video"
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
-	depends on ACPI_WMI || !X86
+	depends on ACPI_WMI
 	select THERMAL
 	help
 	  This driver implements the ACPI Extensions For Display Adapters
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 458efa4fe9d4..af9280b244f1 100644
=2D-- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context, v=
oid **rv)
 	return AE_OK;
 }
=20
-/* This depends on ACPI_WMI which is X86 only */
-#ifdef CONFIG_X86
 static bool nvidia_wmi_ec_supported(void)
 {
 	struct wmi_brightness_args args =3D {
@@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
 	 */
 	return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;
 }
-#else
-static bool nvidia_wmi_ec_supported(void)
-{
-	return false;
-}
-#endif
=20
 /* Force to use vendor driver when the ACPI device is known to be
  * buggy */
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdg=
pu/Kconfig
index 12e4a41bf1f0..50305630f533 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -30,9 +30,7 @@ config DRM_AMDGPU
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
+	select ACPI_WMI if ACPI
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
=20
diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconf=
ig
index a2acaa699dd5..dc4c56638819 100644
=2D-- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -11,7 +11,6 @@ config DRM_GMA500
 	select ACPI_VIDEO if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 5e939004b646..71426b9c91f0 100644
=2D-- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -28,7 +28,6 @@ config DRM_I915
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
 	select ACPI_VIDEO if ACPI
 	select SYNC_FILE
diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconf=
ig
index c479f0c0dd5c..3cd70aef770e 100644
=2D-- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -25,9 +25,7 @@ config DRM_RADEON
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
+	select ACPI_WMI if ACPI
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b91..502c7b3c1f16 100644
=2D-- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -4,7 +4,6 @@ config DRM_XE
 	depends on DRM && PCI
 	depends on KUNIT || !KUNIT
 	depends on INTEL_VSEC || !INTEL_VSEC
-	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
 	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
@@ -29,8 +28,8 @@ config DRM_XE
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
-	select ACPI_VIDEO if X86 && ACPI
-	select ACPI_WMI if X86 && ACPI
+	select ACPI_VIDEO if ACPI
+	select ACPI_WMI if ACPI
 	select SYNC_FILE
 	select CRC32
 	select SND_HDA_I915 if SND_HDA_CORE
=2D-=20
2.39.5

