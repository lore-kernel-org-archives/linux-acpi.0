Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7D2FE056;
	Fri, 24 Jul 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859976; cv=none; b=asecRxvQpAfYl4dL437URXaGosmtpXlXHxprXDqVheoWyQ/Qa1J65JEIFDQ93qHm1x9HPynaLJi27lkBCrLq/AqBXuNZaR9G7FSyBvhHBKzdcfn29f3rYy3QoIeStWF3NRomKfvEKiuk+0Pjy6bTQmoqp0/Bpd937h6Dn0fW/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859976; c=relaxed/simple;
	bh=+Toxa3phjWeGFMdWum+PH8TzS0C0VNb31S7j6NkI/Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZ6BPruE5B1FtBnxSNQw6RlswWP9NQsr02MzGBQNfRQP9ymEKHKYRBeqGIPv3owUwm+dBo4z3hZRcjGIm7qEsdRjnCd+5tlyrcJob4yzv2iyn18tsBEVqYH++9uRfyYEAAVj+L2bj4pTj2zGJsIRRr3sG/rsDELkZFi+YF4+REs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=S2pL1rVY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="S2pL1rVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784859954; x=1785464754; i=w_armin@gmx.de;
	bh=5VxiPprzspzEFP140Z6/uv8kfqLBbbbv/Zr5wSXUh0s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S2pL1rVYgGx9jIY4pgi/ilDNduW8ZpIvJPb0otVX8mjCguayOkpkYMva6J4gndOw
	 nMt1IHjQIIJ/dj56csLE3jqmVx82rU27btDtoXgLRw+LpXeBkSfP66Ws/1q87Mo4M
	 scRPjiUnidt2FLDxUgUPTMF1OSbR2eri3GeuqfrUtALnlOxWlPOPlycngaAV3P0Dx
	 lQjpVZEOXrQYrfMP+67DaC7/n3ATZclE3/7Cmu5dOB3NAb+KoLjClg0xHUCUpdo+p
	 hLp9tRE7v67hQSY/wscn5tlE17S/ZQXaz5t+BYjMIKhRMJ6mSS9i5Xf6Ku98M2jPq
	 7jQ2ewU2CbKkzk6dGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1wO1hf20pR-00VBRN; Fri, 24
 Jul 2026 04:25:54 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2 2/3] ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
Date: Fri, 24 Jul 2026 04:25:25 +0200
Message-Id: <20260724022526.139370-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724022526.139370-1-W_Armin@gmx.de>
References: <20260724022526.139370-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6dj0A5FGhDOBqzpKuOL4VSh1nP2e5ndoZ/6jqS3pldrLEmbmIYM
 NKg+r2/Ga5q+ik0V/EAjWe52CJ4MWCh+aJrT9DatrOrfz9pN6z8SoNWfVDg8EinA+Rzn/r+
 GZanIjjigG6rcCl2N3qFASw2BDoHglsGTF0HvwB4tqOYudlCpModZfXpHsAvkuaAc61PU1j
 4QWgjAIfnBTggKFmSYKow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1ucYNyPHVpA=;a28gk8sm+ehnVHB/T2uiSnVwedz
 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

The WMI-ACPI driver now supports architectures other than x86.
Remove the CONFIG_X86 handling from video-detect and the associated
GPU drivers to simplify the resulting code.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
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

