Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1634EEE1
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047773; cv=none; b=ZWCjUlK6O1lkZq+JVoOX03g5jkXjb3XUZyc4Y6Y+3ctcMQXey9V+MEeOgQkMJ3iq/nkOAfkBghc5cJDoebuWwjAeY2j1ac+Yc5HUZJSjWO4sr+z/l+09c+7CT/Qz4/RnjiMaizrCW4v8GBgzXY0TrEjsv0ICbfzMkPxY8aavAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047773; c=relaxed/simple;
	bh=7lCqPTyX3iv6sDIuRx3HIZZ5WkVk7hxvg0ZytOQx9oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+E3O6wdCFkRWSnAGEh5u29s7wP/lhidixfTxKppJVO/MfEUAA7d7qnw0VL2PuEWJlE9JH92L0Y2Mm3nCYOfreBq6Id0aGk9WrxFeLLn/0Ev97am43R6MSgCoYluwjOzVZGXvQx7IvJUNDMyW4es3idK16P13f4qGimqr8MSs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HZhLZuUS; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HZhLZuUS"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 3479F4091B
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 16:13:29 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id 5BC74402D4
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 16:13:26 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 395D61FD237
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 19:13:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777047205;
	bh=+W5GKpK8E424b80bGfSpg0WI4sX0F/vi3iKHDP2s+Hg=;
	h=Received:From:Subject:To;
	b=HZhLZuUSTFIFFbAqMZ8tywXM14FBirW+lsO2qCVOQKTiaDReXNJ/+BOGml7xzhE7n
	 CWQYLsJj3mIX2PgKSx8FAn37aLOwSIWwfUKv0sXo11JHD131SInv3DtcNAEI57W3Jd
	 /UgPMt+bJ4TkoYLXYnV3FEWPDgplym+R/lo/P+VqD/wAA/gKrGIlj+S+xWIkn7mD2A
	 EbGAclZKDGKBmkkMnzQyJ3AoqgfJJA3ukgJvmOaq96nYgvxtzAoKYbWUNJ5J5wgbVQ
	 p739OZIfjus5eHIXx6AMXZTltz4PiPpwKskQp1Rfre4FS//s9lrqUAaNLZ7xY4lTVJ
	 bXOkJsC/E6tbw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c795a47186bso3449459a12.0
        for <linux-acpi@vger.kernel.org>;
 Fri, 24 Apr 2026 09:13:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9+zMJmIMXL9kuQ6i7Iie1y7XyeQ/jIql/jZmDbzL1qIHAm4duhiFg9H9sMo40p0Y8WuUKDomHNWxwZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCIRKc9m1JYC5FBd+10XLfXXZPS6WSygPuKMYZZ7SrcLXMJ+B
	oT8mRu9Q5T8dqGRX7S2g7VtjNA17F8FmbD+1W1ORilz6XCfS2d/+Qp7spg/fZR6/V8vZPIP0Y2F
	FI5hpXxeoAGZTT1h3q7OKqm5vl7xYpAw=
X-Received: by 2002:a05:6a20:4305:b0:3a1:785:a567 with SMTP id
 adf61e73a8af0-3a10785bc50mr23183685637.26.1777047203664; Fri, 24 Apr 2026
 09:13:23 -0700 (PDT)
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
 <CAGwozwE2F53Kz71-1Sub9RuDc=df9KPAo-i63hZ6sO4=C0tDpg@mail.gmail.com>
 <9603d545-9def-498d-bf05-c15b855b3d3b@collabora.com>
 <d3598ba5-2de7-42f7-963f-a500597c8a88@collabora.com>
 <CAGwozwFHza2ddpPQsXOJO1KyHLGHLhMpM+CxDfLS3X2xARS0fg@mail.gmail.com>
 <CAGwozwFrCMQE3SDa1eSdQpU0jzNNW69VSBO-dPub21zKNq5P3w@mail.gmail.com>
 <00d8b84f-1cbc-4540-948f-40ee21049c8b@collabora.com>
 <6fca0c00-14c2-48f3-8112-5b765d5057e9@kernel.org>
In-Reply-To: <6fca0c00-14c2-48f3-8112-5b765d5057e9@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Apr 2026 18:13:10 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGmZbZwF3CRiR=wWoXE_PBFALY4G7MKqEdFourQrNJwLA@mail.gmail.com>
X-Gm-Features: AQROBzDHmGyKNd-sDpZrYKQyirZeScdm6z0W8T5h3OaEjlUgjOQGdQl5H1-nvmU
Message-ID: 
 <CAGwozwGmZbZwF3CRiR=wWoXE_PBFALY4G7MKqEdFourQrNJwLA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Mario Limonciello <superm1@kernel.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org,
	richard@hughsie.com, sebastian.reichel@collabora.com,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com,
	John Schoenick <johns@valvesoftware.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177704720573.203346.5655288483846705805@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 24 Apr 2026 at 15:48, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 4/23/26 20:35, Dmitry Osipenko wrote:
> > On 4/22/26 11:58, Antheas Kapenekakis wrote:
> >> On Wed, 22 Apr 2026 at 10:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >>>
> >>> On Wed, 22 Apr 2026 at 02:56, Dmitry Osipenko
> >>> <dmitry.osipenko@collabora.com> wrote:
> >>>>
> >>>> Hi, Antheas
> >>>>
> >>>> On 3/17/26 14:04, Dmitry Osipenko wrote:
> >>>>> On 3/16/26 22:36, Antheas Kapenekakis wrote:
> >>>>>> On Mon, 16 Mar 2026 at 20:33, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >>>>>>>
> >>>>>>> On Mon, 16 Mar 2026 at 20:03, Dmitry Osipenko
> >>>>>>> <dmitry.osipenko@collabora.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi Antheas,
> >>>>>>>>
> >>>>>>>> On 1/15/26 10:49, Antheas Kapenekakis wrote:
> >>>>>>>>> On Thu, 15 Jan 2026 at 01:07, Dmitry Osipenko
> >>>>>>>>> <dmitry.osipenko@collabora.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 1/13/26 13:11, Antheas Kapenekakis wrote:
> >>>>>>>>>>> <snip>
> >>>>>>>>>
> >>>>>>>>> Hi Dmitry,
> >>>>>>>>> let me go inline.
> >>>>>>>>>
> >>>>>>>>>> The primary goal is to support screen-off DSM for a power-efficient
> >>>>>>>>>> background games downloading [1] and further resume-to-dark on Steam
> >>>>>>>>>> Deck and other handhelds. There is no strict timeline, usual "sooner the
> >>>>>>>>>> better". Downstreams will use customized WIP solution till upstream will
> >>>>>>>>>> get necessary generic interfaces.
> >>>>>>>>>>
> >>>>>>>>>> [1] https://store.steampowered.com/news/app/1675200/view/771930569635267984
> >>>>>>>>>
> >>>>>>>>> Ok, this makes things clearer. I had done some testing to see the
> >>>>>>>>> viability of such approach.
> >>>>>>>>>
> >>>>>>>>> One big problem [1] had was that the compression algorithm that Steam
> >>>>>>>>> used was very CPU intensive. However, it was announced that that
> >>>>>>>>> changed, which makes low power downloads more viable.
> >>>>>>>>>
> >>>>>>>>> However, even so, I do not think the sleep DSM is designed for
> >>>>>>>>> prolonged background use and certain devices might overheat.
> >>>>>>>>> Specifically, I think the Go S disables its fan while in that DSM.
> >>>>>>>>> Looking back to what Windows does, it only uses the Sleep state to do
> >>>>>>>>> periodic polling, and if there are updates it transitions to display
> >>>>>>>>> off.
> >>>>>>>>>
> >>>>>>>>> This is a fair approach for [1]. For example, device wakes up every
> >>>>>>>>> two hours while connected to a charger, stays on sleep state, checks
> >>>>>>>>> for updates, and if there are any and conditions are met, transitions
> >>>>>>>>> to display off and starts downloading.
> >>>>>>>>>
> >>>>>>>>> However, this means you do not get a smaller tdp limit. Given you
> >>>>>>>>> control the unfrozen userspace in that state though, such a limit does
> >>>>>>>>> not help either. The device will use what it needs to for downloads.
> >>>>>>>>> This makes the SD 5W low power mode puzzling, as it means downloads
> >>>>>>>>> will potentially take longer and I would be punished as a user for
> >>>>>>>>> using that mode. Instead, Steam should be optimized to use less than
> >>>>>>>>> 5W or perhaps 10W when downloading from gigabit in some way.
> >>>>>>>>>
> >>>>>>>>> Two more considerations in this case are that a lot of devices will
> >>>>>>>>> turn off their controllers when entering display off. And the rest
> >>>>>>>>> when entering sleep. This is good because when you are in dark resume,
> >>>>>>>>> the RGB of the device has turned off. But for [1] it is problematic
> >>>>>>>>> because it assumes the controller works and is what is used to wake
> >>>>>>>>> the device so the mode is broken. For Legion, Sleep is used to turn
> >>>>>>>>> off the controller, and for other devices Sleep Entry/Exit. New in ROG
> >>>>>>>>> Xbox Ally devices is that the controller no longer turns off, but it
> >>>>>>>>> is muted.
> >>>>>>>>>
> >>>>>>>>> The other consideration is that three additional patches are needed
> >>>>>>>>> for ROG Ally devices to work correctly with this series, 2 cleanup
> >>>>>>>>> commits and 1 small delay. But after that it should be drop in. I
> >>>>>>>>> cannot comment on the new hid drivers for Asus and Legion that are
> >>>>>>>>> currently being developed. Particularly, hid-legion-go(?) has a
> >>>>>>>>> reset_resume() cb where it should have used resume? Or not anything?
> >>>>>>>>> The legion controllers save os mode until they disconnect, which they
> >>>>>>>>> do with this series, so the driver would always re-initialize on
> >>>>>>>>> wake-up.
> >>>>>>>>
> >>>>>>>> My rough understanding that a firmware/BIOS update may be needed for
> >>>>>>>> some devices to leverage DSM in regards to power consumption
> >>>>>>>> improvement. Could be true that practically it may not improve much,
> >>>>>>>> will see. Even if not all current devices will benefit from the
> >>>>>>>> screen-off DSM, it may differ for a later generations.
> >>>>>>>
> >>>>>>> Hi Dmitry,
> >>>>>>> sorry, I have been busy the past few days. I read through Rafael's
> >>>>>>> comments, I will respond to them in the next 2-3 days.
> >>>>>>>
> >>>>>>> Your understanding is correct. You will see 0 performance difference
> >>>>>>> with the screen off DSM. It is not supposed to affect the thermal
> >>>>>>> envelope. Turning off the screens of your laptop due to inactivity is
> >>>>>>> not supposed to affect the thermal envelope.
> >>>>>>>
> >>>>>>> For devices that use the DSM to turn off their controller (~60%),
> >>>>>>> there might be a marginal <.5W improvement. The rest use the sleep
> >>>>>>> DSMs for that. Those do affect the thermal envelope. However, they are
> >>>>>>> not designed for prolonged CPU intensive tasks such as a SteamOS
> >>>>>>> download mode. This is the bigger concern. From my experience, I
> >>>>>>> expect the Go S to overheat.
> >>>>>>>
> >>>>>>> The improvement because of turning off the controllers / RGB is
> >>>>>>> something that is needed for download mode in any case. And as my
> >>>>>>> previous comment suggests, lowering the thermal limit may not be
> >>>>>>> required / advantageous.
> >>>>>>
> >>>>>> Here, the sleep dsms are also important, because of their broad
> >>>>>> effects to power light / thermal envelope. As they can be used for
> >>>>>> brief wake / update checks. For battery powered devices, perhaps these
> >>>>>> are not important (excl. hibernation checks), but for desktop consoles
> >>>>>> it is expected functionality.
> >>>>>>
> >>>>>>>>>> A common approach for upstreaming is to divide problem into smaller
> >>>>>>>>>> manageable parts. That's what I'm planning to focus on now to see if we
> >>>>>>>>>> can start easy with a minimal changes.
> >>>>>>>>>
> >>>>>>>>> Sure. One potential approach for this is this series, where the first
> >>>>>>>>> part does the plumbing and the second part the exposing. They can be
> >>>>>>>>> merged independently.
> >>>>>>>>>
> >>>>>>>>> I also made sure to address Rafael's comments, so the ABI of this
> >>>>>>>>> series is completely independent of ACPI, S0ix or whether the device
> >>>>>>>>> has a display. I also removed all references to Intel, AMD specific
> >>>>>>>>> power envelope terminology. Moreover, most of the logic now resides in
> >>>>>>>>> suspend.c and the hooks are in platform_ calls, so it can be
> >>>>>>>>> implemented for other platforms easily.
> >>>>>>>>>
> >>>>>>>>> However, the first part of this series does some refactorings which
> >>>>>>>>> assume a favorable outcome. If we do not want to assume that, a
> >>>>>>>>> simpler initial series would just move the MS/display on/off DSMs to
> >>>>>>>>> .begin() in s2idle.c. If you think that would be easier to merge, you
> >>>>>>>>> are welcome to start with that. Then this series would be refactored
> >>>>>>>>> on top and merged as a single unit. Keep in mind the ROG Ally conflict
> >>>>>>>>> would also arise in this case as well.
> >>>>>>>>>
> >>>>>>>>>> Please don't worry about the credit. You did a significant ground work
> >>>>>>>>>> that is well recognized by now. Thanks a lot for your efforts and help.
> >>>>>>>>>> Starting from scratch of course won't be a good approach with all the
> >>>>>>>>>> broad testing you've done.
> >>>>>>>>>
> >>>>>>>>> Great. Sounds good to me.
> >>>>>>>>
> >>>>>>>> I'm taking latest version of your patches and will update them in
> >>>>>>>> accordance to the review from Rafael.
> >>>>>>>
> >>>>>>> Rafael raised some good questions I need to respond to. Specifically,
> >>>>>>> the ABI is not yet decided, so the comments are not ready to address
> >>>>>>> yet.
> >>>>>>>
> >>>>>>> Nonetheless, this series is ready to test with the current ABI.
> >>>>>>>
> >>>>>>> Moreover, Rafael suggests for upstreaming to follow essentially what I
> >>>>>>> outlined. An initial series should move the DSMs to the beginning of
> >>>>>>> the suspend sequence, and the follow-up would implement the ABI.
> >>>>>>>
> >>>>>>> I was planning to work on the first sub-series as a non-RFC after
> >>>>>>> responding to Rafael's comments. Let me know how you plan to proceed.
> >>>>>
> >>>>> Please go on and make a v2. This version works well with my testing. Thanks!
> >>>>
> >>>> Do you have updates on v2? For now I don't have good suggestion on where
> >>>> to put and how to define standby knobs in sysfs in a more generic
> >>>> manner. Pick what feels better or keep current /sys/power variant with
> >>>> the rest of review comments addressed.
> >>>>
> >>>> Please let me know if help needed,
> >>>
> >>> Hi Dmitry,
> >>> I had some work pop up the past three weeks so I could not go ahead
> >>> with this. I will reprioritize and get back to you with an update by
> >>> end of week.
> >>>
> >>> Here is the current plan for V2. It will consist of four parts.
> >>>
> >>> i) We keep the initial rename patches.
> >>> ii) Then, we move all the calls to the begin() and end() functions.
> >>> After these, we perform a summary cleanup of asus-wmi and hid-asus to
> >>> undo the duplicate handling of the calls due to the prior sequence
> >>> causing issues on Ally devices, and add a small 500ms quirk after the
> >>> begin calls for these devices to resolve a timing issue present on all
> >>> firmwares (the Ally units have a hardcoded ~300ms delay in which they
> >>> fade their RGB before disconnecting the controller and saving its
> >>> state, causing it to reboot on resume if that does not happen; this is
> >>> common in all aura devices such as Asus Keyboards, but no other
> >>> devices cause issues due to the state loss).
> >>>
> >>> These first two parts can merge initially to ensure no issues arise.
> >>>
> >>> Then, we implement the activity API in two parts.
> >>>
> >>> iii) Introduce drivers/acpi/activity.c (match platform profile for
> >>> now), which has an ABI of
>
> If this ends up being the agreeable direction I don't see a reason to
> structure it in drivers/acpi initially in the first place.
>
> >>> /sys/class/activity/[driver_name]/{name,hint,hint_choices} (non-ACPI
> >>> specific). The ABI and activity.c do not perform state transitions,
> >>> match the platform_profile internal API structure, and are not ACPI
> >>> specific (the file can be moved later).
> >>
> >> I note here the use of [driver_name] instead of platform-profile-N,
> >> which should allow basic userspace apps to skip the loop and name
> >> check, hardcoding /sys/class/activity/s2idle/{hint,hint_choices}. In
> >> addition, prefixing the files with hint allows reusing the scaffolding
> >> to implement other ABIs in the future, which would be hard to do with
> >> platform-profile.
>
> Doesn't this imply the driver_name becomes part of the ABI itself?
> Couldn't userspace just read /sys/class/activity/0/name?
>
> The whole point of stable interfaces is to try to come up with something
> that would scale even for situations that don't make sense at the time.
>
> An unfortunate example we should avoid repeating is RAPL.
>
> It's named "intel-rapl" but there are MSRs on AMD SoC's that provide the
> same functionality.  Maybe at the time it made sense to keep 'intel' in
> the name as it was originally an Intel interface, but now any SoC that
> provides that kind of interface has that in the path name.

Hi,
I am currently 3/5 towards the V2, I'm figuring out where to put the
transition logic.

I made some changes since that proposal to make the ABI more generic.
Instead, it will be
/sys/class/hint/[driver_name]/{name,activity_choices,activity}. Hint
is a more generic name than activity, so then other hint types can be
added later. Also, I will place it under /drivers/base/hint.c so there
is no ACPI connection. It will use an empty tristate so that it turns
on automatically. Activity is optional and may not be provided, in
which case the files will be missing.

I wouldn't say that [driver_name] would be part of the ABI, since each
driver will get their own entry so generalized consumers would iterate
through the directory. I want to avoid the approach of using an ida
integer and having the directories shuffle during reboot or be hard to
navigate. Right now, if I am on a system with AMD PMF and e.g.
asus-wmi the fact the platform profile entries shuffle every time I
reboot makes it hard to script around and monitor the directories. But
I understand why that was done. The name file will be included so that
can be changed later.

Antheas

> >>
> >> For WMI drivers, [driver-name] would include an integer suffix as per
> >> convention for these drivers, with the first instance using 0.
> >>
> >>> iv) Register an activity handler in s2idle.c and push the transition
> >>> logic in it. This way, other users do not have to abide by it. If
> >>> userspace is not activity hint aware, enter the state snooze in
> >>> begin(), and restore the prior state in end(). If there is a timing
> >>> quirk (such as for the Ally), we will store the jiffies of the last
> >>> transition and compare them in begin(). This way, when userspace
> >>> becomes activity hint-aware and enters snooze prior to beginning the
> >>> suspend sequence, the delay is shortened. Since userspace freeze by
> >>> the systemd freezer group (if enabled) and then suspend.c require
> >>> around 100ms-300ms, this eats more than half of the delay in this case
> >>> for traditional resume / suspend, and eliminates it for dark screen
> >>> wakeups that remain in snooze.
> >
> > Thanks for the update. Will see what others will say about the activity
> > interface.
> >
>
>

