From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Fri, 24 Jan 2014 08:12:24 +0800
Message-ID: <52E1AFE8.40601@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org> <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:56930 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaAXAMk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jan 2014 19:12:40 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so2519089pab.40
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jan 2014 16:12:40 -0800 (PST)
In-Reply-To: <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Patch Tracking <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>

Hi Linus,

Sorry for the late reply.

On 2014=E5=B9=B401=E6=9C=8822=E6=97=A5 16:26, Linus Walleij wrote:
> On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org> w=
rote:
>
>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>
>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>> name from the ACPI timer table is matched with all the registered
>> timer controllers and matching initialisation routine is invoked.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
> to TIMER_OF_DECLARE() and I think this macro, if needed, should
> be named TIMER_ACPI_DECLARE().
>
> The reason is that "clocksource" is a Linux-internal name and this
> macro pertains to the hardware name in respective system
> description type.

That make sense to me too, I will update in next version if
this patch is still needed.

>
>> +#ifdef CONFIG_ACPI
>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)                 =
    \
>> +       static const struct acpi_device_id __clksrc_acpi_table_##nam=
e   \
>> +               __used __section(__clksrc_acpi_table)               =
    \
>> +                =3D { .id =3D compat,                              =
\
>> +                    .driver_data =3D (kernel_ulong_t)fn }
>> +#else
>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
>> +#endif
> This hammers down the world to compile one binary for ACPI
> and one binary for device tree. Maybe that's fine, I don't know.

This is a problem we can have some discussion on it.
I prefer mutually exclusive ACPI and DT support.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
