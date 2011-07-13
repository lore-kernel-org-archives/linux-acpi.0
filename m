From: Norbert Preining <preining@logic.at>
Subject: Re: sony-laptop on VAIO TT help request
Date: Thu, 14 Jul 2011 07:50:31 +0900
Message-ID: <20110713225031.GD3436@gamma.logic.tuwien.ac.at>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it> <20110701095049.GE11959@gamma.logic.tuwien.ac.at> <4E0DD1D0.7020605@absence.it> <20110712062157.GA15096@gamma.logic.tuwien.ac.at> <4E1E181D.1030301@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E1E181D.1030301@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marco,

On Do, 14 Jul 2011, Marco Chiappero wrote:
>> What I am missing is the shock protector, there is a sensor built in.
>
> Yes I know, and it seems that a device driver is used under Windows...  
> can you confirm this? Can you see this sensor under the device listing  

It was used in the original installation, I often got "turned off
HDD due to ....", but I had to reinstall and used a new W7, and I am
very lazy in hunting down drivers for W7 since I hardly use it.
I will check what I see in the device manager of W7.

>>> This last one is interesting because, from the other DSTDs I have seen,
>>> I suspect your notebook to have handle 0x0113, an handle that allows to
>>> enable/disable an unknown feature, is it the HDD protection?
>>
>> How can I check that?
>
> I can provide you a patch for testing this feature.

Yeah, please do so.

>> Currently we are not evaluating HSC0 at all, I am not sure about its
>> function.
>
> HSC0 returns HGER (Hybrid GFX Event Reason), a number that can be read  
> when an Hybrid GFX event is notified (for example when the physical  
> switch change its position), telling userspace what triggered that event.

So HSC0 returns similar data to HSC1.

> It also provides other informations, do you know their meaning?

No idea!

>
> Method (HSC1, 0, Serialized)
> {
>     Store (Zero, Local0)
>     If (AVIL)			<-- ??
>     { ... }
>
>     If (^^H8EC.SWPS)		<-- switch position
>     { ... }
>
>     If (LEqual (HGAP, One))	<-- Hyb GFX A? Presence?
>     { ... }
>
>     If (LEqual (HGAP, 0x02))	<-- Hyb GFX A? Presence?
>     { ... }
>
>     If (HDME)		<-- HDMI Exit? HDMI routing capability?
>     { ... }

That would be nice!!!! I am indeed searching for a way to activate HDMI
output on my laptop, but didn't manage till now.

>     If (DVIE)
>     { ... }
>
>     If (^^H8EC.ATSW)		<-- switch set to auto
>     { ... }

Can you provide me with a patch so that I can test these things? I mean
I can simply switch the position and read values from /sys files.

>
>> Furthermore, the path of HSC1 is different on different modules
>> 	_SB.PCI0.LPC.SNC.HSC1	(VGN)
>> and
>> 	_SB.PCI0.LPCB.SNC.HSC1	(VPC)
>
> This is not relevant, we just call the SN07 method from the SNC device,  
> so don't care about it.

Hmm, in the patch relative to your to turn on/off the nvidia device
we use this paths. If you are interested I can send you the patch
I am currently working with, relative to 3.0.0-rc7+your patch
.

> If I'm not wrong the video driver should take care of calling _DSM and  
> other multiplexing methods (MXDS, MXMX and so on), is it right?

No. It seems that the video driver (intel) does *not* turn off the 
nvidia card. I I load it without special action I get an active
nvidia card that eats battery time.

> We need to find out more about methods HSC1, HSC2, HSC3, HSC4, but I  
> don't own the hardware.

I am fine with testing many things ... but my actual knowledge of ACPI
internals is minimal, sorry.

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
ABILENE (adj.)
Descriptive of the pleasing coolness on the reverse side of the
pillow.
			--- Douglas Adams, The Meaning of Liff
