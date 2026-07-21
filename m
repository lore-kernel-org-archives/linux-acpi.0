Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DF46AA91;
	Tue, 21 Jul 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648018; cv=none; b=f4mj7Tq9OqsjmZhBRWUEHCwD05A4MuCpiV0LYZ+/U7NPtD9zWVc034/1KC6rfD1EkPWpHD0HX7yV3CXpjFcGc4mfR8x7ytlwlOHaBpLtaB2T9BiXd0ULDQN3pTqUsnvzyxCARrY6wURMsNbb/T5I5bhQyrZlmfcHTwfh9Nq500s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648018; c=relaxed/simple;
	bh=bYEicWFRLIPBmMNMPmRc/odkocG3XuMg47eGW3BPdn8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ac09g17XJ+WzHoIXXqDqltCRE8HWcHGltwuFPt9cBgL/2GfFDzbwEH4rtbmjqnMF7r9t/yHsPflF0+/UsAjsBSpd9CabAkC5TadQ7DnN/TpXFjzyBxKx9X3C35CnVHeJMVCkmfJUxup4Us17mOLHMjl2B6YzxdTPzw/rcPH7XbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oK6t//YT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oK6t//YT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784648016; x=1816184016;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bYEicWFRLIPBmMNMPmRc/odkocG3XuMg47eGW3BPdn8=;
  b=oK6t//YTkgJItLAfoXb3RKExxAvh38Mw6GvAM7hINOUXIjKjDSvH7Xe4
   3lJcW719kN0LoPfvexwk8wPrzOgqHzn1S8ZumafRUjZgz0BGCw4BkP86/
   I/Ugbtxv3EPuPf6OgaSyvbrMLQ852sW4dlEZONvTiC1/Uy7ghxPXMCkT2
   C1nbbEGLuZaRfsIEwxkJgzDDx9De8xAp8YhCRJ1ZY6agJlgYsa/VJrv7L
   /akfXq9ngDHnuc2+jv4HESLrsdyykRhN8d+MdqKBK0opjMWsLngV76FTX
   uTWOIdTKgLi++iroJD1OnxqBVM7q/5JaI+Xxqf99+yOcsolTBMxSoEV4F
   A==;
X-CSE-ConnectionGUID: lvVga/Y9S7ygGe8FLJ3LGQ==
X-CSE-MsgGUID: Gc7FaZCcSJWcrnsBUpsJ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95848669"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95848669"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:33:35 -0700
X-CSE-ConnectionGUID: /QOaU5UKT5CfW1pKDjagbQ==
X-CSE-MsgGUID: hv5YqUsES8yp2wwH1YAjqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256001819"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:33:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 18:33:28 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@weissschuh.net, lenb@kernel.org, 
    linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
In-Reply-To: <a45e7c7a-c0cd-4f6e-b48a-15beca4e022a@gmx.de>
Message-ID: <b347c2a4-229c-3c9d-435d-569fdb16c9e5@linux.intel.com>
References: <20260716234538.1303811-1-W_Armin@gmx.de> <20260716234538.1303811-3-W_Armin@gmx.de> <CAJZ5v0hUoTRS4fce0=Qn8J=Yf5WtHfbzUw+kyxhhPaRtB2o35A@mail.gmail.com> <a45e7c7a-c0cd-4f6e-b48a-15beca4e022a@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2134702264-1784648008=:1265"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2134702264-1784648008=:1265
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Jul 2026, Armin Wolf wrote:

> Am 17.07.26 um 11:14 schrieb Rafael J. Wysocki (Intel):
>=20
> > On Fri, Jul 17, 2026 at 1:45=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
> > > The WMI-ACPI driver now supports architectures other than x86.
> > > Remove the CONFIG_X86 handling from video-detect and the associated
> > > GPU drivers to simplify the resulting code.
> > >=20
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >=20
> > Or please let me know if you want me to pick up this one.
> >=20
> > Thanks!
>=20
> Hi,
>=20
> i would prefer if this is being picked up by the platform drivers tree, u=
nless
> Ilpo says otherwise.

Hi.

I'm fine with taking this, but not before gpu/ people acks and you seem to=
=20
not have them among receipients??

Proposed course of action: Collect tags and send v2 with a bit more=20
receipients?

--
 i.

> > > ---
> > >   drivers/acpi/Kconfig               | 2 +-
> > >   drivers/acpi/video_detect.c        | 8 --------
> > >   drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
> > >   drivers/gpu/drm/gma500/Kconfig     | 1 -
> > >   drivers/gpu/drm/i915/Kconfig       | 1 -
> > >   drivers/gpu/drm/radeon/Kconfig     | 4 +---
> > >   drivers/gpu/drm/xe/Kconfig         | 5 ++---
> > >   7 files changed, 5 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > index f165d14cf61a..cc1e58fa664b 100644
> > > --- a/drivers/acpi/Kconfig
> > > +++ b/drivers/acpi/Kconfig
> > > @@ -224,7 +224,7 @@ config ACPI_VIDEO
> > >          tristate "Video"
> > >          depends on BACKLIGHT_CLASS_DEVICE
> > >          depends on INPUT
> > > -       depends on ACPI_WMI || !X86
> > > +       depends on ACPI_WMI
> > >          select THERMAL
> > >          help
> > >            This driver implements the ACPI Extensions For Display Ada=
pters
> > > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.=
c
> > > index 458efa4fe9d4..af9280b244f1 100644
> > > --- a/drivers/acpi/video_detect.c
> > > +++ b/drivers/acpi/video_detect.c
> > > @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *conte=
xt,
> > > void **rv)
> > >          return AE_OK;
> > >   }
> > >=20
> > > -/* This depends on ACPI_WMI which is X86 only */
> > > -#ifdef CONFIG_X86
> > >   static bool nvidia_wmi_ec_supported(void)
> > >   {
> > >          struct wmi_brightness_args args =3D {
> > > @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
> > >           */
> > >          return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;
> > >   }
> > > -#else
> > > -static bool nvidia_wmi_ec_supported(void)
> > > -{
> > > -       return false;
> > > -}
> > > -#endif
> > >=20
> > >   /* Force to use vendor driver when the ACPI device is known to be
> > >    * buggy */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > index 12e4a41bf1f0..50305630f533 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > @@ -30,9 +30,7 @@ config DRM_AMDGPU
> > >          # ACPI_VIDEO's dependencies must also be selected.
> > >          select INPUT if ACPI
> > >          select ACPI_VIDEO if ACPI
> > > -       # On x86 ACPI_VIDEO also needs ACPI_WMI
> > > -       select X86_PLATFORM_DEVICES if ACPI && X86
> > > -       select ACPI_WMI if ACPI && X86
> > > +       select ACPI_WMI if ACPI
> > >          help
> > >            Choose this option if you have a recent AMD Radeon graphic=
s
> > > card.
> > >=20
> > > diff --git a/drivers/gpu/drm/gma500/Kconfig
> > > b/drivers/gpu/drm/gma500/Kconfig
> > > index a2acaa699dd5..dc4c56638819 100644
> > > --- a/drivers/gpu/drm/gma500/Kconfig
> > > +++ b/drivers/gpu/drm/gma500/Kconfig
> > > @@ -11,7 +11,6 @@ config DRM_GMA500
> > >          select ACPI_VIDEO if ACPI
> > >          select BACKLIGHT_CLASS_DEVICE if ACPI
> > >          select INPUT if ACPI
> > > -       select X86_PLATFORM_DEVICES if ACPI
> > >          select ACPI_WMI if ACPI
> > >          help
> > >            Say yes for an experimental 2D KMS framebuffer driver for =
the
> > > diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kcon=
fig
> > > index 5e939004b646..71426b9c91f0 100644
> > > --- a/drivers/gpu/drm/i915/Kconfig
> > > +++ b/drivers/gpu/drm/i915/Kconfig
> > > @@ -28,7 +28,6 @@ config DRM_I915
> > >          # but for select to work, need to select ACPI_VIDEO's
> > > dependencies, ick
> > >          select BACKLIGHT_CLASS_DEVICE if ACPI
> > >          select INPUT if ACPI
> > > -       select X86_PLATFORM_DEVICES if ACPI
> > >          select ACPI_WMI if ACPI
> > >          select ACPI_VIDEO if ACPI
> > >          select SYNC_FILE
> > > diff --git a/drivers/gpu/drm/radeon/Kconfig
> > > b/drivers/gpu/drm/radeon/Kconfig
> > > index c479f0c0dd5c..3cd70aef770e 100644
> > > --- a/drivers/gpu/drm/radeon/Kconfig
> > > +++ b/drivers/gpu/drm/radeon/Kconfig
> > > @@ -25,9 +25,7 @@ config DRM_RADEON
> > >          # ACPI_VIDEO's dependencies must also be selected.
> > >          select INPUT if ACPI
> > >          select ACPI_VIDEO if ACPI
> > > -       # On x86 ACPI_VIDEO also needs ACPI_WMI
> > > -       select X86_PLATFORM_DEVICES if ACPI && X86
> > > -       select ACPI_WMI if ACPI && X86
> > > +       select ACPI_WMI if ACPI
> > >          help
> > >            Choose this option if you have an ATI Radeon graphics card=
=2E
> > > There
> > >            are both PCI and AGP versions.  You don't need to choose t=
his
> > > to
> > > diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> > > index 4d7dcaff2b91..502c7b3c1f16 100644
> > > --- a/drivers/gpu/drm/xe/Kconfig
> > > +++ b/drivers/gpu/drm/xe/Kconfig
> > > @@ -4,7 +4,6 @@ config DRM_XE
> > >          depends on DRM && PCI
> > >          depends on KUNIT || !KUNIT
> > >          depends on INTEL_VSEC || !INTEL_VSEC
> > > -       depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
> > >          depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
> > >          select INTERVAL_TREE
> > >          # we need shmfs for the swappable backing store, and in
> > > particular
> > > @@ -29,8 +28,8 @@ config DRM_XE
> > >          # but for select to work, need to select ACPI_VIDEO's
> > > dependencies, ick
> > >          select BACKLIGHT_CLASS_DEVICE if ACPI
> > >          select INPUT if ACPI
> > > -       select ACPI_VIDEO if X86 && ACPI
> > > -       select ACPI_WMI if X86 && ACPI
> > > +       select ACPI_VIDEO if ACPI
> > > +       select ACPI_WMI if ACPI
> > >          select SYNC_FILE
> > >          select CRC32
> > >          select SND_HDA_I915 if SND_HDA_CORE
> > > --
> > > 2.39.5
> > >=20
> > >=20
>=20
--8323328-2134702264-1784648008=:1265--
