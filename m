From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v6 03/22] of/platform: Point to struct device from device node
Date: Tue, 22 Sep 2015 08:45:51 +0200
Message-ID: <CAAObsKA85fbnt5ENM8_rfpoNV777ySRe=weWYBgy8tLPxu5jZg@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-4-git-send-email-tomeu.vizoso@collabora.com> <CAL_JsqK5CH+a-xQYcocqPb0XqV3F1shC48YQxsTFf9sXjx_xHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqK5CH+a-xQYcocqPb0XqV3F1shC48YQxsTFf9sXjx_xHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 22 September 2015 at 02:39, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Sep 21, 2015 at 9:02 AM, Tomeu Vizoso
> <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
>> When adding platform and AMBA devices, set the device node's device
>> member to point to it.
>>
>> This speeds lookups considerably and is safe because we only create one
>> of these devices for any given device node.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>
>> Changes in v5:
>> - Set the pointer to struct device also for AMBA devices
>> - Unset the pointer to struct device when the platform device is about
>>   to be unregistered
>> - Increase the reference count of the device before returning from
>>   of_find_device_by_node()
>>
>>  drivers/of/platform.c | 19 ++++++++++---------
>>  include/linux/of.h    |  1 +
>>  2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 1001efaedcb8..408d89f1d124 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -32,11 +32,6 @@ const struct of_device_id of_default_bus_match_table[] = {
>>         {} /* Empty terminated list */
>>  };
>>
>> -static int of_dev_node_match(struct device *dev, void *data)
>> -{
>> -       return dev->of_node == data;
>> -}
>> -
>>  /**
>>   * of_find_device_by_node - Find the platform_device associated with a node
>>   * @np: Pointer to device tree node
>> @@ -45,10 +40,10 @@ static int of_dev_node_match(struct device *dev, void *data)
>>   */
>>  struct platform_device *of_find_device_by_node(struct device_node *np)
>>  {
>> -       struct device *dev;
>> -
>> -       dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
>> -       return dev ? to_platform_device(dev) : NULL;
>> +       if (np->device && np->device->bus == &platform_bus_type &&
>> +           get_device(np->device))
>
> Where do we drop the reference incremented by get_device?
>
> However, bus_find_device also took a reference I think, so you aren't
> really changing behavior.

Yeah, Intel's 0day build bot warned of the missing get_device() when
running the OF unittests.

Regards,

Tomeu

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
