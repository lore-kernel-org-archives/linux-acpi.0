From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ACPI defined devices not showing up under /sys/bus/platform/devices
Date: Thu, 18 Sep 2014 22:49:32 +0200
Message-ID: <541B455C.4000601@redhat.com>
References: <541ACA3B.3070309@redhat.com> <20140918140106.GU10854@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12979 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755864AbaIRUtg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Sep 2014 16:49:36 -0400
In-Reply-To: <20140918140106.GU10854@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Marcos Paulo de souza <marcos.souza.org@gmail.com>

Hi,

On 09/18/2014 04:01 PM, Mika Westerberg wrote:
> On Thu, Sep 18, 2014 at 02:04:11PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> I'm trying to help various users with Asus X450 and Asus X550 laptops
>> to get their touchpad to work:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1110011
>>
>> We believe that this touchpad is connected over i2c, using the
>> i2c-designware-platform driver.
>>
>> If you look at the DSDT attached there you can clearly see
>> nodes defines which should lead to e.g. :
>>
>> /sys/bus/platform/devices/INT33C2:00
>>
>> Showing up (which should then be bound by i2c-designware-platform).
>>
>> But nothing is showing up, not a single ACPI defined device shows
>> up actually:
>>
>>
>>
>>
>>
>> [root@asusx550 devices]# ll
>> insgesamt 0
>> lrwxrwxrwx. 1 root root 0 22. Jul 14:56 alarmtimer -> ../../../devices/platform/alarmtimer
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 asus-nb-wmi -> ../../../devices/platform/asus-nb-wmi
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 coretemp.0 -> ../../../devices/platform/coretemp.0
>> lrwxrwxrwx. 1 root root 0 22. Jul 14:56 efi-framebuffer.0 -> ../../../devices/platform/efi-framebuffer.0
>> lrwxrwxrwx. 1 root root 0 22. Jul 14:56 Fixed MDIO bus.0 -> ../../../devices/platform/Fixed MDIO bus.0
>> lrwxrwxrwx. 1 root root 0 22. Jul 14:56 i8042 -> ../../../devices/platform/i8042
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 iTCO_wdt -> ../../../devices/pci0000:00/0000:00:1f.0/iTCO_wdt
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 microcode -> ../../../devices/platform/microcode
>> lrwxrwxrwx. 1 root root 0 22. Jul 14:56 pcspkr -> ../../../devices/platform/pcspkr
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 regulatory.0 -> ../../../devices/platform/regulatory.0
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 rtsx_pci_ms.0 -> ../../../devices/pci0000:00/0000:00:1c.2/0000:02:00.0/rtsx_pci_ms.0
>> lrwxrwxrwx. 1 root root 0 25. Jul 23:54 rtsx_pci_sdmmc.0 -> ../../../devices/pci0000:00/0000:00:1c.2/0000:02:00.0/rtsx_pci_sdmmc.0
>> lrwxrwxrwx. 1 root root 0 22. Jul 14:56 serial8250 -> ../../../devices/platform/serial8250
>>
>>
>> Which is weird, since any recent machine usually has at least one or 2
>> show up.
> 
> It depends whether the BIOS has enabled those or not.
> 
> If
> 
>  # cat /sys/bus/acpi/devices/INT33C2:00/status
>  # cat /sys/bus/acpi/devices/INT33C3:00/status
> 
> returns 0xf, then the device should be there, otherwise it is not.

Interesting. Marcos, can you give this a try please ?

> The "status" refers directly shat _STA() ACPI method returns.

Ok, so assuming that Marcos' testing shows it is not enabled,
is there anything we can, could there be some ACPI call to
enable these devs ?

> Note that the device could also be in PCI mode, in case lspci should
> show it.

Right, it does not show in lspci.

Regards,

Hans
