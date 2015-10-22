From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Thu, 22 Oct 2015 11:19:16 -0500
Message-ID: <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
	<20151021085056.GV1526@lahna.fi.intel.com>
	<CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
	<20151022080157.GI1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37011 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333AbbJVQTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2015 12:19:16 -0400
Received: by igbhv6 with SMTP id hv6so63361708igb.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2015 09:19:16 -0700 (PDT)
In-Reply-To: <20151022080157.GI1526@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

>> Is there a way to see PCI to ACPI associations?
>
> Yes, the PCI device has a symlink "firmware_node" which points to the
> ACPI device.
>
> Here an example from Skylake system (which uses PCI mode for LPSS
> devices):
>
> # ls -l /sys/bus/pci/devices/0000\:00\:15.1/firmware_node
> lrwxrwxrwx    1 root     root             0 Oct 22 08:00 /sys/bus/pci/devices/0000:00:15.1/firmware_node -> ../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6f
>
> # cat /sys/bus/pci/devices/0000\:00\:15.1/firmware_node/path
> \_SB_.PCI0.I2C1

I see the problem now.
Your I2C controller is under the PCI0 device on your Skylake system,
mine was not.

So, I moved the definition of all the PCI devices that are on PCI bus
0 to under PCI0.
After that, all the PCI devices found their ACPI companion and the
firmware_node symlink is present and correct.
I2C-core creates a symlink for the attached device on the right controller.
/sys/bus/i2c/devices/i2c-24C02:00 ->
../../../devices/pci0000:00/0000:00:18.3/i2c-3/i2c-24C02:00
So that part is solved. (And I'll have to send a patch to coreboot...)

The next issue is that the I2C-core isn't matching the device to the
"at24" driver, which has the alias "24c02".

I used to instantiate the device from user space with:
# echo 24c02 0x57 > /sys/bus/i2c/devices/i2c-3/new_device
That now shows the address is busy, so it is creating the device, just
not linking it to the driver.

I'll dig further and see what I can see.

Thanks for your help.
Ben
