From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Tue, 9 Jan 2018 11:22:00 +0100
Message-ID: <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
References: <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell> <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell> <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell> <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell> <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com> <20180109101941.GD31502@xora-haswell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:47094 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeAIKWB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jan 2018 05:22:01 -0500
Received: by mail-io0-f169.google.com with SMTP id z130so17962855ioe.13
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2018 02:22:01 -0800 (PST)
In-Reply-To: <20180109101941.GD31502@xora-haswell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nadavh@marvell.co>

2018-01-09 11:19 GMT+01:00 Graeme Gregory <graeme.gregory@linaro.org>:
> On Mon, Jan 08, 2018 at 06:17:06PM +0100, Marcin Wojtas wrote:
>> Hi Andrew,
>>
>>
>>
>> 2018-01-08 16:42 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> > w> I am not familiar with MDIO, but if its similar or a specific
>> >> implementation of a serial bus that does sound sane!
>> >
>>
>> Thanks for digging, I will check if and how we can use
>> GenericSerialBus with MDIO.
>>
> Maybe Lorenzo, Hanjun, Sudeep can comment here they might have come
> across similar on other ARM boards.
>

I'm looking forward to their feedback, however, what I've noticed,
each driver handles mdio/phys on its own, not using any generic
solution, which is what I need to actually avoid :)

Best regards,
Marcin
