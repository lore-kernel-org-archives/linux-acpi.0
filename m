Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220346AA68;
	Tue, 21 Jul 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648163; cv=none; b=SqQKZifEE7i5FiSOdsCsvLN+OYk3KFx8xoNf6SxI6gbQ8DSdmtLBBnNPTys5WDt3sJgyg1k1+bYsm3s1saluZ0TQSNsKSAJL6bFKa2wVpPHQc/6o2jy/aHQde0Lnpiva5tbK8sgfrU9Zr/USJIkUW20iU8Z4zQsIRgC2nCuofAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648163; c=relaxed/simple;
	bh=LSOJidYWyJkfwzustefDfNuU8d4r8/kxHffPI6oNHtM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kOrjC4HULyf6OOCc3knsSZjyUcOPgsErZbDSkUGn9ps426hflkbGyI+SrWfxJWdoqynV3hrZp25vEv/oyUp2gbccVfOCclx5Cqcb+8D31dGcQyqSLPg8t9Yn9hhOBUf1vuFMGO3/ovpKRVOTcenhSIVYxLbWq7hOQRQRO/OI7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aK4C3LbB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aK4C3LbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784648162; x=1816184162;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LSOJidYWyJkfwzustefDfNuU8d4r8/kxHffPI6oNHtM=;
  b=aK4C3LbBE1Uas/FAoaKnBX+BeNDSy4XNeknEqzUxzAaUf41VQLu8FTxF
   gohT2Kh9tsMbDQnyFPQZX7ids2pP59OeWNhXO84vYDQNya0TwO1FMgKnc
   p73NrtYCwwVUvwKlottcn1hWzUVM3TpriwRNmD0uTig8v3ShH9JAns0hp
   Hs4De1f2PKDkokpiQvuNrGS4mDjYGB5fIwCGd2nrXUQ6nJkBAoYTo9++N
   JjKV7D/oSlaXT947hEsDeyMNB02xBZtWKOPYzlmi3lkc8WAx/cyx9rDXx
   vh2majO52I45sotRlmljnATbtVv5ZChO8bXyvFg2vL/ZLNNA4e+hYzX2k
   A==;
X-CSE-ConnectionGUID: i6GmSVF4Rk2+3rhj5NuoWg==
X-CSE-MsgGUID: Up+fKjRZT7eWLK4XQ8PSgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95616500"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95616500"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:36:01 -0700
X-CSE-ConnectionGUID: 6251/zbFSjC0ACQL9qlmpA==
X-CSE-MsgGUID: jr2Bkl1oQ1WvuRUIeSx+pA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:35:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 18:35:55 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@weissschuh.net, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/3] platform/x86: wmi-bmof: Move to generic WMI code
In-Reply-To: <20260716234538.1303811-4-W_Armin@gmx.de>
Message-ID: <7a059319-e1a9-e2c6-c750-7ee0c3ab3861@linux.intel.com>
References: <20260716234538.1303811-1-W_Armin@gmx.de> <20260716234538.1303811-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1463547634-1784648155=:1265"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1463547634-1784648155=:1265
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Jul 2026, Armin Wolf wrote:

> Some Windows-on-Arm notebooks contain embedded Binary MOF data,
> accessible using the WMI-ACPI interface. Move the associated driver
> to the generic WMI code to make it possible to build it on arm64.
> Also rework the Kconfig help text a bit.
>=20
> Link: https://lists.linaro.org/archives/list/aarch64-laptops@lists.linaro=
=2Eorg/thread/U2IZENSIOOHZHGXVN7GM5HX5O3FD5KCF/
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  MAINTAINERS                                     |  2 +-
>  drivers/platform/wmi/Kconfig                    | 12 ++++++++++++
>  drivers/platform/wmi/Makefile                   |  4 ++++
>  drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} |  0
>  drivers/platform/x86/Kconfig                    | 12 ------------
>  drivers/platform/x86/Makefile                   |  3 ---
>  6 files changed, 17 insertions(+), 16 deletions(-)
>  rename drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3820b286f09f..bbae729a6012 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29106,7 +29106,7 @@ L:=09platform-driver-x86@vger.kernel.org
>  S:=09Maintained
>  F:=09Documentation/ABI/stable/sysfs-platform-wmi-bmof
>  F:=09Documentation/wmi/devices/wmi-bmof.rst
> -F:=09drivers/platform/x86/wmi-bmof.c
> +F:=09drivers/platform/wmi/bmof.c
> =20
>  WOLFSON MICROELECTRONICS DRIVERS
>  L:=09patches@opensource.cirrus.com
> diff --git a/drivers/platform/wmi/Kconfig b/drivers/platform/wmi/Kconfig
> index 36934b5f0194..11c221a58e04 100644
> --- a/drivers/platform/wmi/Kconfig
> +++ b/drivers/platform/wmi/Kconfig
> @@ -34,4 +34,16 @@ config ACPI_WMI_LEGACY_DEVICE_NAMES
> =20
>  source "drivers/platform/wmi/tests/Kconfig"
> =20
> +config WMI_BMOF
> +=09tristate "WMI embedded Binary MOF driver"
> +=09default ACPI_WMI
> +=09help
> +=09  Say Y here if you want to be able to read the firmware-embedded
> +=09  WMI Binary MOF (Managed Object Format) data. Using this requires
> +=09  userspace tools, see Documentation/wmi/devices/wmi-bmof.rst for
> +=09  details.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called wmi-bmof.
> +
>  endif # ACPI_WMI
> diff --git a/drivers/platform/wmi/Makefile b/drivers/platform/wmi/Makefil=
e
> index 2feff94a5594..ee2f27ea20d1 100644
> --- a/drivers/platform/wmi/Makefile
> +++ b/drivers/platform/wmi/Makefile
> @@ -9,3 +9,7 @@ obj-$(CONFIG_ACPI_WMI)=09+=3D wmi.o
> =20
>  # Unit tests
>  obj-y=09=09=09+=3D tests/
> +
> +# Binary MOF driver
> +wmi-bmof-y=09=09:=3D bmof.o
> +obj-$(CONFIG_WMI_BMOF)=09+=3D wmi-bmof.o
> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/wmi/bmof.=
c
> similarity index 100%
> rename from drivers/platform/x86/wmi-bmof.c
> rename to drivers/platform/wmi/bmof.c
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 957034f39e4e..889979034391 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -16,18 +16,6 @@ menuconfig X86_PLATFORM_DEVICES
> =20
>  if X86_PLATFORM_DEVICES
> =20
> -config WMI_BMOF
> -=09tristate "WMI embedded Binary MOF driver"
> -=09depends on ACPI_WMI
> -=09default ACPI_WMI
> -=09help
> -=09  Say Y here if you want to be able to read a firmware-embedded
> -=09  WMI Binary MOF (Managed Object Format) data. Using this requires
> -=09  userspace tools and may be rather tedious.
> -
> -=09  To compile this driver as a module, choose M here: the module will
> -=09  be called wmi-bmof.
> -
>  config HUAWEI_WMI
>  =09tristate "Huawei WMI laptop extras driver"
>  =09depends on ACPI_BATTERY
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 872ac3842391..94a5fe4075cb 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -4,9 +4,6 @@
>  # x86 Platform-Specific Drivers
>  #
> =20
> -# Windows Management Interface
> -obj-$(CONFIG_WMI_BMOF)=09=09+=3D wmi-bmof.o
> -
>  # WMI drivers
>  obj-$(CONFIG_HUAWEI_WMI)=09=09+=3D huawei-wmi.o
>  obj-$(CONFIG_MXM_WMI)=09=09=09+=3D mxm-wmi.o
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1463547634-1784648155=:1265--
