Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5263E9F7E
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690139; cv=none; b=URJ+6dLJdOlEkqchGUm6I86pevh6/goNwX+IjpSpWYVLzOkr3PnY/HQJo2laxBKMVGkSfaCtPOtqWAizBy6eVECUzce+jN84m0e2hCg4EUu1ytXsLcCQJQF2ALZ7V5X31BCWzZSKNCwyqJustxhgo4wJhmsHxf5itMOczwJobog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690139; c=relaxed/simple;
	bh=1lABtse7s9KMMowGqvmMlWn0+1/BYSz7xWXVRsuIimM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4ycTvtwgdQA44aH+qZw1+Ii/QjxaVqgWBMjpEb3D0bjjTqR1xYE3/xsH6yFViNqKkO/8ZCGHkGhIUd1HyjBZtKG86IVThrjRm6JzxeLC89CyCZDJWwZ1q49/VutJo+FVOnXB4HjOu3tHMSASiN5kgv00OwtD/ZK3kSMDpAUAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=WrwcamTJ; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="WrwcamTJ"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 11D0045DE9
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:36:20 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 2A3FF46519
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:36:19 +0200 (EET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 313EC201E37
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:36:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773689778;
	bh=1lABtse7s9KMMowGqvmMlWn0+1/BYSz7xWXVRsuIimM=;
	h=Received:From:Subject:To;
	b=WrwcamTJFMS5jtle4tzQsnMm1sv6zTKAzJtBMymCTPl8+oDv4p2ryR2c5k6NzFZXb
	 5s0Lsc8p33ZDYvDYKO5gBeydHx13iLHpwyozjELOKcwMYogFRk8CJByQ/AQH4lEKJu
	 v67CFhZeVpHBnjB/fIYyFQORr2yoSD/LgQfqz4mv3rWxjn9kLIDgy5Mfo9VTjm/TTu
	 L8Pq78KZXLafQraJr2wq4BoKbbeRgSmX5lkK3zW9Oz0wp4DJg9e97NSFD4b6z/LCvD
	 dOZ9r27OXcM1pYYELQ5ucZhPXBpYnekK5sQA3KQe6aNaWNV3lDQ2j4M1yzRvO5AZ0d
	 BbT7Ylc8WVRgQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f182.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-829ac8d56c5so4859783b3a.3
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 12:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU6R2/laMcEK5KnIHcYzzLhnDIfjVhODOrmshrNcGzqcATx00z7AdrFp6qMED4/TUeTVOT5x576xMxy@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJ8Jbkt7s6tXqfxhsWA7qi6pMwWyf5saSeYmsH089NsE53i7j
	3swgISO0IhsJnP0ISh+cqDUcg+jjjFC7nelW9zieOSo525RoU0/tjjE8nxltUBk3p+ssq/5RJn+
	z9HQPjpCUZHQzxj5/VaCVdBWfE3Htkks=
X-Received: by 2002:a05:6a00:a04:b0:81f:994f:cb with SMTP id
 d2e1a72fcca58-82a19716f8fmr13434353b3a.24.1773689775741; Mon, 16 Mar 2026
 12:36:15 -0700 (PDT)
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
 <CAGwozwGc0YsU_aW4Yk7g3B8LCGvXPoXg=NVkJPXxfPekxq7p1A@mail.gmail.com>
In-Reply-To: 
 <CAGwozwGc0YsU_aW4Yk7g3B8LCGvXPoXg=NVkJPXxfPekxq7p1A@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 20:36:03 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE2F53Kz71-1Sub9RuDc=df9KPAo-i63hZ6sO4=C0tDpg@mail.gmail.com>
X-Gm-Features: AaiRm52RQlnkqUbx4RcM8PnNnpsTLUGTMrMyE0V5_ikz9Vf9_vRswK6hAMPa79g
Message-ID: 
 <CAGwozwE2F53Kz71-1Sub9RuDc=df9KPAo-i63hZ6sO4=C0tDpg@mail.gmail.com>
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
 <177368977772.3088345.8064431720440429591@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 16 Mar 2026 at 20:33, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Mon, 16 Mar 2026 at 20:03, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> >
> > Hi Antheas,
> >
> > On 1/15/26 10:49, Antheas Kapenekakis wrote:
> > > On Thu, 15 Jan 2026 at 01:07, Dmitry Osipenko
> > > <dmitry.osipenko@collabora.com> wrote:
> > >>
> > >> On 1/13/26 13:11, Antheas Kapenekakis wrote:
> > >>> <snip>
> > >
> > > Hi Dmitry,
> > > let me go inline.
> > >
> > >> The primary goal is to support screen-off DSM for a power-efficient
> > >> background games downloading [1] and further resume-to-dark on Steam
> > >> Deck and other handhelds. There is no strict timeline, usual "sooner the
> > >> better". Downstreams will use customized WIP solution till upstream will
> > >> get necessary generic interfaces.
> > >>
> > >> [1] https://store.steampowered.com/news/app/1675200/view/771930569635267984
> > >
> > > Ok, this makes things clearer. I had done some testing to see the
> > > viability of such approach.
> > >
> > > One big problem [1] had was that the compression algorithm that Steam
> > > used was very CPU intensive. However, it was announced that that
> > > changed, which makes low power downloads more viable.
> > >
> > > However, even so, I do not think the sleep DSM is designed for
> > > prolonged background use and certain devices might overheat.
> > > Specifically, I think the Go S disables its fan while in that DSM.
> > > Looking back to what Windows does, it only uses the Sleep state to do
> > > periodic polling, and if there are updates it transitions to display
> > > off.
> > >
> > > This is a fair approach for [1]. For example, device wakes up every
> > > two hours while connected to a charger, stays on sleep state, checks
> > > for updates, and if there are any and conditions are met, transitions
> > > to display off and starts downloading.
> > >
> > > However, this means you do not get a smaller tdp limit. Given you
> > > control the unfrozen userspace in that state though, such a limit does
> > > not help either. The device will use what it needs to for downloads.
> > > This makes the SD 5W low power mode puzzling, as it means downloads
> > > will potentially take longer and I would be punished as a user for
> > > using that mode. Instead, Steam should be optimized to use less than
> > > 5W or perhaps 10W when downloading from gigabit in some way.
> > >
> > > Two more considerations in this case are that a lot of devices will
> > > turn off their controllers when entering display off. And the rest
> > > when entering sleep. This is good because when you are in dark resume,
> > > the RGB of the device has turned off. But for [1] it is problematic
> > > because it assumes the controller works and is what is used to wake
> > > the device so the mode is broken. For Legion, Sleep is used to turn
> > > off the controller, and for other devices Sleep Entry/Exit. New in ROG
> > > Xbox Ally devices is that the controller no longer turns off, but it
> > > is muted.
> > >
> > > The other consideration is that three additional patches are needed
> > > for ROG Ally devices to work correctly with this series, 2 cleanup
> > > commits and 1 small delay. But after that it should be drop in. I
> > > cannot comment on the new hid drivers for Asus and Legion that are
> > > currently being developed. Particularly, hid-legion-go(?) has a
> > > reset_resume() cb where it should have used resume? Or not anything?
> > > The legion controllers save os mode until they disconnect, which they
> > > do with this series, so the driver would always re-initialize on
> > > wake-up.
> >
> > My rough understanding that a firmware/BIOS update may be needed for
> > some devices to leverage DSM in regards to power consumption
> > improvement. Could be true that practically it may not improve much,
> > will see. Even if not all current devices will benefit from the
> > screen-off DSM, it may differ for a later generations.
>
> Hi Dmitry,
> sorry, I have been busy the past few days. I read through Rafael's
> comments, I will respond to them in the next 2-3 days.
>
> Your understanding is correct. You will see 0 performance difference
> with the screen off DSM. It is not supposed to affect the thermal
> envelope. Turning off the screens of your laptop due to inactivity is
> not supposed to affect the thermal envelope.
>
> For devices that use the DSM to turn off their controller (~60%),
> there might be a marginal <.5W improvement. The rest use the sleep
> DSMs for that. Those do affect the thermal envelope. However, they are
> not designed for prolonged CPU intensive tasks such as a SteamOS
> download mode. This is the bigger concern. From my experience, I
> expect the Go S to overheat.
>
> The improvement because of turning off the controllers / RGB is
> something that is needed for download mode in any case. And as my
> previous comment suggests, lowering the thermal limit may not be
> required / advantageous.

Here, the sleep dsms are also important, because of their broad
effects to power light / thermal envelope. As they can be used for
brief wake / update checks. For battery powered devices, perhaps these
are not important (excl. hibernation checks), but for desktop consoles
it is expected functionality.

> > >> A common approach for upstreaming is to divide problem into smaller
> > >> manageable parts. That's what I'm planning to focus on now to see if we
> > >> can start easy with a minimal changes.
> > >
> > > Sure. One potential approach for this is this series, where the first
> > > part does the plumbing and the second part the exposing. They can be
> > > merged independently.
> > >
> > > I also made sure to address Rafael's comments, so the ABI of this
> > > series is completely independent of ACPI, S0ix or whether the device
> > > has a display. I also removed all references to Intel, AMD specific
> > > power envelope terminology. Moreover, most of the logic now resides in
> > > suspend.c and the hooks are in platform_ calls, so it can be
> > > implemented for other platforms easily.
> > >
> > > However, the first part of this series does some refactorings which
> > > assume a favorable outcome. If we do not want to assume that, a
> > > simpler initial series would just move the MS/display on/off DSMs to
> > > .begin() in s2idle.c. If you think that would be easier to merge, you
> > > are welcome to start with that. Then this series would be refactored
> > > on top and merged as a single unit. Keep in mind the ROG Ally conflict
> > > would also arise in this case as well.
> > >
> > >> Please don't worry about the credit. You did a significant ground work
> > >> that is well recognized by now. Thanks a lot for your efforts and help.
> > >> Starting from scratch of course won't be a good approach with all the
> > >> broad testing you've done.
> > >
> > > Great. Sounds good to me.
> >
> > I'm taking latest version of your patches and will update them in
> > accordance to the review from Rafael.
>
> Rafael raised some good questions I need to respond to. Specifically,
> the ABI is not yet decided, so the comments are not ready to address
> yet.
>
> Nonetheless, this series is ready to test with the current ABI.
>
> Moreover, Rafael suggests for upstreaming to follow essentially what I
> outlined. An initial series should move the DSMs to the beginning of
> the suspend sequence, and the follow-up would implement the ABI.
>
> I was planning to work on the first sub-series as a non-RFC after
> responding to Rafael's comments. Let me know how you plan to proceed.
>
> Best,
> Antheas
>
> > --
> > Best regards,
> > Dmitry
> >

