Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36C2D97B7
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101175; cv=none; b=oHsVIEelnPzGj5mnoMHh15AuKNlfHO4Lgu0BUZ1kxI3/TcZ3W+C4ridoMaFTYtc6wzftkNQRuHwJSr5FEczUw0YksPbLIG3AzLNlA6y2Rzz0qCqrYpKsyV6jOa7HRjY+QIPgQ5IJxMpDdK7iYda5S+V9L4f6BjDFT16+tAmKbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101175; c=relaxed/simple;
	bh=pSrQFISHoKXyHQIUhkXCFpCbMCzj4RjzSqm6/i2mg7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBeFVQgXf2D1eEa3zu6SUBBJC5D5Q2/wwfLf8XseWYN874AbP0s5ZjJS4cdS5bEBXeJNoLv8PujXraWO83KJbYyYS2ZjzCnQH1SHmZCzn8gGOdGkRqGkUgX/fidD0vda00lrbtA0F3hk13GtNbbIl2YUuuXYssMmWhudtO5Dum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AC8gJofD; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AC8gJofD"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id D5E2341941
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 15:52:51 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 190CB40146
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 15:52:51 +0200 (EET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 474451FD7D1
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 15:52:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1774101170;
	bh=N2YHQTOMNOQ3BeqYGL1sESopPGERRsjPH2ErqyMNqJI=;
	h=Received:From:Subject:To;
	b=AC8gJofDS0PldvaxsPjM2MC/UTyl4lhavQQ75GAGmXBMXe5Ai6LmXm3ODelyqe/zV
	 lyTEgpKj2Q66NrJ0LAlnoJfnpNTFOpo4cxC7aZmQCUCL4Ap2bEpzmQcwpVLhKt5Ci5
	 gTZXnJUrKg4KE5eWVRf7OviNzEFC8M2IR2/vEaaVQRsVUM+sDwIQGq4HylVJd34vwa
	 ss9tp3IeZs/oqqURYk1wtTHK6J1WR7pJnKiE1aWbdTj9kxNiCWShur3YTFHVwhTSh3
	 27A7WyEZJWavQSF1cgUIp34gNMxtN6Dr7kd9kloL0K0+cEzpm0sPiC4V8SvvRJAHSm
	 PsAO2MU3NdzvQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.41) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f41.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-35b9d29480aso1212040a91.1
        for <linux-acpi@vger.kernel.org>;
 Sat, 21 Mar 2026 06:52:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+/6RFgQsltIIcjnxnwf6b3/ywgb8cnQ9wBgFX/LcWTYhub7EfuMg+8NIqQh3eG6ApTH9ri0cSMv5M@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QnQ6eNLt2Dyz24IwXS4Wgl7QT/WUK+2WsCNReW4K1fQrO61b
	QtE7/5G8UK2WAGVlvbkck8a35a06Vc+VTIkvPyFdqe18L5FIKvhQ24RfCODcmXGZpjuIrKq+eVt
	LvP/ZVfdX9HkIxwnlQ8cdDTljfQJqF84=
X-Received: by 2002:a17:90b:35d0:b0:358:f0d0:1a19 with SMTP id
 98e67ed59e1d1-35bd2c62be7mr6105082a91.12.1774101169125; Sat, 21 Mar 2026
 06:52:49 -0700 (PDT)
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
In-Reply-To: 
 <CAGwozwFN4wED6TgJgrKAtNFxY4TCJgnUVOcmb39Bchj8gGXvZg@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 21 Mar 2026 14:52:37 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHPizKuAvN+dxHYPt45OTKKgfCg62a9gv+Cn_EpAtgfgw@mail.gmail.com>
X-Gm-Features: AaiRm51UPd3-efXZLk-I0C4J9RfbowQIlGsfgkB8F1F3ZlUP_xWTP2hvi7nX2S4
Message-ID: 
 <CAGwozwHPizKuAvN+dxHYPt45OTKKgfCg62a9gv+Cn_EpAtgfgw@mail.gmail.com>
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
 <177410117051.2306865.4394648876429558031@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 21 Mar 2026 at 14:46, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Fri, 20 Mar 2026 at 21:41, Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
> >
> >
> >
> > On 3/19/2026 7:35 AM, Antheas Kapenekakis wrote:
> > > On Tue, 17 Mar 2026 at 16:13, Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >>
> > >>
> > >> On 3/17/26 07:09, Rafael J. Wysocki wrote:
> > >>> On Tue, Mar 17, 2026 at 12:57=E2=80=AFPM Dmitry Osipenko
> > >>> <dmitry.osipenko@collabora.com> wrote:
> > >>>>
> > >>>> On 3/16/26 22:52, Antheas Kapenekakis wrote:
> > >>>>>> So in accordance with the above, /sys/power/standby is not a ver=
y
> > >>>>>> fortunate choice of the name of this interface and I'm totally
> > >>>>>> unconvinced that it belongs to sys/power because its role is not
> > >>>>>> really power management (and it is ACPI-only for the time being)=
.
> > >>>>> Hm, most of the changes / implementation resides in the pm subsys=
tem
> > >>>>> and it is related to the s2idle suspend flow.
> > >>>>>
> > >>>>> I assume that when it stops being ACPI only provided we reach a d=
esign
> > >>>>> that allows for that, the related callbacks would also nest in pm=
 ops.
> > >>>>>
> > >>>>> Where could a more appropriate directory in sysfs be? I would sti=
ll
> > >>>>> tend towards /sys/power
> > >>>>
> > >>>> Question is whether anyone outside of ACPI will ever need the gene=
ric
> > >>>> interface. Making it generic based on guesswork could be a wasted =
effort
> > >>>> that Rafael and others will have to maintain. The mode file could =
go
> > >>>> under /sys/firmware/acpi if interface is made ACPI-specific.
> > >>>
> > >>> Well, experience shows that it may end up the other way around.
> > >>>
> > >>> People once thought that the platform profile interface would be
> > >>> ACPI-specific and we ended up having to extend it via
> > >>> platform_profile_class.
> > >>>
> > >>> I'm thinking that something similar may take place in this case.
> > >>> Platforms that don't use ACPI may also want to define platform
> > >>> triggers to somehow adjust platform settings and those may be
> > >>> different from "inactive" or "snooze".
> > >>>
> > >>
> > >> At which point you would almost wonder if this should be super gener=
al
> > >> like "foreground_workload_type".
> > >>
> > >> Then this could be expanded for other uses later such as full screen
> > >> video playback or full screen gaming.
> > >
> > > Mmm. This reminds me of AMD drm pp_power_profile_mode {BOOTUP_DEFAULT=
,
> > > 3D_FULL_SCREEN, POWER_SAVING, VIDEO, VR, COMPUTE, CUSTOM, WINDOW_3D,
> > > CAPPED, UNCAPPED}. I'm not sure anyone used it. I'd rather avoid the
> > > complexity.
> >
> > There are certainly people using it, but it's more common in embedded
> > applications than traditional desktop distros.
> >
> > It is not a perfect match to this concept, but definitely some parallel=
s
> > can be drawn.
> >
> > There are general things that might make sense if you know what the
> > foreground workload is or the display is off.
>
> Hm, yeah I guess so. I could see this ABI being also useful for
> embedded devices to control their appearance. There's precedent with
> e.g., charging_behaviour having dozens of device specific values,
> where standard and longevity are the only ones used in laptops.
>
> > >
> > >> There could be hooks for scheduler too in the future from this hint =
too
> > >> then.
> > >
> > > Wouldn't it be better to defer to userspace? I'm not sure this would
> > > have a meaningful difference in any case.
> >
> > I don't know one way or the other.  It would need to be prototyped to
> > see what it actually looked like.  In the line of thinking Rafael
> > mentioned that platform profile was ACPI and grew to a class I would
> > generally just keep the design from pigeon holing too much on display
> > off.  That's why I thought maybe foreground workload could potentially
> > work well.
>
> To go back to Rafael's suggestion of not using transitions for the
> ABI, it would be possible to push the transition logic down to the
> s2idle code and introduce a generic handler for it. SInce arbitrary
> transitions are possible under this spec, the top-level ABI
> implementation need not consider it.
>
> Since it is very similar to platform_profiles, it could also be
> potentially added there as activity_hint to the current
> platform_profiles implementation and mirror its conventions. This
> would avoid introducing new scaffolding.
>
> Then s2idle would register a platform profile handler without
> profiles, and instead only implement activity hint. Existing x86
> platform drivers could also trivially implement support for it as
> well. Although for WMI, the existing hooks for s2idle for Windows
> would handle most current drivers.
>
> An implementation for this would consist of two stages. First, the
> callbacks would be moved to the beginning so they can be tested
> independently. Then, platform_profile would be extended to support
> activity_hint with states {snooze, resuming, inactive, active}, and
> finally, s2idle would implement the handler with transition logic to
> make sure the callbacks get called correctly always, including when
> userspace ignores the file, where the full transition would occur in
> begin() and end().
>
> The legacy /sys/firmware/acpi/{activity_hint, activity_hint_choices}
> would mirror the current conventions, perhaps with a custom value as
> well.
>
> How does this approach sound?

Perhaps re-using platform_profiles is not wise, after all the
boilerplate would be small and bolting on new hooks would be around
the same amount of code. New implementation would be better. How would
that approach sound like.

> Antheas

