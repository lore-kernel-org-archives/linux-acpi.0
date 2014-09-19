From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI defined devices not showing up under
 /sys/bus/platform/devices
Date: Fri, 19 Sep 2014 15:26:35 +0300
Message-ID: <20140919122635.GA1786@lahna.fi.intel.com>
References: <541ACA3B.3070309@redhat.com>
 <20140918140106.GU10854@lahna.fi.intel.com>
 <541B455C.4000601@redhat.com>
 <541B4870.2010906@gmail.com>
 <20140919084707.GB10854@lahna.fi.intel.com>
 <541C1821.30206@gmail.com>
 <20140919120103.GO10854@lahna.fi.intel.com>
 <541C1F42.1070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56799 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682AbaISM1I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Sep 2014 08:27:08 -0400
Content-Disposition: inline
In-Reply-To: <541C1F42.1070106@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcos Paulo de souza <marcos.souza.org@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Sep 19, 2014 at 09:19:14AM -0300, Marcos Paulo de souza wrote:
> Hi Mika,
> 
> On 09/19/2014 09:01 AM, Mika Westerberg wrote:
> >On Fri, Sep 19, 2014 at 08:48:49AM -0300, Marcos Paulo de souza wrote:
> >>Hi,
> >>
> >>On 09/19/2014 05:47 AM, Mika Westerberg wrote:
> >>>On Thu, Sep 18, 2014 at 06:02:40PM -0300, Marcos Paulo de souza wrote:
> >>>>Hi,
> >>>>
> >>>>On 09/18/2014 05:49 PM, Hans de Goede wrote:
> >>>>>Hi,
> >>>>>
> >>>>>On 09/18/2014 04:01 PM, Mika Westerberg wrote:
> >>>>>>On Thu, Sep 18, 2014 at 02:04:11PM +0200, Hans de Goede wrote:
> >>>>>>>Hi,
> >>>>>>>
> >>>>>>>I'm trying to help various users with Asus X450 and Asus X550 laptops
> >>>>>>>to get their touchpad to work:
> >>>>>>>
> >>>>>>>https://bugzilla.redhat.com/show_bug.cgi?id=1110011
> >>>>>>>
> >>>>>>>We believe that this touchpad is connected over i2c, using the
> >>>>>>>i2c-designware-platform driver.
> >>>>>>>
> >>>>>>>If you look at the DSDT attached there you can clearly see
> >>>>>>>nodes defines which should lead to e.g. :
> >>>>>>>
> >>>>>>>/sys/bus/platform/devices/INT33C2:00
> >>>>>>>
> >>>>>>>Showing up (which should then be bound by i2c-designware-platform).
> >>>>>>>
> >>>>>>>But nothing is showing up, not a single ACPI defined device shows
> >>>>>>>up actually:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>[root@asusx550 devices]# ll
> >>>>>>>insgesamt 0
> >>>>>>>lrwxrwxrwx. 1 root root 0 22. Jul 14:56 alarmtimer -> ../../../devices/platform/alarmtimer
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 asus-nb-wmi -> ../../../devices/platform/asus-nb-wmi
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 coretemp.0 -> ../../../devices/platform/coretemp.0
> >>>>>>>lrwxrwxrwx. 1 root root 0 22. Jul 14:56 efi-framebuffer.0 -> ../../../devices/platform/efi-framebuffer.0
> >>>>>>>lrwxrwxrwx. 1 root root 0 22. Jul 14:56 Fixed MDIO bus.0 -> ../../../devices/platform/Fixed MDIO bus.0
> >>>>>>>lrwxrwxrwx. 1 root root 0 22. Jul 14:56 i8042 -> ../../../devices/platform/i8042
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 iTCO_wdt -> ../../../devices/pci0000:00/0000:00:1f.0/iTCO_wdt
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 microcode -> ../../../devices/platform/microcode
> >>>>>>>lrwxrwxrwx. 1 root root 0 22. Jul 14:56 pcspkr -> ../../../devices/platform/pcspkr
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 regulatory.0 -> ../../../devices/platform/regulatory.0
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 rtsx_pci_ms.0 -> ../../../devices/pci0000:00/0000:00:1c.2/0000:02:00.0/rtsx_pci_ms.0
> >>>>>>>lrwxrwxrwx. 1 root root 0 25. Jul 23:54 rtsx_pci_sdmmc.0 -> ../../../devices/pci0000:00/0000:00:1c.2/0000:02:00.0/rtsx_pci_sdmmc.0
> >>>>>>>lrwxrwxrwx. 1 root root 0 22. Jul 14:56 serial8250 -> ../../../devices/platform/serial8250
> >>>>>>>
> >>>>>>>
> >>>>>>>Which is weird, since any recent machine usually has at least one or 2
> >>>>>>>show up.
> >>>>>>It depends whether the BIOS has enabled those or not.
> >>>>>>
> >>>>>>If
> >>>>>>
> >>>>>>  # cat /sys/bus/acpi/devices/INT33C2:00/status
> >>>>>>  # cat /sys/bus/acpi/devices/INT33C3:00/status
> >>>>>>
> >>>>>>returns 0xf, then the device should be there, otherwise it is not.
> >>>>>Interesting. Marcos, can you give this a try please ?
> >>>>Hans, both here returned 0. As I said to you, I'm using Fedora in insecure
> >>>>mode (I don't know if this changes anything).
> >>>That just means that your BIOS has disabled these devices. Unless there
> >>>is a menu somewhere in BIOS setup to enable these, there is nothing we
> >>>can do in the kernel to make them appear.
> >>Interesting. This machine came with Windows 8, and removed. The touchpad was
> >>working on Windows. Mika, I verified my BIOS configurations and there isn't
> >>any configuration to enable PCI devices. Do you beleive there is something
> >>about secure boot? As it worked with Windows, hwo can it be detected on
> >>Linux?
> >Are you sure that your touch pad is connected to I2C bus in the first
> >place?
> >
> >In your ACPI DSDT, there is also a device called PS2M that happens to to
> >look like touch pad to me. For example it reports one of these _HIDs:
> >
> >                     Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
> >                     {
> >                         If (SYNA)
> >                         {
> >                             Return (0x190A2E4F)
> >                         }
> >
> >                         If (ALPS)
> >                         {
> >                             Return (0x0713A906)
> >                         }
> >
> >                         If (ELAN)
> >                         {
> >                             Return (0x08018416)
> >                         }
> >
> >                         If (STLC)
> >                         {
> >                             Return (0x41C18C4E)
> >                         }
> >
> >                         If (FOLT)
> >                         {
> >                             Return (0x01019419)
> >                         }
> >
> >                         Return (0x060A2E4F)
> >                     }
> >
> >Have you checked if any of these are present in /sys/bus/acpi/devices/*?
> 
> Yes. This is exactly the same:
> 
>                     Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
>                     {
>                         If (SYNA)
>                         {
>                             Return (0x190A2E4F)
>                         }
> 
>                         If (ALPS)
>                         {
>                             Return (0x0713A906)
>                         }
> 
>                         If (ELAN)
>                         {
>                             Return (0x08018416)
>                         }
> 
>                         If (STLC)
>                         {
>                             Return (0x41C18C4E)
>                         }
> 
>                         If (FOLT)
>                         {
>                             Return (0x02019419)
>                         }
> 
>                         Return (0x060A2E4F)
>                     }

Which one of them is present in /sys/bus/acpi/devices/?

> >
> >>>>>>The "status" refers directly shat _STA() ACPI method returns.
> >>>>>Ok, so assuming that Marcos' testing shows it is not enabled,
> >>>>>is there anything we can, could there be some ACPI call to
> >>>>>enable these devs ?
> >>>>>
> >>>>>>Note that the device could also be in PCI mode, in case lspci should
> >>>>>>show it.
> >>>>>Right, it does not show in lspci.
> >>>OK. So I think that this particular machine, either does not have Intel
> >>>LPSS (it is not Haswell-LP) or the devices have been deliberately
> >>>disabled for some reason.
> >>How can I verify this?
> >Can you send me output of lspci -vv?
> It I have a Haswell-ULT:

Based on your lspci output you have LPSS disabled. For comparison here
is a snippet from one development machine which is HSW-ULT:

...
00:15.1 Serial bus controller [0c80]: Intel Corporation Lynx Point-LP I2C Controller #0 (rev 03)
00:15.2 Serial bus controller [0c80]: Intel Corporation Lynx Point-LP I2C Controller #1 (rev 03)
