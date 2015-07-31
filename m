From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v2 01/22] platform: delay device-driver matches until late_initcall
Date: Fri, 31 Jul 2015 12:06:38 +0200
Message-ID: <CAAObsKBSKvR=1VPU7-E89my76FYbjVp7uDNsD2PGiVDJe89r1g@mail.gmail.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-2-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+SBGFNHR+T15FSMsqh-TWaNBMqesxZfXKiH8g9mqXYuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33291 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbGaKHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2015 06:07:00 -0400
In-Reply-To: <CAL_Jsq+SBGFNHR+T15FSMsqh-TWaNBMqesxZfXKiH8g9mqXYuQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 30 July 2015 at 05:20, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 8:19 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> Delay matches of platform devices until late_initcall, when we are sure
>> that all built-in drivers have been registered already.  This is needed
>> to prevent deferred probes because of some drivers not having registered
>> yet.
>>
>> The reason why only platform devices are delayed is that some other
>> devices are expected to be probed earlier than late_initcall, for
>> example, the system PNP driver needs to probe its devices in
>> fs_initcall.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>
>> Changes in v2:
>> - Move delay to platform.c
>>
>>  drivers/base/platform.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 063f0ab15259..fcf654678e27 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -33,6 +33,8 @@
>>  /* For automatically allocated device IDs */
>>  static DEFINE_IDA(platform_devid_ida);
>>
>> +static bool enable_matches;
>> +
>>  struct device platform_bus = {
>>         .init_name      = "platform",
>>  };
>> @@ -839,6 +841,15 @@ static int platform_match(struct device *dev, struct device_driver *drv)
>>         struct platform_device *pdev = to_platform_device(dev);
>>         struct platform_driver *pdrv = to_platform_driver(drv);
>>
>> +       /*
>> +        * Delay matches of platform devices until late_initcall, when we are
>> +        * sure that all built-in drivers have been registered already. This
>> +        * is needed to prevent deferred probes because of some drivers
>> +        * not having registered yet.
>> +        */
>> +       if (!enable_matches)
>> +               return false;
>> +
>
> Having this as a global makes me nervous. I think it would be better
> to be DT specific or per device some how. Perhaps use OF_POPULATED_BUS
> flag as an additional test.

I see no problem with restricting this to platform devices with an
of_node (or a fwnode if we still want to address machines with ACPI).

> There could be non-DT platforms that rely on the initcall ordering and
> moving all probes to late_initcall could change the ordering. I'm not
> sure though.

Yeah, I'm not sure how much that could be a problem. Maybe if a
non-platform device has a match and probes before a platform device
that has been delayed and is a dependency of it. That could be a
problem in platforms that don't do on-demand probing because of the
lack of firmware data.

Thanks,

Tomeu

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
