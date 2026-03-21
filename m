Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3030E836
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132433; cv=none; b=fCmgyN+1XuOFpD9OaxiBuJCC0k2YUmg2c5E4+dPpLqqSDXFyPTKx18fSAccNlP7CxaLoREkKKLIK06adWZ9PAWP5zCLqW87sPa/UAxXlyqmZW6F0vTOaBPRVRpl1nlOZCSEv5joZHn/Fg3B9Dbd5MvKn4Y4i30quu/6X2nmUIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132433; c=relaxed/simple;
	bh=7FBvxLA6BRVsH6j7byXXKEfPmpam9aIRsLDHfNUVNAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3mzqH87S/ScHJ/UJTfkB/7F+ypSbkHR/glu9Gq1sJohYh+fiamB8nj1rfryDGM/TqGCWF5pn15mD1diUXYYCqELcGNv6VyMSlOa17kajp389TZ2PAN4EjEnFLZuBY06ksfWwPEQo5BtJhYwsMaeDta/xJkBvVVOcxklILwqRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=dH9WtXFW; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="dH9WtXFW"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 9D5373EAD3
	for <linux-acpi@vger.kernel.org>; Sun, 22 Mar 2026 00:33:48 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id D68B93EB3E
	for <linux-acpi@vger.kernel.org>; Sun, 22 Mar 2026 00:33:47 +0200 (EET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 05506200D54
	for <linux-acpi@vger.kernel.org>; Sun, 22 Mar 2026 00:33:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1774132427;
	bh=g83hBPqOere4qog2fhDUuhHoURqHpybGBklc4ypQFv8=;
	h=Received:From:Subject:To;
	b=dH9WtXFWMTTRJWV42OvkDTsyjmvJWrqv97/fM9PNa9080JPzmZVQr/VqC8ktEqfid
	 kybC8Nqiu3EMEd0k/ughGYab0Xlr8RBMhBJh3HrvyYQG3W4JsVqMfTR9Q3Zexux8VC
	 ZFC9YnoP8TCVDIuP9SIjT8iNNq/zry8M9p9hEpiueVAap6tpoqU5tu3dqwE+4Ao3MO
	 VsMcFMYwOd3UMW2q/gFVlpZ0oxdSE1foqFyRiSqpK8sQS2iDnN7a08pE8zBtTMa7jG
	 0sbJqFq7BWN5mMbwvlHqNbLD1rnJMSoJe/Isi1aayhf1qO/hIX3B+V739GQpKIpLyw
	 qVt7FBC6n4DfQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f171.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c739561f0d3so1333082a12.3
        for <linux-acpi@vger.kernel.org>;
 Sat, 21 Mar 2026 15:33:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCURezllGRdWYJDrwvrv45+tf/RyLtqcrRCdRboOMmulAi2I51wfyThEi3qu0Z5sYhHnioYRhUdMRC27@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMtOFXO1+5YyvHwMDRXnV/Y1tzwIQeXkkgNeASANBIRo1mca+
	0FtfxJ8YYD3LAE75IVYU3wYpUmrfgnc4dqzMzypN78RyEatPFWtCBy1t1h45/XxC6/ChGgMP6Pp
	/51FbQkCgyRry5rzH7ykoZY7MmsZkZdQ=
X-Received: by 2002:a05:6a21:e098:b0:398:951c:b66 with SMTP id
 adf61e73a8af0-39bcec5afcbmr6118018637.66.1774132425485; Sat, 21 Mar 2026
 15:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
 <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
 <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
 <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
 <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
 <4526e323-0c33-4e38-a46a-78ccd9548fa2@kernel.org>
 <CAGwozwFN4wED6TgJgrKAtNFxY4TCJgnUVOcmb39Bchj8gGXvZg@mail.gmail.com>
 <CAGwozwHPizKuAvN+dxHYPt45OTKKgfCg62a9gv+Cn_EpAtgfgw@mail.gmail.com>
 <1884bb9d-2720-4cde-8a8e-35a9c0c4769c@kernel.org>
In-Reply-To: <1884bb9d-2720-4cde-8a8e-35a9c0c4769c@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 21 Mar 2026 23:33:34 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE=2zdxSA39K2qD0p3_rbhpoMiHD7YbJYBBWC93m+0GZg@mail.gmail.com>
X-Gm-Features: AaiRm51APrgaOeTwSxmh2mo-3FXsIhbMIQyJ_fc4nnPK9_dgRMR3WUc32aV6S_0
Message-ID: 
 <CAGwozwE=2zdxSA39K2qD0p3_rbhpoMiHD7YbJYBBWC93m+0GZg@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	richard@hughsie.com, sebastian.reichel@collabora.com,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177413242727.4099134.6227407119097629197@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 21 Mar 2026 at 19:43, Mario Limonciello <superm1@kernel.org> wrote:
>
>
>
> On 3/21/26 8:52 AM, Antheas Kapenekakis wrote:
> > On Sat, 21 Mar 2026 at 14:46, Antheas Kapenekakis <lkml@antheas.dev> wr=
ote:
> >>
> >> On Fri, 20 Mar 2026 at 21:41, Mario Limonciello (AMD) (kernel.org)
> >> <superm1@kernel.org> wrote:
> >>>
> >>>
> >>>
> >>> On 3/19/2026 7:35 AM, Antheas Kapenekakis wrote:
> >>>> On Tue, 17 Mar 2026 at 16:13, Mario Limonciello
> >>>> <mario.limonciello@amd.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 3/17/26 07:09, Rafael J. Wysocki wrote:
> >>>>>> On Tue, Mar 17, 2026 at 12:57=E2=80=AFPM Dmitry Osipenko
> >>>>>> <dmitry.osipenko@collabora.com> wrote:
> >>>>>>>
> >>>>>>> On 3/16/26 22:52, Antheas Kapenekakis wrote:
> >>>>>>>>> So in accordance with the above, /sys/power/standby is not a ve=
ry
> >>>>>>>>> fortunate choice of the name of this interface and I'm totally
> >>>>>>>>> unconvinced that it belongs to sys/power because its role is no=
t
> >>>>>>>>> really power management (and it is ACPI-only for the time being=
).
> >>>>>>>> Hm, most of the changes / implementation resides in the pm subsy=
stem
> >>>>>>>> and it is related to the s2idle suspend flow.
> >>>>>>>>
> >>>>>>>> I assume that when it stops being ACPI only provided we reach a =
design
> >>>>>>>> that allows for that, the related callbacks would also nest in p=
m ops.
> >>>>>>>>
> >>>>>>>> Where could a more appropriate directory in sysfs be? I would st=
ill
> >>>>>>>> tend towards /sys/power
> >>>>>>>
> >>>>>>> Question is whether anyone outside of ACPI will ever need the gen=
eric
> >>>>>>> interface. Making it generic based on guesswork could be a wasted=
 effort
> >>>>>>> that Rafael and others will have to maintain. The mode file could=
 go
> >>>>>>> under /sys/firmware/acpi if interface is made ACPI-specific.
> >>>>>>
> >>>>>> Well, experience shows that it may end up the other way around.
> >>>>>>
> >>>>>> People once thought that the platform profile interface would be
> >>>>>> ACPI-specific and we ended up having to extend it via
> >>>>>> platform_profile_class.
> >>>>>>
> >>>>>> I'm thinking that something similar may take place in this case.
> >>>>>> Platforms that don't use ACPI may also want to define platform
> >>>>>> triggers to somehow adjust platform settings and those may be
> >>>>>> different from "inactive" or "snooze".
> >>>>>>
> >>>>>
> >>>>> At which point you would almost wonder if this should be super gene=
ral
> >>>>> like "foreground_workload_type".
> >>>>>
> >>>>> Then this could be expanded for other uses later such as full scree=
n
> >>>>> video playback or full screen gaming.
> >>>>
> >>>> Mmm. This reminds me of AMD drm pp_power_profile_mode {BOOTUP_DEFAUL=
T,
> >>>> 3D_FULL_SCREEN, POWER_SAVING, VIDEO, VR, COMPUTE, CUSTOM, WINDOW_3D,
> >>>> CAPPED, UNCAPPED}. I'm not sure anyone used it. I'd rather avoid the
> >>>> complexity.
> >>>
> >>> There are certainly people using it, but it's more common in embedded
> >>> applications than traditional desktop distros.
> >>>
> >>> It is not a perfect match to this concept, but definitely some parall=
els
> >>> can be drawn.
> >>>
> >>> There are general things that might make sense if you know what the
> >>> foreground workload is or the display is off.
> >>
> >> Hm, yeah I guess so. I could see this ABI being also useful for
> >> embedded devices to control their appearance. There's precedent with
> >> e.g., charging_behaviour having dozens of device specific values,
> >> where standard and longevity are the only ones used in laptops.
> >>
> >>>>
> >>>>> There could be hooks for scheduler too in the future from this hint=
 too
> >>>>> then.
> >>>>
> >>>> Wouldn't it be better to defer to userspace? I'm not sure this would
> >>>> have a meaningful difference in any case.
> >>>
> >>> I don't know one way or the other.  It would need to be prototyped to
> >>> see what it actually looked like.  In the line of thinking Rafael
> >>> mentioned that platform profile was ACPI and grew to a class I would
> >>> generally just keep the design from pigeon holing too much on display
> >>> off.  That's why I thought maybe foreground workload could potentiall=
y
> >>> work well.
> >>
> >> To go back to Rafael's suggestion of not using transitions for the
> >> ABI, it would be possible to push the transition logic down to the
> >> s2idle code and introduce a generic handler for it. SInce arbitrary
> >> transitions are possible under this spec, the top-level ABI
> >> implementation need not consider it.
> >>
> >> Since it is very similar to platform_profiles, it could also be
> >> potentially added there as activity_hint to the current
> >> platform_profiles implementation and mirror its conventions. This
> >> would avoid introducing new scaffolding.
> >>
> >> Then s2idle would register a platform profile handler without
> >> profiles, and instead only implement activity hint. Existing x86
> >> platform drivers could also trivially implement support for it as
> >> well. Although for WMI, the existing hooks for s2idle for Windows
> >> would handle most current drivers.
> >>
> >> An implementation for this would consist of two stages. First, the
> >> callbacks would be moved to the beginning so they can be tested
> >> independently. Then, platform_profile would be extended to support
> >> activity_hint with states {snooze, resuming, inactive, active}, and
> >> finally, s2idle would implement the handler with transition logic to
> >> make sure the callbacks get called correctly always, including when
> >> userspace ignores the file, where the full transition would occur in
> >> begin() and end().
> >>
> >> The legacy /sys/firmware/acpi/{activity_hint, activity_hint_choices}
> >> would mirror the current conventions, perhaps with a custom value as
> >> well.
> >>
> >> How does this approach sound?
> >
> > Perhaps re-using platform_profiles is not wise, after all the
> > boilerplate would be small and bolting on new hooks would be around
> > the same amount of code. New implementation would be better. How would
> > that approach sound like.
> >
> >> Antheas
> >
>
> I really don't want our top level interface for this thing to end up in
> /sys/firmware/acpi.  The concept of system posture, or foreground
> workload, or whatever we call it isn't an ACPI concept.  It might have
> direct implications for an ACPI implementation (IE the calling of this
> _DSM) but there is no reason we can't have a non-ACPI implementation too
> with the right knobs.

I wouldn't call platform_profile ACPI either, but it just kind of
ended up there. Where would be a better position for it?

Antheas

