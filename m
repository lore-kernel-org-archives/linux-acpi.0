Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558C2FF657
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101322; cv=none; b=hvfjnEG3u1gIeqGk7IiepH5iGGStvUamMbVVygfP7gKK1in+p0oD8QEthPFBkkPeF075KtsGSnENW7GMMMzVJanFpP0HloAzekEZpYYXN2i1rywoUTiwa3V7NjyDHXyd1fxQwktHELJppdiMEzdxFEIiwOouAMwS6WnHDF6rwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101322; c=relaxed/simple;
	bh=BervIjCNWYgiq6Xkg2V9+GWzJelrYF3LveoZ0abJTOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggEESQeYrwImatzdKOMYx1/CNZ9yjVhlZWJu7IqyEaolQIs5/YaOtseLL5sWB5jEC7qt9NgitJQKMf082AqIdYoddvfpH9ESubSZ/wa1zVkpatZUnWPkC/8w52nQMztolH64khGZ9A/loSL8ejLQmsUqpAXUmD0zWiEzHfecYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=R8mMzMIM; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="R8mMzMIM"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 6188DBBF0C
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 15:46:53 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id AAB13BBEEA
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 15:46:52 +0200 (EET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0168B1FF2C8
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 15:46:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1774100812;
	bh=xiwq465nIyKawZPObszjgC3E/vlcOWoJBtAsh09T+XE=;
	h=Received:From:Subject:To;
	b=R8mMzMIMe4lHp+dnpddPoH7UYXU67ih58ZQXF4lOuhRRNccClFiRdTY5EgMossENJ
	 kTksAey3whoa1/qogBtHAhSL3/VWbAlF7OuF3AIxe3q0cZRu23boOctFPho1cUrvWr
	 nCYbHKp/2s5Lyg/FbKR3WlhImyKq3FYwsAYwwEEVDaKc6x1HgS1eGbOFONqKIEcl3C
	 mFeZ7hwVpG0PHAex002Mz8hZkzXOdVHwOqO771zrafpxBRn2CXwgD5GomaexwowcYT
	 +0hvGHaCqHVtC35qmWLjOBwhiEQ+qxZVyeilgwOZZSwzHhQAogZ73xFsqDcZnDVSkn
	 uLrMnxPC98yyg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8297310ce0aso1140157b3a.2
        for <linux-acpi@vger.kernel.org>;
 Sat, 21 Mar 2026 06:46:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxCxMuDII3M0kGLoZS/LlhDMpkFDJMgXMZQmGnxL6RA8GKfc3Nej4sy6szgJ5Ywiqh9qmK6Gkx5L35@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsABYS1COFcrTaIpyFHh+t7XYQ1BAgykKnJCNqehjz8+RLNNh
	1SgLMMOPUAA57Bx5SanYUX9eEQ0yYhv/ntMxWRnHfPTa9JWgQaqV5gIcwQfQu7uM2/tkzYMGUZV
	Et5q1EkSPUQM8nuedwHLjws3JYZSVNzE=
X-Received: by 2002:a05:6a00:1707:b0:82a:8163:4bfe with SMTP id
 d2e1a72fcca58-82a8c38da93mr5128033b3a.60.1774100810311; Sat, 21 Mar 2026
 06:46:50 -0700 (PDT)
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
In-Reply-To: <4526e323-0c33-4e38-a46a-78ccd9548fa2@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 21 Mar 2026 14:46:38 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFN4wED6TgJgrKAtNFxY4TCJgnUVOcmb39Bchj8gGXvZg@mail.gmail.com>
X-Gm-Features: AaiRm53z-vO22wO_HFY-JpAuLBVC0nSIp6AZXL0OuOUCaCZIPQTD9cK09qQdlaE
Message-ID: 
 <CAGwozwFN4wED6TgJgrKAtNFxY4TCJgnUVOcmb39Bchj8gGXvZg@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
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
 <177410081223.2283306.8852773222345960961@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 20 Mar 2026 at 21:41, Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
>
>
> On 3/19/2026 7:35 AM, Antheas Kapenekakis wrote:
> > On Tue, 17 Mar 2026 at 16:13, Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >>
> >>
> >> On 3/17/26 07:09, Rafael J. Wysocki wrote:
> >>> On Tue, Mar 17, 2026 at 12:57=E2=80=AFPM Dmitry Osipenko
> >>> <dmitry.osipenko@collabora.com> wrote:
> >>>>
> >>>> On 3/16/26 22:52, Antheas Kapenekakis wrote:
> >>>>>> So in accordance with the above, /sys/power/standby is not a very
> >>>>>> fortunate choice of the name of this interface and I'm totally
> >>>>>> unconvinced that it belongs to sys/power because its role is not
> >>>>>> really power management (and it is ACPI-only for the time being).
> >>>>> Hm, most of the changes / implementation resides in the pm subsyste=
m
> >>>>> and it is related to the s2idle suspend flow.
> >>>>>
> >>>>> I assume that when it stops being ACPI only provided we reach a des=
ign
> >>>>> that allows for that, the related callbacks would also nest in pm o=
ps.
> >>>>>
> >>>>> Where could a more appropriate directory in sysfs be? I would still
> >>>>> tend towards /sys/power
> >>>>
> >>>> Question is whether anyone outside of ACPI will ever need the generi=
c
> >>>> interface. Making it generic based on guesswork could be a wasted ef=
fort
> >>>> that Rafael and others will have to maintain. The mode file could go
> >>>> under /sys/firmware/acpi if interface is made ACPI-specific.
> >>>
> >>> Well, experience shows that it may end up the other way around.
> >>>
> >>> People once thought that the platform profile interface would be
> >>> ACPI-specific and we ended up having to extend it via
> >>> platform_profile_class.
> >>>
> >>> I'm thinking that something similar may take place in this case.
> >>> Platforms that don't use ACPI may also want to define platform
> >>> triggers to somehow adjust platform settings and those may be
> >>> different from "inactive" or "snooze".
> >>>
> >>
> >> At which point you would almost wonder if this should be super general
> >> like "foreground_workload_type".
> >>
> >> Then this could be expanded for other uses later such as full screen
> >> video playback or full screen gaming.
> >
> > Mmm. This reminds me of AMD drm pp_power_profile_mode {BOOTUP_DEFAULT,
> > 3D_FULL_SCREEN, POWER_SAVING, VIDEO, VR, COMPUTE, CUSTOM, WINDOW_3D,
> > CAPPED, UNCAPPED}. I'm not sure anyone used it. I'd rather avoid the
> > complexity.
>
> There are certainly people using it, but it's more common in embedded
> applications than traditional desktop distros.
>
> It is not a perfect match to this concept, but definitely some parallels
> can be drawn.
>
> There are general things that might make sense if you know what the
> foreground workload is or the display is off.

Hm, yeah I guess so. I could see this ABI being also useful for
embedded devices to control their appearance. There's precedent with
e.g., charging_behaviour having dozens of device specific values,
where standard and longevity are the only ones used in laptops.

> >
> >> There could be hooks for scheduler too in the future from this hint to=
o
> >> then.
> >
> > Wouldn't it be better to defer to userspace? I'm not sure this would
> > have a meaningful difference in any case.
>
> I don't know one way or the other.  It would need to be prototyped to
> see what it actually looked like.  In the line of thinking Rafael
> mentioned that platform profile was ACPI and grew to a class I would
> generally just keep the design from pigeon holing too much on display
> off.  That's why I thought maybe foreground workload could potentially
> work well.

To go back to Rafael's suggestion of not using transitions for the
ABI, it would be possible to push the transition logic down to the
s2idle code and introduce a generic handler for it. SInce arbitrary
transitions are possible under this spec, the top-level ABI
implementation need not consider it.

Since it is very similar to platform_profiles, it could also be
potentially added there as activity_hint to the current
platform_profiles implementation and mirror its conventions. This
would avoid introducing new scaffolding.

Then s2idle would register a platform profile handler without
profiles, and instead only implement activity hint. Existing x86
platform drivers could also trivially implement support for it as
well. Although for WMI, the existing hooks for s2idle for Windows
would handle most current drivers.

An implementation for this would consist of two stages. First, the
callbacks would be moved to the beginning so they can be tested
independently. Then, platform_profile would be extended to support
activity_hint with states {snooze, resuming, inactive, active}, and
finally, s2idle would implement the handler with transition logic to
make sure the callbacks get called correctly always, including when
userspace ignores the file, where the full transition would occur in
begin() and end().

The legacy /sys/firmware/acpi/{activity_hint, activity_hint_choices}
would mirror the current conventions, perhaps with a custom value as
well.

How does this approach sound?

Antheas

