From: Marco Chiappero <marco@absence.it>
Subject: Re: sony-laptop on VAIO TT help request
Date: Thu, 14 Jul 2011 00:11:41 +0200
Message-ID: <4E1E181D.1030301@absence.it>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it> <20110701095049.GE11959@gamma.logic.tuwien.ac.at> <4E0DD1D0.7020605@absence.it> <20110712062157.GA15096@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110712062157.GA15096@gamma.logic.tuwien.ac.at>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Il 12/07/2011 08:21, Norbert Preining ha scritto:
> Hi Marc,
>
> sorry for the silence, I was overly busy with a state exam on Japanese
> and some presentations.

Hi Norbert,
there is no problem at all.

> What I am missing is the shock protector, there is a sensor built in.

Yes I know, and it seems that a device driver is used under Windows... 
can you confirm this? Can you see this sensor under the device listing 
of Windows? Handle 0x0113 might allow to turn on/off this sensor, but 
then it should controlled by another driver, I'm afraid.

>> This last one is interesting because, from the other DSTDs I have seen,
>> I suspect your notebook to have handle 0x0113, an handle that allows to
>> enable/disable an unknown feature, is it the HDD protection?
>
> How can I check that?

I can provide you a patch for testing this feature.

>> This is interesting too. Ok, let's not speak about the multiplexer
>> methods, let us speak about handle 0x0128, related to the Hybrid GFX
>> feature. I have never done a deep analysis, maybe you can help here.
>> First of all, newer VPCZ1 models come with a few more methods, dealing
>> with the screen brightness level, HSC5, HSC6, HSC7. Then:
>> - HSC0 returns the event reason (1 switch position change? what about
>> 2,3,4?)
>
> Currently we are not evaluating HSC0 at all, I am not sure about its
> function.

HSC0 returns HGER (Hybrid GFX Event Reason), a number that can be read 
when an Hybrid GFX event is notified (for example when the physical 
switch change its position), telling userspace what triggered that event.

> only HSC1 is used to query the speed/stamina switch.

It also provides other informations, do you know their meaning?

Method (HSC1, 0, Serialized)
{
     Store (Zero, Local0)
     If (AVIL)			<-- ??
     { ... }

     If (^^H8EC.SWPS)		<-- switch position
     { ... }

     If (LEqual (HGAP, One))	<-- Hyb GFX A? Presence?
     { ... }

     If (LEqual (HGAP, 0x02))	<-- Hyb GFX A? Presence?
     { ... }

     If (HDME)		<-- HDMI Exit? HDMI routing capability?
     { ... }

     If (DVIE)
     { ... }

     If (^^H8EC.ATSW)		<-- switch set to auto
     { ... }

     ...
}

> Furthermore, the path of HSC1 is different on different modules
> 	_SB.PCI0.LPC.SNC.HSC1	(VGN)
> and
> 	_SB.PCI0.LPCB.SNC.HSC1	(VPC)

This is not relevant, we just call the SN07 method from the SNC device, 
so don't care about it.

> Not much more is used actually, but turning on/off the nvidia (secondary
> gpu) and the speed/stamina led by hooking into
> 	_SB.PCI0.OVGA._DSM (VGN)
> and
> 	_SB.PCI0.P0P2.DGPU._DSM (VPC)
> with various function indices (2 ->  led, 3 ->  gpu off).

If I'm not wrong the video driver should take care of calling _DSM and 
other multiplexing methods (MXDS, MXMX and so on), is it right?
We need to find out more about methods HSC1, HSC2, HSC3, HSC4, but I 
don't own the hardware.
Then we can start changing the code to be more compliant to the kernel 
guidelines.
