From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the driver
Date: Wed, 3 Jan 2018 12:19:02 +0100
Message-ID: <CAPv3WKchh4CHS7x0T_9vJ++=ONK5vtLh8oRN_7fgq0uPH29jwA@mail.gmail.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com> <20171231192354.GB20455@lunn.ch>
 <20180103111611.GB21230@xora-haswell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35430 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbeACLTD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2018 06:19:03 -0500
Received: by mail-it0-f66.google.com with SMTP id f143so1454013itb.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2018 03:19:03 -0800 (PST)
In-Reply-To: <20180103111611.GB21230@xora-haswell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz Nowicki <tn@semihalf.com>

Graeme,

2018-01-03 12:16 GMT+01:00  <graeme.gregory@linaro.org>:
> On Sun, Dec 31, 2017 at 08:23:54PM +0100, Andrew Lunn wrote:
>> > * Modify way of obtaining interrupts - with ACPI they are resources
>> >   bound to struct platform_device and it's not possible to obtain
>> >   them directly from the child node. Hence a formula is used, depending
>> >   on the port_id and number of possible CPUs.
>>
>> Hi Marcin
>>
>> I know nothing about ACPI. Is this limitation with respect to
>> interrupts fundamental to ACPI, or just that nobody has implemented
>> flexible interrupt support yet?
>>
> The infrastructure is there to traverse trees of children, but I don't
> think there any helper functions.
>

Thanks, so if I implement such, do you expect any formal issues that
prevent its acceptance?

Best regards,
Marcin
