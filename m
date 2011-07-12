From: Norbert Preining <preining@logic.at>
Subject: Re: sony-laptop on VAIO TT help request
Date: Tue, 12 Jul 2011 15:21:57 +0900
Message-ID: <20110712062157.GA15096@gamma.logic.tuwien.ac.at>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it> <20110701095049.GE11959@gamma.logic.tuwien.ac.at> <4E0DD1D0.7020605@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:45619 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1GLGWF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2011 02:22:05 -0400
Content-Disposition: inline
In-Reply-To: <4E0DD1D0.7020605@absence.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>

Hi Marc,

sorry for the silence, I was overly busy with a state exam on Japanese
and some presentations.

On Fr, 01 Jul 2011, Marco Chiappero wrote:
>> I looked a bit through the patch and I see that it is restricted
>> to MM and (forgotten the model number).
>
> MM? What does it stand for?

TT I meant. But patching the kernel and running your module I see at least
that there is support for battery_care_limiter and some others.
On my VGN-Z11 I get:
battery_care_limiter  lid_resume_control  subsystem@	    uevent
bluetoothpower	      modalias		  thermal_control   wwanpower
driver@		      odd_power		  thermal_profiles
fanspeed	      power/		  touchpad
in /sys/devices/platform/sony-laptop.

What I am missing is the shock protector, there is a sensor built in.

> This last one is interesting because, from the other DSTDs I have seen,  
> I suspect your notebook to have handle 0x0113, an handle that allows to  
> enable/disable an unknown feature, is it the HDD protection?

How can I check that?

> This is interesting too. Ok, let's not speak about the multiplexer  
> methods, let us speak about handle 0x0128, related to the Hybrid GFX  
> feature. I have never done a deep analysis, maybe you can help here.
> First of all, newer VPCZ1 models come with a few more methods, dealing  
> with the screen brightness level, HSC5, HSC6, HSC7. Then:
> - HSC0 returns the event reason (1 switch position change? what about  
> 2,3,4?)

Currently we are not evaluating HSC0 at all, I am not sure about its
function. only HSC1 is used to query the speed/stamina switch.
Furthermore, the path of HSC1 is different on different modules
	_SB.PCI0.LPC.SNC.HSC1	(VGN)
and
	_SB.PCI0.LPCB.SNC.HSC1	(VPC)


Not much more is used actually, but turning on/off the nvidia (secondary
gpu) and the speed/stamina led by hooking into
	_SB.PCI0.OVGA._DSM (VGN)
and
	_SB.PCI0.P0P2.DGPU._DSM (VPC)
with various function indices (2 -> led, 3 -> gpu off).

> What does handle 0x0128 aim to provide?

No idea..

If anything what I said makes sense to you and you need more information,
please let me know. I can hack the module code and dump acpi etc
whatever might be useful for you.

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
it's at times like this, when
I'm trapped in a Vogon airlock with a man from Betelgeuse,
and about to die from asphyxiation in deep space that I
really wish I'd listened to what my mother told me when I
was young.'
`Why, what did she tell you?'
`I don't know, I didn't listen.'
                 --- Arthur coping with certain death as best as he could.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
