From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH v2 4/5] net: mvpp2: use device_*/fwnode_* APIs
 instead of of_*
Date: Mon, 1 Jan 2018 11:04:30 +0100
Message-ID: <CAPv3WKfiR_ekc-ODPfYWDkP0UG0znRxsTCr6FPePgZVXB5J_zw@mail.gmail.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-5-git-send-email-mw@semihalf.com> <20171231191836.GA20455@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33637 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeAAKEc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jan 2018 05:04:32 -0500
Received: by mail-io0-f170.google.com with SMTP id t63so9352592iod.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jan 2018 02:04:31 -0800 (PST)
In-Reply-To: <20171231191836.GA20455@lunn.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz Nowicki <tn@semihalf>

Hi Andrew,

2017-12-31 20:18 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> On Sun, Dec 31, 2017 at 12:58:39PM +0100, Marcin Wojtas wrote:
> Hi Marcin
>
>> Because there is no equivalent for for_each_available_child_of_node(),
>> use device_for_each_child_node() and check the port availability
>> inside the mvpp2_port_probe() routine.
>
> Could device_each_available_child_node() be added? I guess this will
> not be the last driver converted in this way, and having that macro
> will help with future ports.
>

Sure, I can add it in the next round.

Thanks,
Marcin
