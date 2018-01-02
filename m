From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the driver
Date: Tue, 02 Jan 2018 09:22:37 -0800
Message-ID: <F28C325E-AF06-45A6-B492-6F0F6C546509@gmail.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com> <1514721520-18964-6-git-send-email-mw@semihalf.com> <20171231192354.GB20455@lunn.ch> <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com> <20180102133347.GB15036@lunn.ch> <CAPv3WKfB6_5hPw2M_GOMHVc_soPyzgMqQJ=tG5qOfSe_397z9A@mail.gmail.com> <20180102140852.GE15036@lunn.ch> <CAPv3WKdD0HwdFVOBx-yeTCfcMF7DXxxFaUt+Zm06oxuVuty8Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40252 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeABRWo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jan 2018 12:22:44 -0500
In-Reply-To: <CAPv3WKdD0HwdFVOBx-yeTCfcMF7DXxxFaUt+Zm06oxuVuty8Rg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?ISO-8859-1?Q?Gregory_Cl=E9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz Nowicki <tn@semihalf.com>

On January 2, 2018 7:05:35 AM PST, Marcin Wojtas <mw@semihalf=2Ecom> wrote:
>2018-01-02 15:08 GMT+01:00 Andrew Lunn <andrew@lunn=2Ech>:
>>> Indeed in of_mdio_bus_register_phy, there is of_irq_get=2E This is
>more
>>> a discussion for a MDIO bus / ACPI patchset, but we either find a
>way
>>> to use IRQs with ACPI obtained from child nodes or for this world
>the
>>> functionality will be limited (at least for the beginning)=2E
>>
>> Hi Marcin
>>
>> What i want to avoid is adding something which partially works, and
>> then have to throw it all away and start again in order to add full
>> support=2E
>>
>> If ACPI really limits interrupts to devices, maybe we need a totally
>> different representation of MDIO and PHYs in ACPI to what it used in
>> device tree? The same may be true for the Ethernet ports of the
>mvpp2?
>> They might have to be represented as real devices, not children of a
>> device? Maybe trying to map DT to ACPI on a one-to-one basis is the
>> wrong approach?
>>
>
>In terms of PP2 controller, I'd prefer to keep as much as possible to
>describing how real hardware looks like, i=2Ee=2E single common controlle=
r
>with multiple ports as its children=2E Those considerations are
>reflected in the DT description shape and how the driver enumerates,
>which was part of the design of the initial support=2E Bending the
>driver (huge amount of shared initialization and resources) to
>multiple instances just for the sake of possible avoidance of IRQ
>description in ACPI is IMO a huge and unnecessary overkill=2E

True, although keep in mind that Device Tree, as implemented in Linux allo=
ws for a lot of flexibility in how parent/child nodes are represented and b=
acked or not by a corresponding struct device=2E I suspect ACPI is much les=
s permissive than that and we might want to have a struct device for the wh=
ole mvpp2 controller as well as for the child ports within that controller =
(something you could today with device tree too, just it would be more over=
head)=2E This does not necessarily have to influence the representation wit=
hin the description language but we should not be biased by how the current=
 implementation using Device Tree has shaped both representation and implem=
entation=2E

--=20
Florian
