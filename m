From: Mattia Dongili <malattia@linux.it>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Tue, 19 Jun 2012 07:19:06 +0900
Message-ID: <20120618221905.GA20324@kamineko.org>
References: <20120615113637.GA5904@kamineko.org>
 <4FDB5202.706@babioch.de>
 <20120615223711.GA31180@kamineko.org>
 <4FDBC183.7050203@babioch.de>
 <20120616025223.GA5200@kamineko.org>
 <4FDC6D0A.8080505@babioch.de>
 <20120616130705.GB2326@kamineko.org>
 <4FDCCB79.9090305@babioch.de>
 <20120616231658.GC2326@kamineko.org>
 <4FDDB67F.7090704@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDDB67F.7090704@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 17, 2012 at 12:50:39PM +0200, Karol Babioch wrote:
> Hi,
> 
> Am 17.06.2012 01:16, schrieb Mattia Dongili:
> > I'm a bit lost at this point. Are you saying that you cannot get a
> > working backlight control with the old set-up you had?
> Yeah, I can't get it working. Tried nearly every kernel from 3.0
> onwards. Don't know what is going on here :(. Any idea what could have
> caused this?
> 
> > If so what else did you change in your set up?
> Well, I'm on Arch Linux, which is a rolling release distribution. So
> there is probably a lot of stuff, which has changed during the course of
> the last two to three months :(.
> 
> > Also, any chance you could try to inspect/poke the acpi_video0 or
> > sony-laptop backlight directories without loading the nouveau driver?
> Yeah, sure. In both cases the brightness won't change. Here you have
> some excerpts in the case of "acpi_backlight=vendor" again:
> 
> [root@vpcs ~]# grep . /sys/class/backlight/sony/*/*
> /sys/class/backlight/sony/actual_brightness:-13
> /sys/class/backlight/sony/bl_power:0
> /sys/class/backlight/sony/brightness:-13
> /sys/class/backlight/sony/max_brightness:242
> /sys/class/backlight/sony/type:platform
> 
> I then echoed 100 to /sys/class/backlight/sony/brightness and dmesg
> reported the following:
> 
> [   89.631235] sony_laptop: found handle 0x0137 (offset: 0x0b)
> [   89.753455] sony_laptop: __call_snc_method: [SN07:0x000000000000020b]
> [   89.753457] sony_laptop: called SN07 with 0x020b (result: 0x0000)
> 
> Not sure what this means, but probably nouveau is not the culprit here.

the reason I'm asking is because from the DSDT the only reason why the
calls to setting backlight would not work are due to
	If (LEqual (^IGPU.PBCC, One))
	{
and PBCC is defined in PCI_Config space (should be set by the video
driver or something like that?)
	Device (IGPU)
	{
	    Name (_ADR, Zero)
	    OperationRegion (GPPB, PCI_Config, 0xB4, 0x14)
	    Field (GPPB, ByteAcc, NoLock, Preserve)
	    {
		PBCI,   8,
		PBNP,   8,
		PBLS,   8,
		PBCC,   8,
		PBCM,   32,
		PBDI,   32,
		PBDO,   32,
		PBMX,   32
	    }
Can you also switch to the second video card (do you have one) and try
if brightness regulation works?

Thanks
-- 
mattia
:wq!
