From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Wed, 3 Jan 2018 14:13:09 +0100
Message-ID: <CAPv3WKfZN+=9wFJ5ct+8nttd=bikaZ=Ei741pyTVXjQz2zq2dg@mail.gmail.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell> <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180103124720.GG15036@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:42469 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeACNNL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2018 08:13:11 -0500
Received: by mail-io0-f176.google.com with SMTP id x67so2026086ioi.9
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2018 05:13:11 -0800 (PST)
In-Reply-To: <20180103124720.GG15036@lunn.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nad>

Hi Andrew,

2018-01-03 13:47 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> I already agreed with 'reg' being awkward in the later emails.
>> Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?
>
> Also, how do you specify which MDIO bus the PHY is on. To fully
> specify a PHY, you need both bits of information.
>
> In DT, the phy-handle phandle can point to any PHY anywhere in the
> system. This is particularly important when a Ethernet device has two
> MDIO busses.
>

For now, my local MDIO bus description is pretty DT-like, i.e. master
bus with children PHYs:
        Device (MDIO)
        {
            Name (_HID, "MRVL0100")                             //
_HID: Hardware ID
            Name (_UID, 0x00)                                   //
_UID: Unique ID
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xf212a200,                                 // Address Base
                    0x00000010,                                 //
Address Length
                    )
            })
            Device (GPHY)
            {
              Name (_ADR, 0x0)
            }
        }

        Device (XSMI)
        {
            Name (_HID, "MRVL0101")                             //
_HID: Hardware ID
            Name (_UID, 0x00)                                   //
_UID: Unique ID
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xf212a600,                                 // Address Base
                    0x00000010,                                 //
Address Length
                    )
            })
            Device (PHY0)
            {
              Name (_ADR, 0x0)
              Name (_CID, "ethernet-phy-ieee802.3-c45")
            }
            Device (PHY8)
            {
              Name (_ADR, 0x8)
              Name (_CID, "ethernet-phy-ieee802.3-c45")
            }
        }

Which is referenced in the port's node:

Package () { "phy", Package (){\_SB.XSMI.PHY0}},

I'm studying an alternatives with graphs, as suggested by Tomasz
Nowicki, but to me above is pretty natural and not complicated.

Best regards,
Marcin
