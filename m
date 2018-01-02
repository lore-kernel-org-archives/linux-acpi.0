From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the driver
Date: Tue, 2 Jan 2018 16:05:35 +0100
Message-ID: <CAPv3WKdD0HwdFVOBx-yeTCfcMF7DXxxFaUt+Zm06oxuVuty8Rg@mail.gmail.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com> <20171231192354.GB20455@lunn.ch>
 <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
 <20180102133347.GB15036@lunn.ch> <CAPv3WKfB6_5hPw2M_GOMHVc_soPyzgMqQJ=tG5qOfSe_397z9A@mail.gmail.com>
 <20180102140852.GE15036@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:44770 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeABPFg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jan 2018 10:05:36 -0500
Received: by mail-it0-f52.google.com with SMTP id b5so38990317itc.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jan 2018 07:05:36 -0800 (PST)
In-Reply-To: <20180102140852.GE15036@lunn.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz Nowicki <tn@semihalf>

2018-01-02 15:08 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> Indeed in of_mdio_bus_register_phy, there is of_irq_get. This is more
>> a discussion for a MDIO bus / ACPI patchset, but we either find a way
>> to use IRQs with ACPI obtained from child nodes or for this world the
>> functionality will be limited (at least for the beginning).
>
> Hi Marcin
>
> What i want to avoid is adding something which partially works, and
> then have to throw it all away and start again in order to add full
> support.
>
> If ACPI really limits interrupts to devices, maybe we need a totally
> different representation of MDIO and PHYs in ACPI to what it used in
> device tree? The same may be true for the Ethernet ports of the mvpp2?
> They might have to be represented as real devices, not children of a
> device? Maybe trying to map DT to ACPI on a one-to-one basis is the
> wrong approach?
>

In terms of PP2 controller, I'd prefer to keep as much as possible to
describing how real hardware looks like, i.e. single common controller
with multiple ports as its children. Those considerations are
reflected in the DT description shape and how the driver enumerates,
which was part of the design of the initial support. Bending the
driver (huge amount of shared initialization and resources) to
multiple instances just for the sake of possible avoidance of IRQ
description in ACPI is IMO a huge and unnecessary overkill.

Anyway, I'll do a more research on the resources / ACPI representation
and will get back with some conclusions. I hope that someone from this
thread recipents will be able to give some advice too :)

Best regards,
Marcin
