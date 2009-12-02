From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: Thinkpad X200s
Date: Wed, 02 Dec 2009 12:10:50 +0000
Message-ID: <4B16594A.2000101@collabora.co.uk>
References: <4B0FB618.7020204@collabora.co.uk> <20091127221134.GC21775@khazad-dum.debian.net> <20091128120711.GA17894@khazad-dum.debian.net> <4B111C58.5050006@collabora.co.uk> <20091128181512.GA32630@khazad-dum.debian.net> <4B13954A.9040307@collabora.co.uk> <20091130234706.GC29580@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:41903 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZLBMLX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 07:11:23 -0500
In-Reply-To: <20091130234706.GC29580@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:

> That said, please play with the master_switch_mode parameter of the
> rfkill module.  I personally cannot tolerate anything but
> master_switch_mode=1, and I dare think it might solve your problem :)

Sadly not. It looks like it should, and I've instrumented the rfkill
module to be sure the parameter is set, which it is. Debug log (WWAN)
follows. Bluetooth behaves the same way as WWAN - powers up after
killswitch toggle, regardless of its state prior to that.

# cat /sys/module/rfkill/parameters/master_switch_mode
1

prior to sleep:

# find /sys | grep rfkill..name | xargs cat
tpacpi_bluetooth_sw
tpacpi_wwan_sw
hci0
phy0

# find /sys | grep rfkill..state | xargs cat
1
1
1
1

Turn off WWAN vis /sys:

# echo 0 > /sys/devices/platform/thinkpad_acpi/rfkill/rfkill1/state

Verify it is off:

# find /sys | grep rfkill..state | xargs cat
1
0
1
1

Flip rfkill (hard) switch to off:

corwyn:/home/collabora# find /sys | grep rfkill..state | xargs cat
2
2
2

note: hci0 goes missing when the hard switch is used. (presumably usb
power loss)

Flip rfkill (hard) switch back on again:

corwyn:/home/collabora# find /sys | grep rfkill..state | xargs cat
1
1
1
1

> I think I can consider this patch approved and add your tested-by?

You can certainly add my tested-by for the sleep/resume path patch.

Tested-by: Ian Molton <ian.molton@collabora.co.uk>

> Does thinkpad-acpi tells

acpi -V -s does not list any wireless devices at all. dmesg has a few
mentions of thinkpad-acpi but only the rfkillswitch as far as wireless
devices.

Thanks for your quick response too :-)

-Ian
