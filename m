From: Joshua Wise <joshua@joshuawise.com>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sat, 25 Oct 2008 19:02:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ip238.208-100-39.static.steadfast.net ([208.100.39.238]:55483
	"EHLO dev.x-plane.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664AbYJYXLi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 19:11:38 -0400
In-Reply-To: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: malattia@linux.it, drzeus-mmc@drzeus.cx, linux-acpi@vger.kernel.org

>  intel graphics
>  nvidia graphics (both built in, switch on the fly on vista possible,
>    on linux needs reboot)

Hmm, that is very interesting!  On my SZ4, which has a (factory) Vista
install, a reboot is needed; and if you ever suspend the machine from Linux,
a clean boot from Vista is needed in order to switch the graphics card.

I think I know what PCI config registers need to be poked, at least on my
SZ4, to change on the fly, but I haven't experimented to come up with a
reliable way of actually doing it (or changing over the all-important LED).

>  after rebooting *from* Vista to Linux I see the following USB device:
>  Bus 004 Device 002: ID 0af0:6911 Option
>  which is an Option Globetrotter HSDPA Modem
>  but cold-booting directly into linux this device does not appear
>  functionality not tested since devices are strangly enough not created!
>  Something similar has been reported in
>    http://fedoraforum.org/forum/showthread.php?t=196654

I'm surprised that you get it when rebooting from Vista to Linux; usually
the BIOS shuts it off.   I don't have my SZ with me, but there should be a
'wwan-power' file somewhere in /sys -- try echoing '1' to it?  Other than
that, it behaves exactly like a GSM modem; you may need to modify the
'option' kernel module to learn about the new USB device ID.  On my SZ, to
wake up the modem, I believe you need to send the command 'AT+CFUN=1' to
actually put it in 'connect to the network' state, as opposed to the default
'transceiver off'.

> Fingerprint Scanner TouchStrip USB: Bus 003 Device 002: ID 147e:1000
>  no device driver as far as I see

Last I talked to the guys who make this thing, it is a device supported by
their driver (I can't remember the name of the manufacturer), but they have
some Sony special firmware on it that does some sort of over-the-wire
authentication, and the keys for that are only in the Windows Sony drivers. 
Thanks, guys...

> brightness adjustment via hardware buttons does not work
> there is /sys/class/backlight/sony but writing to brightness therein
> does not do anything, neither does xbrightness, nor are any events sent
> (see below for unknown methods in SNC/SPIC)

That works only if in Intel mode; use smartdimmer in nVidia mode.

> rfkill switch does turn of bluetooth AND WLAN, which is not what I want.
> Problably only the SNC/SPIC routines can do something like turning
> on/off specific hardware, see below.

rfkill is in hardware, I think.  To turn off bluetooth, take a look at the
'spicctrl' command.

> other things with sony_acpi:
>  writing and reading to wwanpower is possible EVEN if the wwan
>  device is not present/exhibited/listed as device (lsusb)

Writing '1' to it should create the device...

Does your system have "SmartWi" under Windows?  Perhaps the "wwan wakeup"
requests differ on your VAIO from my SZ.

joshua
