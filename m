Received: from mail-oi2-f35.google.com (mail-oi2-f35.google.com [74.125.231.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF512247291
	for <linux-acpi@vger.kernel.org>; Wed, 23 Sep 2026 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139683; cv=pass; b=S3Ll3il8Cg9xRt7G39g6VrmvlEMOlHG9ddCEV6K39v2WprXeCQmd8cb6UtFe8S7EEcf+TEY2kKQWEQNYr4N13vqcPmQcXYrzbG6Oo+p+I7NzNAYz1FDiASqASFzdAOb/N55xVZ36/e9ydgX2pOFbMKDmV7zCA7fjY6RE++o3bTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139683; c=relaxed/simple;
	bh=VaTQ0YbR4J1XE64Y2Zx/iJej5LoqYmr2rAZ8s8R7enI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxeMkpkMLBRRTCfau2uJajJkM1YEQqXyRbu0Wu2fy4wA0vJBurp5yo5X3uVKPTLOwRFejYkirEwss4oycaBjT8REuRUtkdjCpZWKKfBm8v5h6fXgEnjbmxqt1jnyioRz4WfVNwFEpkhS7uDZuYsU6EWGFHvhOdWeNtcORQORWeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rY2Waihv; arc=pass smtp.client-ip=74.125.231.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY2Waihv"
Received: by mail-oi2-f35.google.com with SMTP id 46e09a7af769-8055dcba0a5so147066a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 22:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790139679; cv=none;
        d=google.com; s=arc-20260327;
        b=p/ruiSBKX1xtpdg2zrTgShEmVqanNwfyiMSZCPD/x6qQIitl6sXmrsAVx+iHjM+EBr
         /Brw0bNCPFxqCeX7rByekmEdVtm/f9N1NYhHMGX8WUpl7nYIM1VRwfBUl5tD1Q/FPsOz
         N9WGRHgJQoGYfN4cZmW8HS7o1tPPDYga6iOhmIxNwhbCd0ArK9d/u3LSc8m1Da7F1CjS
         d2K/Zpi9nY55+nowDPG4+0ASebetmRcziJFD/p0gFVE9re/Pg2sZd/B45A53itUPE8RO
         2n/SZP7v2M/RmtdKtj1W17CgLSENT0R3goO/vCUD6y8Hypve323niP+hLVocEQvZoduH
         wT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9t+pGf5Jdws57vhvMQ8eJxDP4MEnxA9XvPVPFGvtB4=;
        fh=NYTGO/A/mpNln0ok7iN8082TO6hy5ZBVZH4jjeospLs=;
        b=exrocYT1nmmPDXB3uE5vGcRiFBOrVzxbSdOMDCBk8S+F+N+KWW3YlLeZ1dRCR7Pa5f
         laaco4sKVN1fO/CnbyGOgrMyzp0vRO3GRv8v1I5sgIkDMYXmwQ4QMdG2c8pgDTtHLp9U
         h652lB9arz48Gxg31irGnxM8+dBmwb/20lfXyxhn6qh5RFpXFe3o8C5ctIhnQfw1kXuW
         C2dBFWBUkh51cu3zfl1Tttfb6tK06wmIs/c4RSB6Ykobn9skpRlDlp7JvWrdE/Od9c2X
         kxEYakB+BCsEw4A5mgJkGwJdGnKC8EJpBnVOJpT7fXIRnfzH8ZLnWxW2a5VCinANuhqD
         7bRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139679; x=1790744479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s9t+pGf5Jdws57vhvMQ8eJxDP4MEnxA9XvPVPFGvtB4=;
        b=rY2WaihvHCYF1qUiD+VnCqVNCZ2Y0inQVHQV+3AVW6i37Ax12cWxIKhOXGARWUiDhB
         Q6nYXucxPjRCrY23nY6EnihXhN9KpYZ1lUO9pH/ls+Xn6wVVoWRc79NlN4t1TMkXp8T2
         QR6M+ZMGKekkJCIReAudzMeJWzREVI4pW7EykFtOtzdGRuLE6oIzWT7Y2g95rc+35Ppt
         8FLn2/ozAJBqhEtQu6NmJVJgRik+NQlQ1BS3S5QmfKSV4uf4iKpRpPbscbrJzT722/wM
         2ta68cgsXRfYnk7P92fUKZqGN+AjDBrSU6ImLvBwtT3vtiUu9LSwm8rnaGi3lVU3l1g0
         He/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139679; x=1790744479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9t+pGf5Jdws57vhvMQ8eJxDP4MEnxA9XvPVPFGvtB4=;
        b=b9SNb6wupCJpTV2DDVE5OX6mgRRtWsaYlW740GKVbYNHVTdk2OAGA6kDyLgh1cw7D9
         JPG68WVW+XyqwsJUlXgou56bTyTmSmjapNXoTF1dtlerma0S37LdPQGktbB6ld6HRf77
         HccPi4nxooI4sXIuZTtTrRZdfds/BqSF1vmqIecYS1N5xibAhjf5/hXiWR46bYoHYyoD
         xu+QoAYqPTMh0rSNudDH8DoOABavQT3g2Fhi6LZI3qvH7RD++DG3dN9BeUixaTuuR8eT
         1sZsqr0OWX/leWLdaiR2pMiwQsWcgHhbK6A2Gs2qV3bDJG9+aO/CSXNt6VH9WM73ohAG
         Q4fw==
X-Forwarded-Encrypted: i=1; AKwUvByLYmdAVAquL6QjM2qT0Atdu5FETFtw9SKT0ax05iNRGKx7G04SkOq5fbBiWFPyU2dTx+PLGSgTWZjx@vger.kernel.org
X-Gm-Message-State: AFuF++nL/SlfSlG0tnbPdzZ6tDqJ77nFKXNyA/uYA+jbyRQlCYZm/mV+
	M0KW//uERuObuQNVyPjVfmIyZ0zilU2E313ERzu21h/bE4mCpSDDRIykZsYnvNj342+scYmeGVs
	9RsOMrVlP1dZwGOV2i19k7R8ItndZARM=
X-Gm-Gg: AYBFou0/IfGplMZEGfu//YaHSxG7/Ej1OWa1cJBlFbWsGhQp282t1/jfRao8N0h5urZ
	6ynfzbxPwSBIWQDFglVffhi2rNZtCh3fkn3yP/UzgSsGINHy+52eyRqYIP50piIrmm/dVYWXbtP
	He+KUME+rT+gbW/qXDRFFkynjtG6jRZF8gvdMSPGyYlvDflAY0iP9Tx8xRi3IKJefz6xHuZ4tQ2
	0xEO5tnrPT7cwJo8rSUkUp5wJRmxfnuK/ncrB5QGFwAvwtpWJY/UNAjjSCfb/jByaHS4yemFOOY
	iyzI3vD+cdhcw/PWOTXD3TTqMko20oeioCo1oxq/1c/E8lyWYCalWF9RJW5lL48GDw==
X-Received: by 2002:a05:6830:2105:b0:814:fd96:b005 with SMTP id
 46e09a7af769-815fa7a3aa8mr1368055a34.10.1790139679573; Tue, 22 Sep 2026
 22:01:19 -0700 (PDT)
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
 <d696d85c44930d2124054ce11a06d3096c0db04a@intel.com> <CADnq5_PT7s6ixTqDSwe9ai9tUQa04z7UnwhMn7bo7CcsH5Qf0w@mail.gmail.com>
 <154fc984-5c29-4a23-ab8b-736471f419a1@gmx.de>
In-Reply-To: <154fc984-5c29-4a23-ab8b-736471f419a1@gmx.de>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 23 Sep 2026 07:01:07 +0200
X-Gm-Features: AclHuK9iIINoALCOYPcubT5-e7bSzbMlB0XgN7hLaVHol59ylJMeoZCRLCs4o-M
Message-ID: <CAMeQTsZw8P+__EXsUSW8G6LONN85HPwmG1+zQXwpmHEC=npWyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
To: Armin Wolf <W_Armin@gmx.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux@weissschuh.net" <linux@weissschuh.net>, "rafael@kernel.org" <rafael@kernel.org>, 
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
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

On Tue, Sep 22, 2026 at 9:57=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 18.09.26 um 15:03 schrieb Alex Deucher:
>
> > On Fri, Sep 18, 2026 at 7:01=E2=80=AFAM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> >> On Fri, 18 Sep 2026, Hans de Goede <hansg@kernel.org> wrote:
> >>> Hi,
> >>>
> >>> On 16-Sep-26 09:16, Jani Nikula wrote:
> >>>> On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
> >>>>> Am 15.09.26 um 14:31 schrieb Jani Nikula:
> >>>>>
> >>>>>> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel=
.com> wrote:
> >>>>>>> GPU people heads up!!
> >>>>>>>
> >>>>>>> On Wed, 2 Sep 2026, Armin Wolf wrote:
> >>>>>>>
> >>>>>>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
> >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>>>> index 12e4a41bf1f0..50305630f533 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> >>>>>>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
> >>>>>>>>>>          # ACPI_VIDEO's dependencies must also be selected.
> >>>>>>>>>>          select INPUT if ACPI
> >>>>>>>>>>          select ACPI_VIDEO if ACPI
> >>>>>>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> >>>>>>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
> >>>>>>>>> The change below makes sense, but this one looks like it should=
 remain
> >>>>>>>>> unless X86_PLATFORM_DEVICES is handled some other way?
> >>>>>>>>>
> >>>>>>>>> Alex
> >>>>>>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary =
because
> >>>>>>>> ACPI-WMI depended on it in the past.
> >>>>>>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 a=
nymore.
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> Could more GPU people besides Alex take a look on this. I'd want =
to make
> >>>>>>> progress with this series within this cycle but would prefer to h=
ave Acks
> >>>>>>> from GPU side.
> >>>>>> I share the same concern with Alex. It seems to me we could now en=
d up
> >>>>>> with x86 configurations without X86_PLATFORM_DEVICES, which handle
> >>>>>> e.g. backlight on a lot of platforms.
> >>>>>>
> >>>>>> I think the safer option might be to go for:
> >>>>>>
> >>>>>>     depends on X86_PLATFORM_DEVICES || !X86
> >>>>>>
> >>>>>> in all of the cases that select/depend on X86_PLATFORM_DEVICES in =
drm.
> >>>>>>
> >>>>>> The alternative is to find out, and handle the fallout, if any.
> >>>>>>
> >>>>>>
> >>>>>> BR,
> >>>>>> Jani.
> >>>>> Alright, should i leave the original "select X86_PLATFORM_DEVICES i=
f ..." statements
> >>>>> as-is or should is change them to "depends on X86_PLATFORM_DEVICES =
|| !X86" everywhere?
> >>>> There are some places that depends on X86_PLATFORM_DEVICES. I think =
it's
> >>>> almost always a mistake to have some places select and some places
> >>>> depends on, and select should anyway be used with care. I'd go for
> >>>> depends on.
> >>> I'm a bit late to the party here, sorry.
> >>>
> >>> Note that X86_PLATFORM_DEVICES is an option which enables / disables
> >>> a menu and does nothing more.
> >>>
> >>> Enabling it or depending on it by itself does nothing.
> >>>
> >>> The select used to be there since it must be selected to be able
> >>> to select ACPI_WMI (which is no longer the case after this series).
> >>>
> >>> To depends on in XE was probably copy pasted from the existing
> >>> select-s and then changed to a depends and already was a completely
> >>> no-op since depending on ACPI_WMI was enough as that itself
> >>> dependend on ACPI_WMI.
> >>>
> >>> As for X86_PLATFORM_DEVICES being needed for some backlight
> >>> interfaces, depending on it by itself does not result in those
> >>> interfaces being there. That requires enabling the actual drivers
> >>> providing those interfaces.
> >>>
> >>> And I don't think that the GPU drivers should start depending
> >>> on those since that will become very unyielding.
> >>>
> >>> TL;DR: I believe Armin's original patch is fine and this is
> >>> a welcome cleanup / simplification of the DRM drivers Kconfig
> >>> bits.
> >> Your explanation makes sense, thanks.
> > Yeah, sounds good.  Thanks!
> >
> > Alex
>
> Nice, i suppose we can apply this series as-is then?

Sorry I'm a bit late here, but for the gma500 part:
Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

>
> Thanks,
> Armin Wolf
>
> >> BR,
> >> Jani.
> >>
> >>
> >> --
> >> Jani Nikula, Intel
