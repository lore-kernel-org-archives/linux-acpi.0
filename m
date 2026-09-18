Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64C432BC2
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736651; cv=pass; b=WTdivIWTQUkZrln/2CfsBSbP8AifOA9eDaAQmbirOhX334IPo94CqJyHqflGW/PTAzHm040xtDzzeGIi5QiXOd6eCawk89EQBQ7q+lHSviIcbN/IHWhMVBzwGuRVyCXpsUeM2gSd2vZEtjgQMTAYpceXp1hYyvW0Kz6oLieZUjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736651; c=relaxed/simple;
	bh=6cZQ88YvMyKDlbojOOX0uUwsznnXAQW99G7QctL7sho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0juHans7v1HMhaT/8IwexNZFD/xDEQu0CXE6npNkeddBUKnI9HfzTbLesBa0nwwZbkRf5T16pF9hucVZshtbbesa/84y+K6bpa3ahTTOkggrTN6fbLlF7HuUn0v6iCTuqAyp3Xejp57MaGCRCORUGk15/t9EpPSgxw97fzW0qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=redhHN05; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="redhHN05"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7e0766671so26215e0c.1
        for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 06:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789736648; cv=none;
        d=google.com; s=arc-20260327;
        b=UrCnsfPHNn+/sbU/LfUCVvZ+diezWzkGIUlGdLaHBx9WnjJL4hbQT/suX307kIBo6O
         srgI/DPNodWuxRA9ula2hLfLS9r5cMpFbjfcFsxzIvOmK70WRs5MaTIiggIn/vv2oJBi
         rfJTZd2V/t1ezTBZ4q7/PYZn1U6NBubyZe69V00HZ3wXRbKPOc+k6VLB8Xz6+GautyDD
         Y5JWixPcr+OT6FHmssbMFpuib0j5KvYkal88pOYZSkegXw+UzkGGnwG2OXD1hBxrLnB3
         Hf+gxuUIlFzVIdUVJoHwxVmRb6n0dlcuIsq8AMG+ucrjtZ7SfvTgnJIvc3GnarICmNSe
         8b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yCLjcMw1rcuu9wX+kCk+ppzWj5O7P6M4vBYFfJC61a8=;
        fh=tZbqCYpR1ROqEk8X2tcTWPhGr9mUjzL4ehRqAuyWOqs=;
        b=fiSAf6CDJ7JOrYMHWOkbi69K4lXwZhH7U/Eo3f0CDI76pO5P8W1gQzCrbskjorcp3w
         L1MrcTC7kGyngCXiLdt7HFqeHOkVJC+jyT+5dNWn4bJDz7EWnMA5aMqmHFISdi08Ummf
         DJh4pvJpzdFowmg1uVfQ9663jUx3JvKg1+jTAkYHRz5QkeL42abKTFAHiwSwgxtR+ajK
         ZfAUJJR+T8tLlZzZV6P2PgM6jYdWr2fapr3HuzNDs2f+8oU/HAwO7cE4X8N8k/sdKKtz
         bmUFDe206/bIWnNXKDr62j7bHp43prUPCZL/8tHTVjIwOUh1G4ct11DeXsgR9JHWYMEJ
         WnRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736648; x=1790341448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCLjcMw1rcuu9wX+kCk+ppzWj5O7P6M4vBYFfJC61a8=;
        b=redhHN0537THjErWIWHtqY0+u9ia3AjlOVAum3WKBMcMF1K+RAtSjeYzdgN/dv+d6C
         XqJcf1T4UhR2nowa5mJ58Vnfraghvk+5Ph71GGBFxY4scJG4wW4Og0cdQ7PNjPzv3F81
         bLrPxffqM0hXVGl9Kfu8vmyNfJsNrCa3xqmmAbACNfJj1Weg0JaCyRuyGKM+YnYtMZ5r
         ktl9tOZ/jGJTdLiQlDSSiEBlmnpJxpKbLpTlsKvxchprs5LYFfXiAdV0Tm0QVYlLlHxh
         aynAD6TttgpZIef/Z4/t1O05Rxkp80ijWzt5pvl0RJlVy+Ub1aM34MdTcJOTWWIhDl30
         U6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736648; x=1790341448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCLjcMw1rcuu9wX+kCk+ppzWj5O7P6M4vBYFfJC61a8=;
        b=dgtwB7xQkmMc8FuTzXZLz2Em7KUz/A4KmvqvJXpQWXEIBSph8ybl1nTVZeF9JIGn+I
         l0UkUiNr+O+809z+E5ST/ZPr331vp4eQDLVFDoNVCpzFn6PoeltBE27r8nxi8FylGW/2
         IxAJu9OhyassdSVVhYdfdDm1UUrAlh93PM3q9aLqXuumoRzxSFKR+jI9HHLQNYQULfUy
         5h8fBpamcH6hxY9QmqjrJrY/+IBkd3TdSRiEoR0CGLAstVJT7Lmls3QY8l7vwL1kVkHD
         UPWowY4BZV/dPCBdJNqjnIJgS9hX46r9/YrwDJItk4W1duaVhHhTcko0VO2ZPdGt/VxN
         w+EA==
X-Forwarded-Encrypted: i=1; AKwUvBz8uFAp4YjM1Hn6MYg8Y2ePLRA62OLxlDheKyVD2cm6XX31QXXBjK/agEZnOmeJsmzFvU8zlVaUFcTa@vger.kernel.org
X-Gm-Message-State: AFuF++nJ1Rk6/xNIgExvBnnszsO0iPIySsW0GB6F1lESaSZkAJ/NOzXF
	vDW5kaWn4qdcHCRTuzwdF7qghLsLcDcRYh3dbNG3ZzakagMyhhW8AfqZTmfvO75Qhz/nmm4sd2f
	mvEUFKONMh3FOFHnfpFMyFszEc4YZuNc=
X-Gm-Gg: AYBFou2dZk+EL2Djz8S7deeg+MSKpy1OiCx569C8ZJBzGgKem/VrL+fZ2XtnfEoeR7h
	aDPrBbZKa7qj8cBr7diQg5/+Jm9Mq0P005UIAXh2K9QI5G5u+leJFqOBLUR4BIEK/MbrWkfLAxC
	eY/xE//Xo4H3qiMYwCsuuYoT5gSqtJ34AxtssL0V0ItKbibq4jy30QwN8bzG9bXG2ptcPhmJPC7
	DA0eV6zXoOtId73iBfIEQx5xxdhs/Gsf2MFnA/aGsmXFHxVLT1/xHFz8vh1HpAkbZ8zK/i/shny
	hDRabe2DHjYQiLz4xmMA3Y0UY0Vq9DMK5XWtDJ6REViUsBEtkJtbnLp/QKxmIEqOdNX+mZiH7fq
	hmAzkc7JGPJGlZxyphraglzaTGtXgHIUOyzjvdb7WGsA=
X-Received: by 2002:a05:6102:5e8b:b0:7a3:2e52:114b with SMTP id
 ada2fe7eead31-7a59dd5f437mr474902137.2.1789736648001; Fri, 18 Sep 2026
 06:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724025959.142826-1-W_Armin@gmx.de> <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de> <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com> <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
 <62d7da838e7042df8456e76190db792093065b57@intel.com> <06550473-63c2-4a3e-a5ad-7e23d7b6b050@kernel.org>
 <d696d85c44930d2124054ce11a06d3096c0db04a@intel.com>
In-Reply-To: <d696d85c44930d2124054ce11a06d3096c0db04a@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Sep 2026 09:03:54 -0400
X-Gm-Features: AcwNN1XHNFQcATzjGyaYhKX2aDW9koV5gKbX6KpcatyNovdS0W4jwqBJ2n5fxn8
Message-ID: <CADnq5_PT7s6ixTqDSwe9ai9tUQa04z7UnwhMn7bo7CcsH5Qf0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux@weissschuh.net" <linux@weissschuh.net>, "rafael@kernel.org" <rafael@kernel.org>, 
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"patrik.r.jakobsson@gmail.com" <patrik.r.jakobsson@gmail.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, 
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net" <tursulin@ursulin.net>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 7:01=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Fri, 18 Sep 2026, Hans de Goede <hansg@kernel.org> wrote:
> > Hi,
> >
> > On 16-Sep-26 09:16, Jani Nikula wrote:
> >> On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
> >>> Am 15.09.26 um 14:31 schrieb Jani Nikula:
> >>>
> >>>> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.c=
om> wrote:
> >>>>> GPU people heads up!!
> >>>>>
> >>>>> On Wed, 2 Sep 2026, Armin Wolf wrote:
> >>>>>
> >>>>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>> index 12e4a41bf1f0..50305630f533 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
> >>>>>>>>         # ACPI_VIDEO's dependencies must also be selected.
> >>>>>>>>         select INPUT if ACPI
> >>>>>>>>         select ACPI_VIDEO if ACPI
> >>>>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> >>>>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
> >>>>>>> The change below makes sense, but this one looks like it should r=
emain
> >>>>>>> unless X86_PLATFORM_DEVICES is handled some other way?
> >>>>>>>
> >>>>>>> Alex
> >>>>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary be=
cause
> >>>>>> ACPI-WMI depended on it in the past.
> >>>>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 any=
more.
> >>>>> Hi all,
> >>>>>
> >>>>> Could more GPU people besides Alex take a look on this. I'd want to=
 make
> >>>>> progress with this series within this cycle but would prefer to hav=
e Acks
> >>>>> from GPU side.
> >>>> I share the same concern with Alex. It seems to me we could now end =
up
> >>>> with x86 configurations without X86_PLATFORM_DEVICES, which handle
> >>>> e.g. backlight on a lot of platforms.
> >>>>
> >>>> I think the safer option might be to go for:
> >>>>
> >>>>    depends on X86_PLATFORM_DEVICES || !X86
> >>>>
> >>>> in all of the cases that select/depend on X86_PLATFORM_DEVICES in dr=
m.
> >>>>
> >>>> The alternative is to find out, and handle the fallout, if any.
> >>>>
> >>>>
> >>>> BR,
> >>>> Jani.
> >>>
> >>> Alright, should i leave the original "select X86_PLATFORM_DEVICES if =
..." statements
> >>> as-is or should is change them to "depends on X86_PLATFORM_DEVICES ||=
 !X86" everywhere?
> >>
> >> There are some places that depends on X86_PLATFORM_DEVICES. I think it=
's
> >> almost always a mistake to have some places select and some places
> >> depends on, and select should anyway be used with care. I'd go for
> >> depends on.
> >
> > I'm a bit late to the party here, sorry.
> >
> > Note that X86_PLATFORM_DEVICES is an option which enables / disables
> > a menu and does nothing more.
> >
> > Enabling it or depending on it by itself does nothing.
> >
> > The select used to be there since it must be selected to be able
> > to select ACPI_WMI (which is no longer the case after this series).
> >
> > To depends on in XE was probably copy pasted from the existing
> > select-s and then changed to a depends and already was a completely
> > no-op since depending on ACPI_WMI was enough as that itself
> > dependend on ACPI_WMI.
> >
> > As for X86_PLATFORM_DEVICES being needed for some backlight
> > interfaces, depending on it by itself does not result in those
> > interfaces being there. That requires enabling the actual drivers
> > providing those interfaces.
> >
> > And I don't think that the GPU drivers should start depending
> > on those since that will become very unyielding.
> >
> > TL;DR: I believe Armin's original patch is fine and this is
> > a welcome cleanup / simplification of the DRM drivers Kconfig
> > bits.
>
> Your explanation makes sense, thanks.

Yeah, sounds good.  Thanks!

Alex

>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel
