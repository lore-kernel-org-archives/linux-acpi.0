From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Fri, 24 Jan 2014 08:20:46 +0800
Message-ID: <52E1B1DE.5050507@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org> <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com> <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46237 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaAXAVF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jan 2014 19:21:05 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so2542911pad.39
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jan 2014 16:21:04 -0800 (PST)
In-Reply-To: <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Patch Tracking <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>

On 2014=E5=B9=B401=E6=9C=8822=E6=97=A5 19:45, Mark Rutland wrote:
> On Wed, Jan 22, 2014 at 08:26:50AM +0000, Linus Walleij wrote:
>> On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org> =
wrote:
>>
>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>
>>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>>> name from the ACPI timer table is matched with all the registered
>>> timer controllers and matching initialisation routine is invoked.
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
>> to TIMER_OF_DECLARE() and I think this macro, if needed, should
>> be named TIMER_ACPI_DECLARE().
>>
>> The reason is that "clocksource" is a Linux-internal name and this
>> macro pertains to the hardware name in respective system
>> description type.
>>
>>> +#ifdef CONFIG_ACPI
>>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)                =
     \
>>> +       static const struct acpi_device_id __clksrc_acpi_table_##na=
me   \
>>> +               __used __section(__clksrc_acpi_table)              =
     \
>>> +                =3D { .id =3D compat,                             =
 \
>>> +                    .driver_data =3D (kernel_ulong_t)fn }
>>> +#else
>>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
>>> +#endif
>> This hammers down the world to compile one binary for ACPI
>> and one binary for device tree. Maybe that's fine, I don't know.
> How does it do that?
>
> As far as I could tell CONFIG_ACPI and CONFIG_OF are not mutually
> exclusive, and this just means that we only build the datastructures =
for
> matching from ACPI when CONFIG_ACPI is enabled.
>
> Have I missed something?
>
> I definitely don't want to see mutually exclusive ACPI and DT support=
=2E

ACPI and DT did the same job so I think they should mutually exclusive.
if we enable both DT and ACPI in one system, this will leading confusio=
ns.

=46urther more, firmware guys will be happy to present all the devices
in one way, not both of them.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
