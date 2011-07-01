From: Marco Chiappero <marco@absence.it>
Subject: Re: sony-laptop on VAIO TT help request
Date: Fri, 01 Jul 2011 15:55:28 +0200
Message-ID: <4E0DD1D0.7020605@absence.it>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it> <20110701095049.GE11959@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011-1msr.fastwebnet.it ([62.101.93.131]:51399 "EHLO
	aa011-1msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475Ab1GAN6x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2011 09:58:53 -0400
In-Reply-To: <20110701095049.GE11959@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>

Il 01/07/2011 11:50, Norbert Preining ha scritto:
> Hi Marco,
>
> On Fr, 01 Jul 2011, Marco Chiappero wrote:
>>>> http://www.absence.it/vaio-acpi/source/patches/
>>
>> could you please provide us your DSDT and the exact model string of your TT?
>
> I looked a bit through the patch and I see that it is restricted
> to MM and (forgotten the model number).

MM? What does it stand for?

> I have a VGN-Z11 which has
> also a turn on/off optical drive, a shock sensor etc.

This last one is interesting because, from the other DSTDs I have seen, 
I suspect your notebook to have handle 0x0113, an handle that allows to 
enable/disable an unknown feature, is it the HDD protection?

> (btw, I also take care for the sony-laptop-zseries variant of the
> kernel module where you can turn off and on the nvidia card,
> and also the led of the speed-stamina switch is controlled.

This is interesting too. Ok, let's not speak about the multiplexer 
methods, let us speak about handle 0x0128, related to the Hybrid GFX 
feature. I have never done a deep analysis, maybe you can help here.
First of all, newer VPCZ1 models come with a few more methods, dealing 
with the screen brightness level, HSC5, HSC6, HSC7. Then:
- HSC0 returns the event reason (1 switch position change? what about 
2,3,4?)
- HSC1 returns some state bits (what about their meaning?)
- HSC2, HSC3, HSC4?

Moreover:

  Field (ECF2, ByteAcc, Lock, Preserve)
         {
                     Offset (0xF1),
             HPWR,   1, 			<-- ?
             HLMX,   1, 			<-- ?
             HCMM,   1, 			<-- ?
             DLED,   1, 			<-- discrete GFX led
             ILED,   1, 			<-- integr. GFX led
             ALED,   1, 			<-- auto GFX led
                     Offset (0xF2),
             SWPS,   1, 			<-- ?
             HPOK,   1, 			<-- ?
             HHPD,   1, 			<-- HDMI related
             DHPD,   1, 			<-- DVI related
             ATSW,   1			<-- auto switching related
         }

What does handle 0x0128 aim to provide?
