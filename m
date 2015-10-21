From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Wed, 21 Oct 2015 18:14:27 -0500
Message-ID: <CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
	<20151021085056.GV1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36303 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426AbbJUXOc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Oct 2015 19:14:32 -0400
Received: by igdg1 with SMTP id g1so97894730igd.1
        for <linux-acpi@vger.kernel.org>; Wed, 21 Oct 2015 16:14:32 -0700 (PDT)
In-Reply-To: <20151021085056.GV1526@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

Thanks for the help!

>> So my questions are:
>>   Can I use I2cSerialBus with a PCI I2C controller?
>
> Yes you can.
>
> That's what we do all the time for Intel hardware.

That is good to hear.
...

> So you can just drop the whole _CRS and make your I2C host controller
> device to look like:
>
> Device (I2C3)
> {
>         Name (_ADR, 0x00180003)
>
>         /* Standard Mode: HCNT, LCNT, SDA Hold Time */
>         Name (SSCN, Package () { 0x200, 0x200, 0x6 })
>
>         /* Fast Mode: HCNT, LCNT, SDA Hold Time */
>         Name (FMCN, Package () { 0x55, 0x99, 0x6 })
>
>         Device (EEP0)
>         {
>                 Name (_CID, Package() { "24c02" })
>                 Name (_CRS, ResourceTemplate () {
>                         I2cSerialBus (0x0057, ControllerInitiated, 400000,
>                                       AddressingMode7Bit, "\\_SB.I2C3", 0x00,
>                                       ResourceConsumer,,)
>                 })
>         }
> }

OK. I tried that.
It looks like the device is nested properly in the ACPI tree:

I see this symlink:
/sys/bus/acpi/devices/24C02:00 ->
../../../devices/LNXSYSTM:00/LNXSYBUS:00/device:16/24C02:00

# for x in /sys/bus/acpi/devices/* ; do if [ -e $x/path ] ; then
printf "%-30.30s  %s\n" "$(cat $x/path)" "$x" ; fi ; done | sort |
grep I2C3
\_SB_.I2C3                      device:16
\_SB_.I2C3.EEP0                 24C02:00

But no I2C device are created under /sys/bus/i2c/devices/.
# ll /sys/bus/i2c/devices/
lrwxrwxrwx    1 root     root             0 Oct 21 11:30 i2c-1 ->
../../../devices/pci0000:00/0000:00:18.1/i2c-1
lrwxrwxrwx    1 root     root             0 Oct 21 11:30 i2c-2 ->
../../../devices/pci0000:00/0000:00:18.2/i2c-2
lrwxrwxrwx    1 root     root             0 Oct 21 11:30 i2c-3 ->
../../../devices/pci0000:00/0000:00:18.3/i2c-3

I'll have to dig further to find where it is failing in i2c_core.c. I
assume it will be in the same spot.
Is there a way to see PCI to ACPI associations?

BTW -  I am using Linux kernel version 4.2.3.

Thanks,
Ben
