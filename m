Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5643BDB0;
	Wed, 16 Sep 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542986; cv=none; b=EKJ8thdvAg2e+1AACfSwqKK5NJOEzPJpXh7H5RYWx8+ecI13+tXuNE+/5RFTeBb4DpzPOoRovzrNHTv9YoaUKX+37baAku95vRUEyx2B4WQWkfxshVxBQnaJoIj1FCp19qIwodnIrLEjPvVuuk4L6PGA+ppiehitXuwyA8u/61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542986; c=relaxed/simple;
	bh=wJASVwD5FkjisPWHjqrTjFP3UNclm4eHqGrZ4f0/D5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ek0G9XUgtUeheyKHxjJ7OrKLJauSkLrKP/zQxqX8xFzV7I3FoLxn5JLKKRSyQlodPOJPU6eM4VDP5sDnRrPXmDXQdtzJaWXWnN+L4EsjaNo4mBed3ZoLdvV6SgvlfopxYtoinnzK19CHy0qdgs540mvijTGMPkIvLVf5eOimWuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/WhEMKb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/WhEMKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789542985; x=1821078985;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wJASVwD5FkjisPWHjqrTjFP3UNclm4eHqGrZ4f0/D5M=;
  b=M/WhEMKbV2NhLvPVeSvRVk6O1WUM8aLAeKw3AikZLgUsX1ru6pfOez7F
   g4TX7iUkH44I3lDJV1Avgz3iacJ2zu8oKZPd2fsvFrd6sGVowybJeEFcb
   zdVuB15YIvFq3qWn5WYgSmLQEyoITZoYYRL4TP2mP+kI1LjGjX9lsDi6X
   3tjqrmCsoSjG7b5f1BDjwS1LmZhXDd0UAfdvvhO+jibH1YCEcBXH8+a+I
   Yny8TiKGRhE7YH4T5f8356wFDsheqMlf32myPJhNykpmtmaK0ESTyekw3
   Pb3HTxYVi3lPdSWHineeRPpU07hs4OIJSZnAqNz2w7or6VdYY2L7wsqxe
   Q==;
X-CSE-ConnectionGUID: PUl+XswCQu6VpLfNSnazQA==
X-CSE-MsgGUID: UffdZ8PhRpitqskr+28yyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93785551"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93785551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:16:24 -0700
X-CSE-ConnectionGUID: lJQK1QvPQCyySz8RA97EBA==
X-CSE-MsgGUID: TqnnTvGPT1OVP8fTWzuNdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276776558"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:16:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "hansg@kernel.org"
 <hansg@kernel.org>, "platform-driver-x86@vger.kernel.org"
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
In-Reply-To: <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
 <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com>
 <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
Date: Wed, 16 Sep 2026 10:16:13 +0300
Message-ID: <62d7da838e7042df8456e76190db792093065b57@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
> Am 15.09.26 um 14:31 schrieb Jani Nikula:
>
>> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =
wrote:
>>> GPU people heads up!!
>>>
>>> On Wed, 2 Sep 2026, Armin Wolf wrote:
>>>
>>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>> index 12e4a41bf1f0..50305630f533 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>>>>>         # ACPI_VIDEO's dependencies must also be selected.
>>>>>>         select INPUT if ACPI
>>>>>>         select ACPI_VIDEO if ACPI
>>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>>>>> The change below makes sense, but this one looks like it should remain
>>>>> unless X86_PLATFORM_DEVICES is handled some other way?
>>>>>
>>>>> Alex
>>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary because
>>>> ACPI-WMI depended on it in the past.
>>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymore.
>>> Hi all,
>>>
>>> Could more GPU people besides Alex take a look on this. I'd want to make
>>> progress with this series within this cycle but would prefer to have Ac=
ks
>>> from GPU side.
>> I share the same concern with Alex. It seems to me we could now end up
>> with x86 configurations without X86_PLATFORM_DEVICES, which handle
>> e.g. backlight on a lot of platforms.
>>
>> I think the safer option might be to go for:
>>
>> 	depends on X86_PLATFORM_DEVICES || !X86
>>
>> in all of the cases that select/depend on X86_PLATFORM_DEVICES in drm.
>>
>> The alternative is to find out, and handle the fallout, if any.
>>
>>
>> BR,
>> Jani.
>
> Alright, should i leave the original "select X86_PLATFORM_DEVICES if ..."=
 statements
> as-is or should is change them to "depends on X86_PLATFORM_DEVICES || !X8=
6" everywhere?

There are some places that depends on X86_PLATFORM_DEVICES. I think it's
almost always a mistake to have some places select and some places
depends on, and select should anyway be used with care. I'd go for
depends on.

BR,
Jani.


--=20
Jani Nikula, Intel
