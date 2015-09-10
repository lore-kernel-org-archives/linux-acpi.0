From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
Date: Thu, 10 Sep 2015 16:53:32 +0200
Message-ID: <CAAObsKAgkisWtZospL-z0F7RvnqR8yQgxL74Wxrcg96jxut-mg@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com> <55EF8B74.7090909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:32934 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbIJOxx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2015 10:53:53 -0400
In-Reply-To: <55EF8B74.7090909@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>

On 9 September 2015 at 03:29, Rob Herring <robh@kernel.org> wrote:
> On 09/07/2015 07:23 AM, Tomeu Vizoso wrote:
>> Walks the OF tree up and finds the closest ancestor that has a struct
>> device associated with it, probing it if isn't bound to a driver yet.
>>
>> The above should ensure that the dependency represented by the passed OF
>> node is available, because probing a device should cause its descendants
>> to be probed as well (when they get registered).
>>
>> Subsystems can use this when looking up resources for drivers, to reduce
>> the chances of deferred probes because of the probing order of devices.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> Looks pretty good to me. One comment below.
>
> [...]
>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index baf04d7249bd..f089d95ac961 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -269,6 +269,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>               goto err_free;
>>       }
>>
>> +     node->device = &dev->dev;
>> +
>
> This seems oddly placed. Can you move to patch 3?

Sure, no problem. Besides this, are you ok with the rest of the series?

Regards,

Tomeu

>>       return dev;
>>
>>  err_free:
>> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
>> index cc7dd687a89d..da8d489e73ad 100644
>> --- a/include/linux/of_device.h
>> +++ b/include/linux/of_device.h
>> @@ -40,6 +40,7 @@ extern ssize_t of_device_get_modalias(struct device *dev,
>>
>>  extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
>>  extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
>> +extern void of_device_probe(struct device_node *np);
>>
>>  static inline void of_device_node_put(struct device *dev)
>>  {
>> @@ -84,6 +85,8 @@ static inline int of_device_uevent_modalias(struct device *dev,
>>       return -ENODEV;
>>  }
>>
>> +static inline void of_device_probe(struct device_node *np) { }
>> +
>>  static inline void of_device_node_put(struct device *dev) { }
>>
>>  static inline const struct of_device_id *__of_match_device(
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
