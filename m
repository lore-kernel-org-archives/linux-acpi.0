Received: from comms.kousu.ca (comms.kousu.ca [46.23.90.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE363264F2;
	Sat, 23 May 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.90.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502547; cv=none; b=YRcBIPUYbDrbiYtgiyr5F7JvTINbBggMWf1oXv7t5lYfVHCUpXy2RJIHxEEKMiztc+Xc4IGhRlW0cPx8oPlQbfqF1OCaOAsqupMBD/iMwkxP7+5Hl+3uw6nisoMgGneYx6Ktsao3rQbfbLDV34rBmg4nH+PZBrUcx+A13fZC3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502547; c=relaxed/simple;
	bh=o2uTSDpPiRcl+HiF6hm8XvO+iUPqIptMPSJOWQv4Ayo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ljHrrk85MCsVIHptQ4je/cksBKf8mHuEIxEf+JE+1u+DhD0++6oI8dEHCPpNwt6i2Zj25jZirVFMEG1GDLxIu2hngCQHPueVbXH10YEsAfZkZmGpqL33AhUp2pV5JJaKe/bFtVQmBKGUwgb/0Rjyu2Tj2txJnxUD3UO91WnW4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca; spf=pass smtp.mailfrom=kousu.ca; dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=0V1NfTES; dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=eAreaCP8; arc=none smtp.client-ip=46.23.90.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kousu.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="0V1NfTES";
	dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="eAreaCP8"
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=ed25519; bh=o2uTSDpP
	iRcl+HiF6hm8XvO+iUPqIptMPSJOWQv4Ayo=; h=references:in-reply-to:
	subject:cc:to:from:date; d=kousu.ca; b=0V1NfTESLpkHN6mmRef9w3bAqXAgPU3
	jKmm82gQbfiK+eZr0JJMSEhhRnCZi1mhNtb11VuC10sMda2qA0GibAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=rsa; bh=o2uTSDpPiRcl+HiF
	6hm8XvO+iUPqIptMPSJOWQv4Ayo=; h=references:in-reply-to:subject:cc:to:
	from:date; d=kousu.ca; b=eAreaCP87ziOwwCTO0tnbtbiBfmm+Yv1VSiJyawn2pwnn
	4n6mb4SfL5M8CNkrowqcjcMU5i2PTwPWq8DSgCQfhRhs3s9a265rl3bia6UllzRMw/b8z3
	JzYce6G1tdTHlCNbuP5zM/LbhWL1zSB6XHXyBXOpO4EYpTbafyHDseu2syeLWNZityBvIA
	5i8MSnODGn6GI9LJltl5FaTCRiwb30Fjd0ziJpQez8uBBoNQTJ/wJOQyv4HKsAxiz48NJL
	jcK3IrwoWTOt4nikJUiD3gMU9W9BAMe12IbaamK600WhE9RSzv7NKOB7fIxONn0Dw2mjAg
	EgeZvLP1JEhB2H3Ww==
Received: from ehlo.thunderbird.net (tsf-204-48-79-92.tsf.videotron.ca [204.48.79.92])
	by comms.kousu.ca (OpenSMTPD) with ESMTPSA id 9f6b5541 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 23 May 2026 04:15:36 +0200 (CEST)
Date: Sat, 23 May 2026 02:15:33 +0000
From: Nick <nick@kousu.ca>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/3=5D_ACPI=3A_button=3A_Enable_w?=
 =?US-ASCII?Q?akeup_GPEs_for_ACPI_buttons_at_probe_time?=
In-Reply-To: <9629117.CDJkKcVGEf@rafael.j.wysocki>
References: <2046403.PYKUYFuaPT@rafael.j.wysocki> <9629117.CDJkKcVGEf@rafael.j.wysocki>
Message-ID: <7B2E2495-8BE8-41F7-9432-F1775612337E@kousu.ca>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 22, 2026 2:52:10=E2=80=AFp=2Em=2E UTC, "Rafael J=2E Wysocki" <rafae=
l@kernel=2Eorg> wrote:
>From: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>
>Prior to commit 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake()
>for buttons"), ACPI button wakeup GPEs having handler methods remained
>enabled after acpi_wakeup_gpe_init(), but currently they are not enabled
>because acpi_setup_gpe_for_wake() disables them=2E
>
>That causes function keys to stop working on some systems [1] and there
>may be other related issues elsewhere=2E
>
>To address that, make the ACPI button driver enable wakeup GPEs for ACPI
>buttons so long as they have handler methods=2E  While this does not
>restore the old behavior exactly (the ACPI button driver needs to be
>bound to the button devices for the GPEs to be enabled), it should be
>sufficient to restore the missing functionality=2E
>
>For this purpose, introduce acpi_enable_gpe_cond() that enables
>a GPE if its dispatch type matches the supplied one and modify
>acpi_button_probe() to use that function for enabling the GPEs in
>question=2E
>
>Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for butto=
ns")
>Reported-by: Nick <nick@kousu=2Eca>
>Closes: https://lore=2Ekernel=2Eorg/linux-acpi/E2OXET=2E4X5GTP37VTNC3@kou=
su=2Eca/ [1]
>Signed-off-by: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>Cc: 7=2E0+ <stable@vger=2Ekernel=2Eorg> # 7=2E0+
>---
>
>v1 -> v2:
>   * Change the acpi_enable_gpe_cond() third parameter to a dispatch type=
 (or
>     "any type" value) and modify checks in it accordingly to address a
>     problem pointed out by sashiko=2Edev
>   * Adjust comments in acpi_enable_gpe_cond() and acpi_enable_gpe()
>   * Update the changelog
>
>@Nick, It would be good to test this version of the patch on your system
>because it is a bit different from the previous one (which was not entire=
ly
>correct)=2E  I'm not expecting it to behave differently, but additional
>testing would be welcome=2E
>


I tested this on top of 45255ea1ca096=2E The keys are still working as exp=
ected! I compared it against 6=2E19=2E14 too and all the keys seem to behav=
e as before=2E

I noticed one difference, but it might not be directly related: KEY_SLEEP =
takes significantly longer to trigger suspend on 7=2E1-rc4 than on 6=2E19=
=2E14=2E On the older version it suspends in about a second; on 7=2E1-rc4 i=
t takes about a minute before it fully suspends=2E The lid switch on the ot=
her hand suspends in about a second, and so does the suspend button in my D=
E, on both versions=2E I guess they're doing different kinds of suspend=2E =
That's probably related to the other ACPI changes that landed in 7=2E0=2E

Here's a log of me pressing the keys again: (we don't see KEY_SUSPEND here=
 because it triggers hiberation which I don't have set up so it just shuts =
down and I lose the log)

(Apologies if you got this twice, I managed to reset=2Emy mail client to H=
TML defaults while testing somehow)


$ uname -r
6=2E19=2E14-arch1-1
$ sudo libinput debug-events --show-keycodes
-event2   DEVICE_ADDED                 Power Button                      s=
eat0 default group1  cap:k
-event4   DEVICE_ADDED                 Video Bus                         s=
eat0 default group2  cap:k
-event1   DEVICE_ADDED                 Power Button                      s=
eat0 default group3  cap:k
-event0   DEVICE_ADDED                 Lid Switch                        s=
eat0 default group4  cap:S
-event5   DEVICE_ADDED                 Toshiba input device              s=
eat0 default group5  cap:k
-event12  DEVICE_ADDED                 Synaptics TM3322-002              s=
eat0 default group6  cap:pg  size 95x53mm tap (dl off) left scroll-nat scro=
ll-2fg-edge click-buttonareas-clickfinger dwt-on dwtp-on
-event3   DEVICE_ADDED                 AT Translated Set 2 keyboard      s=
eat0 default group7  cap:k
-event5   KEYBOARD_KEY                 +0=2E000s	KEY_MUTE (113) pressed
 event5   KEYBOARD_KEY                 +0=2E000s	KEY_MUTE (113) released
 event5   KEYBOARD_KEY                 +1=2E054s	KEY_MUTE (113) pressed
 event5   KEYBOARD_KEY                 +1=2E054s	KEY_MUTE (113) released
 event5   KEYBOARD_KEY                 +2=2E979s	KEY_COFFEE (152) pressed
 event5   KEYBOARD_KEY                 +2=2E979s	KEY_COFFEE (152) released
 event5   KEYBOARD_KEY                 +3=2E810s	KEY_COFFEE (152) pressed
 event5   KEYBOARD_KEY                 +3=2E810s	KEY_COFFEE (152) released
 event5   KEYBOARD_KEY                 +5=2E552s	KEY_BATTERY (236) pressed
 event5   KEYBOARD_KEY                 +5=2E552s	KEY_BATTERY (236) release=
d
 event5   KEYBOARD_KEY                 +6=2E180s	KEY_BATTERY (236) pressed
 event5   KEYBOARD_KEY                 +6=2E180s	KEY_BATTERY (236) release=
d
 event5   KEYBOARD_KEY                 +7=2E964s	KEY_SLEEP (142) pressed
 event5   KEYBOARD_KEY                 +7=2E964s	KEY_SLEEP (142) released
 event5   KEYBOARD_KEY                 +10=2E545s	KEY_UNKNOWN (240) presse=
d
 event5   KEYBOARD_KEY                 +10=2E545s	KEY_UNKNOWN (240) releas=
ed
-event1   KEYBOARD_KEY                 +10=2E598s	KEY_WAKEUP (143) pressed
 event1   KEYBOARD_KEY                 +10=2E598s	KEY_WAKEUP (143) release=
d
-event2   KEYBOARD_KEY                 +10=2E600s	KEY_WAKEUP (143) pressed
 event2   KEYBOARD_KEY                 +10=2E600s	KEY_WAKEUP (143) release=
d
-event5   KEYBOARD_KEY                 +20=2E312s	KEY_SWITCHVIDEOMODE (227=
) pressed
 event5   KEYBOARD_KEY                 +20=2E312s	KEY_SWITCHVIDEOMODE (227=
) released
 event5   KEYBOARD_KEY                 +20=2E981s	KEY_SWITCHVIDEOMODE (227=
) pressed
 event5   KEYBOARD_KEY                 +20=2E981s	KEY_SWITCHVIDEOMODE (227=
) released
 event5   KEYBOARD_KEY                 +21=2E467s	KEY_BRIGHTNESSDOWN (224)=
 pressed
 event5   KEYBOARD_KEY                 +21=2E467s	KEY_BRIGHTNESSDOWN (224)=
 released
 event5   KEYBOARD_KEY                 +22=2E034s	KEY_BRIGHTNESSDOWN (224)=
 pressed
 event5   KEYBOARD_KEY                 +22=2E034s	KEY_BRIGHTNESSDOWN (224)=
 released
 event5   KEYBOARD_KEY                 +22=2E420s	KEY_BRIGHTNESSUP (225) p=
ressed
 event5   KEYBOARD_KEY                 +22=2E420s	KEY_BRIGHTNESSUP (225) r=
eleased
 event5   KEYBOARD_KEY                 +22=2E845s	KEY_BRIGHTNESSUP (225) p=
ressed
 event5   KEYBOARD_KEY                 +22=2E845s	KEY_BRIGHTNESSUP (225) r=
eleased
 event5   KEYBOARD_KEY                 +23=2E757s	KEY_WLAN (238) pressed
 event5   KEYBOARD_KEY                 +23=2E757s	KEY_WLAN (238) released
 event5   KEYBOARD_KEY                 +24=2E953s	KEY_WLAN (238) pressed
 event5   KEYBOARD_KEY                 +24=2E953s	KEY_WLAN (238) released


$ uname -r
7=2E1=2E0-rc4-1-git-00393-g39551c4ef087
$ sudo libinput debug-events --show-keycodes
-event5   DEVICE_ADDED                 Toshiba input device              s=
eat0 default group1  cap:k
-event12  DEVICE_ADDED                 Synaptics TM3322-002              s=
eat0 default group2  cap:pg  size 95x53mm tap (dl off) left scroll-nat scro=
ll-2fg-edge click-buttonareas-clickfinger dwt-on dwtp-on
-event4   DEVICE_ADDED                 Video Bus                         s=
eat0 default group3  cap:k
-event2   DEVICE_ADDED                 Power Button                      s=
eat0 default group4  cap:k
-event1   DEVICE_ADDED                 Power Button                      s=
eat0 default group5  cap:k
-event0   DEVICE_ADDED                 Lid Switch                        s=
eat0 default group6  cap:S
-event3   DEVICE_ADDED                 AT Translated Set 2 keyboard      s=
eat0 default group7  cap:k
 event3   KEYBOARD_KEY                 +1=2E467s	KEY_LEFTCTRL (29) pressed
 event3   KEYBOARD_KEY                 +1=2E469s	KEY_LEFTMETA (125) presse=
d
 event3   KEYBOARD_KEY                 +1=2E470s	KEY_F24 (194) pressed
 event3   KEYBOARD_KEY                 +1=2E608s	KEY_F24 (194) released
 event3   KEYBOARD_KEY                 +1=2E611s	KEY_LEFTMETA (125) releas=
ed
 event3   KEYBOARD_KEY                 +1=2E612s	KEY_LEFTCTRL (29) release=
d
-event5   KEYBOARD_KEY                 +4=2E041s	KEY_WLAN (238) pressed
 event5   KEYBOARD_KEY                 +4=2E041s	KEY_WLAN (238) released
 event5   KEYBOARD_KEY                 +7=2E001s	KEY_BRIGHTNESSUP (225) pr=
essed
 event5   KEYBOARD_KEY                 +7=2E001s	KEY_BRIGHTNESSUP (225) re=
leased
 event5   KEYBOARD_KEY                 +7=2E568s	KEY_BRIGHTNESSDOWN (224) =
pressed
 event5   KEYBOARD_KEY                 +7=2E568s	KEY_BRIGHTNESSDOWN (224) =
released
 event5   KEYBOARD_KEY                 +12=2E350s	KEY_SWITCHVIDEOMODE (227=
) pressed
 event5   KEYBOARD_KEY                 +12=2E350s	KEY_SWITCHVIDEOMODE (227=
) released
 event5   KEYBOARD_KEY                 +13=2E726s	KEY_SWITCHVIDEOMODE (227=
) pressed
 event5   KEYBOARD_KEY                 +13=2E726s	KEY_SWITCHVIDEOMODE (227=
) released
 event5   KEYBOARD_KEY                 +19=2E846s	KEY_SLEEP (142) pressed
 event5   KEYBOARD_KEY                 +19=2E846s	KEY_SLEEP (142) released
-event3   KEYBOARD_KEY                 +50=2E998s	KEY_LEFTCTRL (29) presse=
d
 event3   KEYBOARD_KEY                 +51=2E140s	KEY_LEFTCTRL (29) releas=
ed
-event5   KEYBOARD_KEY                 +96=2E713s	KEY_UNKNOWN (240) presse=
d
 event5   KEYBOARD_KEY                 +96=2E716s	KEY_UNKNOWN (240) releas=
ed
-event1   KEYBOARD_KEY                 +96=2E740s	KEY_WAKEUP (143) pressed
 event1   KEYBOARD_KEY                 +96=2E740s	KEY_WAKEUP (143) release=
d
-event2   KEYBOARD_KEY                 +96=2E743s	KEY_WAKEUP (143) pressed
 event2   KEYBOARD_KEY                 +96=2E743s	KEY_WAKEUP (143) release=
d
-event5   KEYBOARD_KEY                 +111=2E647s	KEY_BATTERY (236) press=
ed
 event5   KEYBOARD_KEY                 +111=2E647s	KEY_BATTERY (236) relea=
sed
 event5   KEYBOARD_KEY                 +113=2E308s	KEY_BATTERY (236) press=
ed
 event5   KEYBOARD_KEY                 +113=2E308s	KEY_BATTERY (236) relea=
sed
 event5   KEYBOARD_KEY                 +119=2E950s	KEY_COFFEE (152) presse=
d
 event5   KEYBOARD_KEY                 +119=2E950s	KEY_COFFEE (152) releas=
ed
 event5   KEYBOARD_KEY                 +121=2E349s	KEY_COFFEE (152) presse=
d
 event5   KEYBOARD_KEY                 +121=2E349s	KEY_COFFEE (152) releas=
ed
 event5   KEYBOARD_KEY                 +124=2E933s	KEY_MUTE (113) pressed
 event5   KEYBOARD_KEY                 +124=2E933s	KEY_MUTE (113) released
 event5   KEYBOARD_KEY                 +125=2E420s	KEY_MUTE (113) pressed
 event5   KEYBOARD_KEY                 +125=2E420s	KEY_MUTE (113) released
-event0   SWITCH_TOGGLE                +133=2E939s	switch lid state 1
-event5   KEYBOARD_KEY                 +136=2E839s	KEY_UNKNOWN (240) press=
ed
 event5   KEYBOARD_KEY                 +136=2E850s	KEY_UNKNOWN (240) relea=
sed
-event0   SWITCH_TOGGLE                +136=2E873s	switch lid state 0
-event1   KEYBOARD_KEY                 +136=2E873s	KEY_WAKEUP (143) presse=
d
 event1   KEYBOARD_KEY                 +136=2E873s	KEY_WAKEUP (143) releas=
ed
-event2   KEYBOARD_KEY                 +136=2E874s	KEY_WAKEUP (143) presse=
d
 event2   KEYBOARD_KEY                 +136=2E874s	KEY_WAKEUP (143) releas=
ed
