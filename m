From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Wed, 3 Jan 2018 12:12:06 +0100
Message-ID: <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com> <20180103110048.GA21230@xora-haswell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:42332 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeACLMI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2018 06:12:08 -0500
Received: by mail-io0-f196.google.com with SMTP id x67so1742603ioi.9
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2018 03:12:07 -0800 (PST)
In-Reply-To: <20180103110048.GA21230@xora-haswell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nadavh@marvell.co>

Hi Graeme,

2018-01-03 12:00 GMT+01:00 Graeme Gregory <graeme.gregory@linaro.org>:
> On Mon, Dec 18, 2017 at 10:40:31AM +0100, Ard Biesheuvel wrote:
>> On 18 December 2017 at 10:17, Marcin Wojtas <mw@semihalf.com> wrote:
>> > Hi,
>> >
>> > This patchset introduces ACPI support in mvpp2 and mvmdio drivers.
>> > First three patches introduce fwnode helpers for obtaining PHY
>> > information from nodes and also MDIO fwnode API for registering
>> > the bus with its PHY/devices.
>> >
>> > Following patches update code of the mvmdio and mvpp2 drivers
>> > to support ACPI tables handling. The latter is done in 4 steps,
>> > as can be seen in the commits. For the details, please
>> > refer to the commit messages.
>> >
>> > Drivers operation was tested on top of the net-next branch
>> > with both DT and ACPI. Although for compatibility reasons
>> > with older platforms, the mvmdio driver keeps using
>> > of_ MDIO registering, new fwnode_ one proved to fully work
>> > with DT as well (tested on MacchiatoBin board).
>> >
>> > mvpp2/mvmdio driver can work with the ACPI representation, as exposed
>> > on a public branch:
>> > https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
>> > It was compiled together with the most recent Tianocore EDK2 revision.
>> > Please refer to the firmware build instruction on MacchiatoBin board:
>> > http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II
>> >
>> > Above support configures 1G to use its PHY normally. 10G can work now
>> > only with the link interrupt mode. Somehow reading of the
>> > string property in fwnode_mdiobus_child_is_phy works only with
>> > DT and cannot cope with 10G PHY nodes as in:
>> > https://pastebin.com/3JnYpU0A
>> >
>> > Above root cause will be further checked. In the meantime I will
>> > appreciate any comments or remarks for the kernel patches.
>> >
>>
>> Hi Marcin,
>>
>> I have added linux-acpi and Graeme to cc. I think it makes sense to
>> discuss the way you describe the device topology before looking at the
>> patches in more detail.
>>
>> In particular, I would like to request feedback on the use of
>> [redundant] 'reg' properties and the use of _DSD + compatible to
>> describe PHYs. Usually, we try to avoid this, given that it is
>> essentially a ACPI encapsulated DT dialect that is difficult to
>> support in drivers unless they are based on DT to begin with. Also,
>> non-standard _DSD properties require a vendor prefix, it is not
>> freeform.
>>
>> For reference, the ACPI description is here (starting at line 175)
>> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/72d5ac23b20dd74d479daa5e40ba443264b31261/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl
>>
> So the representation of PHY's with _DSD was kind of formalised here
>
> http://www.uefi.org/sites/default/files/resources/nic-request-v2.pdf
>
> This is already in use in the kernel, and that DSDT seems to be along the same
> lines. So seems ok in that manner.
>
> The "reg", 0 property seems a little odd, it would probably make more
> sense to check for the lack of ranges passed in in ACPI manner _CRS.
>

I already agreed with 'reg' being awkward in the later emails.
Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?

Thanks,
Marcin
