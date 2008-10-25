From: Norbert Preining <preining@logic.at>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sun, 26 Oct 2008 01:31:18 +0200
Message-ID: <20081025233118.GA31722@gandalf.dynalias.org>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:39320 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbYJYXcI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 19:32:08 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Wise <joshua@joshuawise.com>
Cc: malattia@linux.it, drzeus-mmc@drzeus.cx, linux-acpi@vger.kernel.org

Hi Joshua,

first of all, thanks a lot!

On Sat, 25 Oct 2008, Joshua Wise wrote:
>>  nvidia graphics (both built in, switch on the fly on vista possible,
>>    on linux needs reboot)
>
> Hmm, that is very interesting!  On my SZ4, which has a (factory) Vista
> install, a reboot is needed; and if you ever suspend the machine from Linux,
> a clean boot from Vista is needed in order to switch the graphics card.

Hmm, good question. I will check. I actually hardly use Vista, but read
that hot switching on Vista is possible.

And I never suspended till now, or better, I did and the laptop froooozze.

> I think I know what PCI config registers need to be poked, at least on my
> SZ4, to change on the fly, but I haven't experimented to come up with a
> reliable way of actually doing it (or changing over the all-important LED).

Since I am not in need of it anyway, that is not important.

>>  after rebooting *from* Vista to Linux I see the following USB device:
>>  Bus 004 Device 002: ID 0af0:6911 Option
>>  which is an Option Globetrotter HSDPA Modem
>>  but cold-booting directly into linux this device does not appear
>>  functionality not tested since devices are strangly enough not created!
>>  Something similar has been reported in
>>    http://fedoraforum.org/forum/showthread.php?t=196654
>
> I'm surprised that you get it when rebooting from Vista to Linux; usually
> the BIOS shuts it off.   I don't have my SZ with me, but there should be a

If I shut down Vista and restart (cold boot) linux it is gone.
If I tell Vista to restart and go directly from grub to linux it is
there.
Tested, several times.

> 'wwan-power' file somewhere in /sys -- try echoing '1' to it?  Other than

You mean
	/sys/devices/platform/sony-laptop/wwanpower
?

I echoed 1 to it and the usb device is still not showing up in lsusb. Is
there something else I have to do?

> that, it behaves exactly like a GSM modem; you may need to modify the
> 'option' kernel module to learn about the new USB device ID.  On my SZ, to

So that needs src changes, there is no modinfo option to force a device
id?

> wake up the modem, I believe you need to send the command 'AT+CFUN=1' to
> actually put it in 'connect to the network' state, as opposed to the default
> 'transceiver off'.

That should go to /dev/ttyUSBsomething I suppose?

> authentication, and the keys for that are only in the Windows Sony 
> drivers. Thanks, guys...

Ok, bummer. Let us forget it for now.

>> brightness adjustment via hardware buttons does not work
>> there is /sys/class/backlight/sony but writing to brightness therein
>> does not do anything, neither does xbrightness, nor are any events sent
>> (see below for unknown methods in SNC/SPIC)
>
> That works only if in Intel mode; use smartdimmer in nVidia mode.

I never got it working, and I am always running in intel = stamina mode.
Nothing whatever I do changes the brightness of the screen. Neither
using 
	/sys/devices/virtual/backlight/sony/brightness
nor 
	/sys/devices/virtual/backlight/acpi_video0/brightness

>> rfkill switch does turn of bluetooth AND WLAN, which is not what I want.
>> Problably only the SNC/SPIC routines can do something like turning
>> on/off specific hardware, see below.
>
> rfkill is in hardware, I think.  To turn off bluetooth, take a look at the
> 'spicctrl' command.

Ok, will try that one.

>> other things with sony_acpi:
>>  writing and reading to wwanpower is possible EVEN if the wwan
>>  device is not present/exhibited/listed as device (lsusb)
>
> Writing '1' to it should create the device...

But it didn't, unfortunately.

> Does your system have "SmartWi" under Windows?  Perhaps the "wwan wakeup"
> requests differ on your VAIO from my SZ.

SmartWi? I have some application that allows me to switch on/off
bluetooth, eth, modem, wwan, wlan. I will check the name.

Thanks a lot for all your suggestions

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WARLEGGAN (n. archaic)
One who does not approve of araglins (q.v.)
			--- Douglas Adams, The Meaning of Liff
