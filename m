From: Hans de Goede <hdegoede@redhat.com>
Subject: ACPI defined devices not showing up under /sys/bus/platform/devices
Date: Thu, 18 Sep 2014 14:04:11 +0200
Message-ID: <541ACA3B.3070309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55263 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbaIRMEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Sep 2014 08:04:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Marcos Paulo de souza <marcos.souza.org@gmail.com>, Hans de Goede <hdegoede@redhat.com>

Hi,

I'm trying to help various users with Asus X450 and Asus X550 laptops
to get their touchpad to work:

https://bugzilla.redhat.com/show_bug.cgi?id=1110011

We believe that this touchpad is connected over i2c, using the
i2c-designware-platform driver.

If you look at the DSDT attached there you can clearly see
nodes defines which should lead to e.g. :

/sys/bus/platform/devices/INT33C2:00

Showing up (which should then be bound by i2c-designware-platform).

But nothing is showing up, not a single ACPI defined device shows
up actually:





[root@asusx550 devices]# ll
insgesamt 0
lrwxrwxrwx. 1 root root 0 22. Jul 14:56 alarmtimer -> ../../../devices/platform/alarmtimer
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 asus-nb-wmi -> ../../../devices/platform/asus-nb-wmi
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 coretemp.0 -> ../../../devices/platform/coretemp.0
lrwxrwxrwx. 1 root root 0 22. Jul 14:56 efi-framebuffer.0 -> ../../../devices/platform/efi-framebuffer.0
lrwxrwxrwx. 1 root root 0 22. Jul 14:56 Fixed MDIO bus.0 -> ../../../devices/platform/Fixed MDIO bus.0
lrwxrwxrwx. 1 root root 0 22. Jul 14:56 i8042 -> ../../../devices/platform/i8042
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 iTCO_wdt -> ../../../devices/pci0000:00/0000:00:1f.0/iTCO_wdt
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 microcode -> ../../../devices/platform/microcode
lrwxrwxrwx. 1 root root 0 22. Jul 14:56 pcspkr -> ../../../devices/platform/pcspkr
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 regulatory.0 -> ../../../devices/platform/regulatory.0
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 rtsx_pci_ms.0 -> ../../../devices/pci0000:00/0000:00:1c.2/0000:02:00.0/rtsx_pci_ms.0
lrwxrwxrwx. 1 root root 0 25. Jul 23:54 rtsx_pci_sdmmc.0 -> ../../../devices/pci0000:00/0000:00:1c.2/0000:02:00.0/rtsx_pci_sdmmc.0
lrwxrwxrwx. 1 root root 0 22. Jul 14:56 serial8250 -> ../../../devices/platform/serial8250


Which is weird, since any recent machine usually has at least one or 2
show up.

Therefor I would like to ask your help with figuring out how to
get the device nodes defined in the DSDT to actual show up.

Thanks & Regards,

Hans
