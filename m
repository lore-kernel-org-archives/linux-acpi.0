Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF73E717E
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689626; cv=none; b=AGucCiIjp/ucBxV+UDPUBPNi1eXBAYMqb6/PCZ5xqfYOeOMOvvoFCzPN3WgP7nN8HPvPu8urc0f1KKHn970ImK7a7cWErjGu3d1CV9Oyn/HagbEDDshWvrgRi10JGU5HxfqP88y+RehLcLY6jLTq5YIYN6FfPfNUpbVmU4618zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689626; c=relaxed/simple;
	bh=z+1ufl/d0OXO+iVoi6wO9s25oHiAPcswGI7rFejJvc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBx6hLQU/jxVG4xCpq+OHP/7JLBsjXLOfF5Y5P67V4VMqVy/Y5d9s07y8fUWO8YJOgppVa2psJ5A9FcDITXzVwUgUJwtYO+gZ9KXdyKEYr/y/B5CtW8xf5xIGfQK6OUuiSqYPkd1yPP9QT1CibBouuRl/7hiz4mz8nGzyAYXS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=en4gdC+4; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="en4gdC+4"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id C16DB40947
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 19:33:35 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id ADC5B4078C
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 19:33:34 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CFF3420235A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:33:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773689614;
	bh=z+1ufl/d0OXO+iVoi6wO9s25oHiAPcswGI7rFejJvc8=;
	h=Received:From:Subject:To;
	b=en4gdC+4czJiJKGmxK0e+SQwf9xNkBvrkVW0O76J9xxevM7F6Rfp1YEgyli0aIpJt
	 iVvfIKq0weeZY//mSjINIC8PONz7AvKUoJb7tNSzhR++b8hryunMaW9llGFWbe/gB6
	 jaavC/DuC2SyQYB8KYvmn2dT0haJBTptktKe0S0aFq58zW3ynufbLA5AmcMOrpp1te
	 08/EHSgrFtPRWmSpH0prmE81oFm/WNXm6nYh8hNyjMlDl96IagA9UeeSCJyAoDMsKZ
	 StQL0hpZRC112hGmAYw/E+ySoL/7IEqNlo0uQ5osFNLBsjshPKAUaj8gcKVl48OR6P
	 agpY5OzK4kgIQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f173.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c73a12af63cso3055937a12.0
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 12:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWRb2ypzYy8+fVtGQ9Kc7mto4wqEygKDdX4gyg6BnePlktsVw4vuycMEtpybMmgEW8dnM4QS71jIsOF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Ec28bUMWp0yFglLaHUEgQ44iKY8sk9sEdzCdjUwnsTbESYcg
	9Zq+B6Fqh1+1DFn3XeEAzg9SvXTdPjrNlYD63j7hR7RpIQQpd6WdhywTGvZzaaTWNJ6IdJ7zTui
	v/doDA5RsFHwxRFEHgDJubgefu4Uq9YQ=
X-Received: by 2002:a05:6a21:69c:b0:398:9d5f:e091 with SMTP id
 adf61e73a8af0-398ecacad3fmr13788189637.26.1773689612122; Mon, 16 Mar 2026
 12:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
 <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
 <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
 <ab4d90d8-3212-4571-9f92-ac4facd3aa33@collabora.com>
 <CAGwozwF7aVapmRYczm+=rPfVDXH0i6UArQtg1TRgc7Vi6+XYxA@mail.gmail.com>
 <5202766b-0bc2-4d0a-90af-977dcb81e66f@collabora.com>
In-Reply-To: <5202766b-0bc2-4d0a-90af-977dcb81e66f@collabora.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 20:33:20 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGc0YsU_aW4Yk7g3B8LCGvXPoXg=NVkJPXxfPekxq7p1A@mail.gmail.com>
X-Gm-Features: AaiRm53vSH-CVScJioVgzkjcIMSap14aPYfesC0uP1anAaEcf56H0A34r6MF7xE
Message-ID: 
 <CAGwozwGc0YsU_aW4Yk7g3B8LCGvXPoXg=NVkJPXxfPekxq7p1A@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
	superm1@kernel.org, systemd-devel@lists.freedesktop.org,
 xaver.hugl@gmail.com,
	John Schoenick <johns@valvesoftware.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177368961413.3075338.17718284492288116779@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 16 Mar 2026 at 20:03, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi Antheas,
>
> On 1/15/26 10:49, Antheas Kapenekakis wrote:
> > On Thu, 15 Jan 2026 at 01:07, Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 1/13/26 13:11, Antheas Kapenekakis wrote:
> >>> <snip>
> >
> > Hi Dmitry,
> > let me go inline.
> >
> >> The primary goal is to support screen-off DSM for a power-efficient
> >> background games downloading [1] and further resume-to-dark on Steam
> >> Deck and other handhelds. There is no strict timeline, usual "sooner the
> >> better". Downstreams will use customized WIP solution till upstream will
> >> get necessary generic interfaces.
> >>
> >> [1] https://store.steampowered.com/news/app/1675200/view/771930569635267984
> >
> > Ok, this makes things clearer. I had done some testing to see the
> > viability of such approach.
> >
> > One big problem [1] had was that the compression algorithm that Steam
> > used was very CPU intensive. However, it was announced that that
> > changed, which makes low power downloads more viable.
> >
> > However, even so, I do not think the sleep DSM is designed for
> > prolonged background use and certain devices might overheat.
> > Specifically, I think the Go S disables its fan while in that DSM.
> > Looking back to what Windows does, it only uses the Sleep state to do
> > periodic polling, and if there are updates it transitions to display
> > off.
> >
> > This is a fair approach for [1]. For example, device wakes up every
> > two hours while connected to a charger, stays on sleep state, checks
> > for updates, and if there are any and conditions are met, transitions
> > to display off and starts downloading.
> >
> > However, this means you do not get a smaller tdp limit. Given you
> > control the unfrozen userspace in that state though, such a limit does
> > not help either. The device will use what it needs to for downloads.
> > This makes the SD 5W low power mode puzzling, as it means downloads
> > will potentially take longer and I would be punished as a user for
> > using that mode. Instead, Steam should be optimized to use less than
> > 5W or perhaps 10W when downloading from gigabit in some way.
> >
> > Two more considerations in this case are that a lot of devices will
> > turn off their controllers when entering display off. And the rest
> > when entering sleep. This is good because when you are in dark resume,
> > the RGB of the device has turned off. But for [1] it is problematic
> > because it assumes the controller works and is what is used to wake
> > the device so the mode is broken. For Legion, Sleep is used to turn
> > off the controller, and for other devices Sleep Entry/Exit. New in ROG
> > Xbox Ally devices is that the controller no longer turns off, but it
> > is muted.
> >
> > The other consideration is that three additional patches are needed
> > for ROG Ally devices to work correctly with this series, 2 cleanup
> > commits and 1 small delay. But after that it should be drop in. I
> > cannot comment on the new hid drivers for Asus and Legion that are
> > currently being developed. Particularly, hid-legion-go(?) has a
> > reset_resume() cb where it should have used resume? Or not anything?
> > The legion controllers save os mode until they disconnect, which they
> > do with this series, so the driver would always re-initialize on
> > wake-up.
>
> My rough understanding that a firmware/BIOS update may be needed for
> some devices to leverage DSM in regards to power consumption
> improvement. Could be true that practically it may not improve much,
> will see. Even if not all current devices will benefit from the
> screen-off DSM, it may differ for a later generations.

Hi Dmitry,
sorry, I have been busy the past few days. I read through Rafael's
comments, I will respond to them in the next 2-3 days.

Your understanding is correct. You will see 0 performance difference
with the screen off DSM. It is not supposed to affect the thermal
envelope. Turning off the screens of your laptop due to inactivity is
not supposed to affect the thermal envelope.

For devices that use the DSM to turn off their controller (~60%),
there might be a marginal <.5W improvement. The rest use the sleep
DSMs for that. Those do affect the thermal envelope. However, they are
not designed for prolonged CPU intensive tasks such as a SteamOS
download mode. This is the bigger concern. From my experience, I
expect the Go S to overheat.

The improvement because of turning off the controllers / RGB is
something that is needed for download mode in any case. And as my
previous comment suggests, lowering the thermal limit may not be
required / advantageous.

> >> A common approach for upstreaming is to divide problem into smaller
> >> manageable parts. That's what I'm planning to focus on now to see if we
> >> can start easy with a minimal changes.
> >
> > Sure. One potential approach for this is this series, where the first
> > part does the plumbing and the second part the exposing. They can be
> > merged independently.
> >
> > I also made sure to address Rafael's comments, so the ABI of this
> > series is completely independent of ACPI, S0ix or whether the device
> > has a display. I also removed all references to Intel, AMD specific
> > power envelope terminology. Moreover, most of the logic now resides in
> > suspend.c and the hooks are in platform_ calls, so it can be
> > implemented for other platforms easily.
> >
> > However, the first part of this series does some refactorings which
> > assume a favorable outcome. If we do not want to assume that, a
> > simpler initial series would just move the MS/display on/off DSMs to
> > .begin() in s2idle.c. If you think that would be easier to merge, you
> > are welcome to start with that. Then this series would be refactored
> > on top and merged as a single unit. Keep in mind the ROG Ally conflict
> > would also arise in this case as well.
> >
> >> Please don't worry about the credit. You did a significant ground work
> >> that is well recognized by now. Thanks a lot for your efforts and help.
> >> Starting from scratch of course won't be a good approach with all the
> >> broad testing you've done.
> >
> > Great. Sounds good to me.
>
> I'm taking latest version of your patches and will update them in
> accordance to the review from Rafael.

Rafael raised some good questions I need to respond to. Specifically,
the ABI is not yet decided, so the comments are not ready to address
yet.

Nonetheless, this series is ready to test with the current ABI.

Moreover, Rafael suggests for upstreaming to follow essentially what I
outlined. An initial series should move the DSMs to the beginning of
the suspend sequence, and the follow-up would implement the ABI.

I was planning to work on the first sub-series as a non-RFC after
responding to Rafael's comments. Let me know how you plan to proceed.

Best,
Antheas

> --
> Best regards,
> Dmitry
>

