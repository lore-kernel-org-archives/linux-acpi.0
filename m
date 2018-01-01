From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the driver
Date: Mon, 1 Jan 2018 11:10:33 +0100
Message-ID: <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com> <20171231192354.GB20455@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:41469 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeAAKKf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jan 2018 05:10:35 -0500
Received: by mail-it0-f67.google.com with SMTP id x28so36260720ita.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jan 2018 02:10:34 -0800 (PST)
In-Reply-To: <20171231192354.GB20455@lunn.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz Nowicki <tn@semihalf>

HI Andrew,

2017-12-31 20:23 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> * Modify way of obtaining interrupts - with ACPI they are resources
>>   bound to struct platform_device and it's not possible to obtain
>>   them directly from the child node. Hence a formula is used, depending
>>   on the port_id and number of possible CPUs.
>
> Hi Marcin
>
> I know nothing about ACPI. Is this limitation with respect to
> interrupts fundamental to ACPI, or just that nobody has implemented
> flexible interrupt support yet?

I think it's a limitation, however it would be great, if some real
ACPI expert was able to give an opinion here. I'd really prefer to
declare IRQ's in the child nodes, but it seems not possible.

>
>> * Until proper MDIO bus and PHY handling with ACPI is established in the
>>   kernel, use only link interrupts feature in the driver.
>
> I think interrupts might be interesting with PHY devices, since they
> are child nodes of the MDIO device....
>

Apart from the phylink's SFP support that may require in-band
management, it's an alternative to the normal PHY handling. Once MDIO
bus + PHYs are supported for ACPI, phylib support will be used instead
of the IRQs, so there should be no problem here.

Best regards,
Marcin
