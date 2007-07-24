From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: adding new device and driver HOWTO?
Date: Tue, 24 Jul 2007 16:12:15 -0600
Message-ID: <200707241612.15163.bjorn.helgaas@hp.com>
References: <7ee95fff0707231547k3511b730qda9caf034473e5d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:39689 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737AbXGXWPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2007 18:15:42 -0400
In-Reply-To: <7ee95fff0707231547k3511b730qda9caf034473e5d1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken MacLeod <ken@bitsko.slc.ut.us>
Cc: linux-acpi@vger.kernel.org

On Monday 23 July 2007 04:47:16 pm Ken MacLeod wrote:
> We manufacture an x86 system with a device on an I/O port.  We
> initially wrote our Linux driver to load in an init script and if it
> probed OK then we knew the device was present.  We now want to be a
> little safer and portable by enumerating and autoloading properly.
> 
> Problem is, everything I've read so far is geared towards installing
> ACPI or using it, particularly only with well-known devices for power
> management.
> 
> I can't seem to find an example DSDT definition for a generic device
> or how I would tie that to its driver -- a new device developer's
> HOWTO.

Here's sample DSDT code for a UART:

            Device (U000)
            {
                Name (_HID, EisaId ("PNP0501"))
                Name (_UID, 0x40000010)
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0000000F)
                }

                Name (_CRS, ResourceTemplate ()
                {
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                        0x0000000000000000, // Address Space Granularity
                        0x00000FFC300E4000, // Address Range Minimum
                        0x00000FFC300E4007, // Address Range Maximum
                        0x0000000000000000, // Address Translation Offset
                        0x0000000000000008, // Address Length
                        ,,, AddressRangeMemory, TypeStatic)
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,,)
                    {
                        0x00000017,
                    }
                })
            }

The Linux driver that claims this device is drivers/serial/8250_pnp.c.
It has a pnp_dev_table[] that contains PNP IDs that it will claim.

So you need to get yourself a new unique PNP ID.  I've never done it,
but you might be able to do it here:
  http://www.microsoft.com/whdc/system/pnppwr/pnp/pnpid.mspx

Then add a description of your device to your DSDT using your new
PNP ID as the _HID, and write a Linux driver that registers with that
same PNP ID.

I think there's now some mechanism for autoloading using udev, maybe
using acpi_device_uevent(), but I don't know much about it.

Bjorn
