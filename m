From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] ACPI / scan: force creation of platform device for the
 Surface tablets
Date: Thu, 12 May 2016 18:06:06 +0200
Message-ID: <CAN+gG=GwwP-GfDZPEPT6tCK2nzYS2SH_QqyFmbQvTWzu2=sEKg@mail.gmail.com>
References: <1463061992-11443-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34574 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcELQGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2016 12:06:12 -0400
In-Reply-To: <1463061992-11443-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, May 12, 2016 at 4:06 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> As mentioned in drivers/platform/x86/surfacepro3_button.c, the various
> Microsoft Surface tablets do not follow the ACPI SOC buttons specification.
> They present an I2C device like this:
>
>   Device (WBUT)
>   {
>       Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
>       {
>           Return ("PNP0C40")
>       }
>
>       Name (_CID, "PNP0C40" /* Standard Button Controller */)  // _CID: Compatible ID
>       Method (_STA, 0, NotSerialized)  // _STA: Status
>       {
>           Return (0x0F)
>       }
>
>       Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>       {
>           [stripped]
>       }
>   }
>
>   Device (TEV2)
>   {
>       Name (_HID, "MSHW0028")  // _HID: Hardware ID
>       Name (_DEP, Package (0x06)  // _DEP: Dependencies
>       {
>           GPO0,
>           GPO2,
>           GPO1,
>           ^PCI0.I2C2,
>           ^PCI0.I2C7,
>           ^PCI0.I2C7.PMIC
>       })
>       Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>       {
>           Name (RBUF, ResourceTemplate ()
>           {
>               GpioInt (Edge, ActiveBoth, SharedAndWake, PullDefault, 0x09C4,
>                   "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                   )
>                   {   // Pin list
>                       0x0008
>                   }
>               GpioInt (Edge, ActiveBoth, SharedAndWake, PullDefault, 0x09C4,
>                   "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                   )
>                   {   // Pin list
>                       0x000A
>                   }
>               GpioInt (Edge, ActiveBoth, Shared, PullDefault, 0x09C4,
>                   "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>                   )
>                   {   // Pin list
>                       0x005D
>                   }
>               GpioInt (Edge, ActiveBoth, Shared, PullDefault, 0x09C4,
>                   "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                   )
>                   {   // Pin list
>                       0x0008
>                   }
>               I2cSerialBus (0x002D, ControllerInitiated, 0x00061A80,
>                   AddressingMode7Bit, "\\_SB.PCI0.I2C2",
>                   0x00, ResourceConsumer, ,
>                   )
>               [stripped]
>           })
>           [stripped]
>           If ((OBID <= 0x0C))
>           {
>               Return (RBUF) /* \_SB_.TEV2._CRS.RBUF */
>           }
>
>           Return (PBUF) /* \_SB_.TEV2._CRS.PBUF */
>       }
>
>       Method (_STA, 0, NotSerialized)  // _STA: Status
>       {
>           Return (0x0F)
>       }
>
>       Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>       {
>           [stripped]
>       }
>   }
>
> The actual HW button is named MSHW0028 on the MS Surface (Pro) 3 and
> is meant to be bound on the I2C bus 7. The problem is that the bus
> doesn't see any device on the address 0x002D.
>
> The Surface Pro devices have working ACPI events and thus we can use
> surfacepro3_button which is a pure acpi driver. The Surface 3 however
> does not generate any ACPI events and the buttons are not working
> through surfacepro3_button (even when we add the name TEV2 in this module).
>
> The solution consists in forcing the creation of an platform device
> which we can handle in soc_button_array as any proper SOC GPIO buttons
> should be.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Hi,
>
> this is IMO the best way to handle this situation (besides fixing the DSDT
> itself). The other solutions I thought were:
> - add a specific acpi driver that will unbind the current I2C acpi handle
>   and will create the platform_driver
> - add a specific acpi driver that merges surfacepro3_button and soc_button_array
>   but has a lot of code duplication
>
> I am open to any other solution if we could have this list of ids in a different
> place but I could not see any other.
>

My bad. A further check showed that the device is actually bound to a
I2C bus, and so an I2C driver can be enumerated. Now I need to have a
common code base with soc_button_array without duplicating everything.

Please disregard this patch (for now :-P ).

Cheers,
Benjamin
