Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313724BF950;
	Fri, 18 Sep 2026 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728193; cv=none; b=Fs3MM2PNW96jBJ5IkpwGFDcfEyS2If08BGEB+/qwD3SyG+d+C46qH+EWemRs9Ikky7Pmw/Rs50Wctdiv38x4DS7zv/LEEuxdt0ZCnRVRaIIu0y0KF8de/ZRLJ9K15pdqCADDqOQpUT//0nVoX5KbSIdU1DJ7ewjKu3NVLWyzygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728193; c=relaxed/simple;
	bh=BpzpvWMW+Kltm7l2DwODGS/qgmlr/2OVqYMl3RGVofE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d1/jKWZsebRl8N8dCnWtv6KhAw5RYlJ/vEHGWDDmQgBmnYPLIzWuut/ON7+G1SYtdRbN7N93Az2hsWLFz/S2RTyFXxh/lAubmf8029LfiA8uxQLdqG+i+o9iPMuXT7fPMdErC0k9D7b7amfZYSUVXrmeCdccy1pIWMaJp7kopOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXQyhZlA; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXQyhZlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789728189; x=1821264189;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=BpzpvWMW+Kltm7l2DwODGS/qgmlr/2OVqYMl3RGVofE=;
  b=eXQyhZlAEoi08zj0HjIA9o06vP6qKfDlynn4ivAD6Y1KOSyEeobX1na7
   I24Mcxo8VYE11eHWDEDRZiFCtumsS4EWSPw5v1feU45+VzAdeP+Gx/gR4
   DDPzv98MA3y015K/Ss9grGI3/K+cpwOQ3gQL35mHcZfjJ4cWOU+ZJqMkj
   ipofU5yio33Vj8jkqdKcQ1/V5h5UO0c3JfCVSygZjM8YZVYJ0g6qTd+4E
   OiM5TQx4w9RiAXOE7qYN/f6f0isWR+9FMTs7n2eTYuLNIldJzwTDTuKtH
   AkaTnumjuOB/Fc98pYmJVsE54/++TtomhyaoPcLzx6RKZRrSIvmmMumfy
   Q==;
X-CSE-ConnectionGUID: DONVChe/T+CP++Qyodhy6Q==
X-CSE-MsgGUID: c1spzVxuS/2qAQDAJ4RSJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="740710"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="740710"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 03:43:06 -0700
X-CSE-ConnectionGUID: 7a2p/7Y0SNqX+d3aCxCuNg==
X-CSE-MsgGUID: 6+NdPYf/Rkm0/R2EYyVUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297813291"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 03:43:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux@weissschuh.net"
 <linux@weissschuh.net>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "patrik.r.jakobsson@gmail.com"
 <patrik.r.jakobsson@gmail.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
In-Reply-To: <06550473-63c2-4a3e-a5ad-7e23d7b6b050@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
 <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com>
 <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
 <62d7da838e7042df8456e76190db792093065b57@intel.com>
 <06550473-63c2-4a3e-a5ad-7e23d7b6b050@kernel.org>
Date: Fri, 18 Sep 2026 13:42:57 +0300
Message-ID: <d696d85c44930d2124054ce11a06d3096c0db04a@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2026, Hans de Goede <hansg@kernel.org> wrote:
> Hi,
>
> On 16-Sep-26 09:16, Jani Nikula wrote:
>> On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
>>> Am 15.09.26 um 14:31 schrieb Jani Nikula:
>>>
>>>> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com=
> wrote:
>>>>> GPU people heads up!!
>>>>>
>>>>> On Wed, 2 Sep 2026, Armin Wolf wrote:
>>>>>
>>>>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> index 12e4a41bf1f0..50305630f533 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>>>>>>>         # ACPI_VIDEO's dependencies must also be selected.
>>>>>>>>         select INPUT if ACPI
>>>>>>>>         select ACPI_VIDEO if ACPI
>>>>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>>>>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>>>>>>> The change below makes sense, but this one looks like it should rem=
ain
>>>>>>> unless X86_PLATFORM_DEVICES is handled some other way?
>>>>>>>
>>>>>>> Alex
>>>>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary beca=
use
>>>>>> ACPI-WMI depended on it in the past.
>>>>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymo=
re.
>>>>> Hi all,
>>>>>
>>>>> Could more GPU people besides Alex take a look on this. I'd want to m=
ake
>>>>> progress with this series within this cycle but would prefer to have =
Acks
>>>>> from GPU side.
>>>> I share the same concern with Alex. It seems to me we could now end up
>>>> with x86 configurations without X86_PLATFORM_DEVICES, which handle
>>>> e.g. backlight on a lot of platforms.
>>>>
>>>> I think the safer option might be to go for:
>>>>
>>>> 	depends on X86_PLATFORM_DEVICES || !X86
>>>>
>>>> in all of the cases that select/depend on X86_PLATFORM_DEVICES in drm.
>>>>
>>>> The alternative is to find out, and handle the fallout, if any.
>>>>
>>>>
>>>> BR,
>>>> Jani.
>>>
>>> Alright, should i leave the original "select X86_PLATFORM_DEVICES if ..=
." statements
>>> as-is or should is change them to "depends on X86_PLATFORM_DEVICES || !=
X86" everywhere?
>>=20
>> There are some places that depends on X86_PLATFORM_DEVICES. I think it's
>> almost always a mistake to have some places select and some places
>> depends on, and select should anyway be used with care. I'd go for
>> depends on.
>
> I'm a bit late to the party here, sorry.
>
> Note that X86_PLATFORM_DEVICES is an option which enables / disables
> a menu and does nothing more.
>
> Enabling it or depending on it by itself does nothing.
>
> The select used to be there since it must be selected to be able
> to select ACPI_WMI (which is no longer the case after this series).
>
> To depends on in XE was probably copy pasted from the existing
> select-s and then changed to a depends and already was a completely
> no-op since depending on ACPI_WMI was enough as that itself
> dependend on ACPI_WMI.
>
> As for X86_PLATFORM_DEVICES being needed for some backlight
> interfaces, depending on it by itself does not result in those
> interfaces being there. That requires enabling the actual drivers
> providing those interfaces.
>
> And I don't think that the GPU drivers should start depending
> on those since that will become very unyielding.
>
> TL;DR: I believe Armin's original patch is fine and this is
> a welcome cleanup / simplification of the DRM drivers Kconfig
> bits.

Your explanation makes sense, thanks.

BR,
Jani.


--=20
Jani Nikula, Intel
