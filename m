From: Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 12/13] leds: leds-gpio: Make use of device property API
Date: Wed, 8 Oct 2014 10:47:16 -0700
Message-ID: <CAK5ve-JTri0ML23gdXTgfRPh+tkJGUj6jHcjEKEVNphwG-PQjw@mail.gmail.com>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <1997643.hzLDnYTZoH@vostro.rjw.lan>
 <2960802.kPr8UT7PvT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2960802.kPr8UT7PvT-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 8, 2014 at 7:04 AM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> On Tuesday, October 07, 2014 02:18:45 AM Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> Make use of device property API in this driver so that both OF and ACPI
>> based system can use the same driver.
>>
>> This change contains material from Max Eliaser and Mika Westerberg.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> Bryan, can you please tell me if you are OK with this patch?
>
> You said you were for one of the previous versions if I remember correctly,
> but it's changed quite a bit since then, so can you please check this new
> version too?
>

Sure, the new one is even better than before. Please go ahead with my Ack
Acked-by: Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks,
-Bryan

>> ---
>>  drivers/leds/leds-gpio.c |   67 +++++++++++++++++++++--------------------------
>>  1 file changed, 30 insertions(+), 37 deletions(-)
>>
>> Index: linux-pm/drivers/leds/leds-gpio.c
>> ===================================================================
>> --- linux-pm.orig/drivers/leds/leds-gpio.c
>> +++ linux-pm/drivers/leds/leds-gpio.c
>> @@ -15,13 +15,11 @@
>>  #include <linux/gpio.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/leds.h>
>> -#include <linux/of.h>
>> -#include <linux/of_platform.h>
>> -#include <linux/of_gpio.h>
>>  #include <linux/slab.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/module.h>
>>  #include <linux/err.h>
>> +#include <linux/property.h>
>>
>>  struct gpio_led_data {
>>       struct led_classdev cdev;
>> @@ -171,40 +169,41 @@ static inline int sizeof_gpio_leds_priv(
>>               (sizeof(struct gpio_led_data) * num_leds);
>>  }
>>
>> -/* Code to create from OpenFirmware platform devices */
>> -#ifdef CONFIG_OF_GPIO
>> -static struct gpio_leds_priv *gpio_leds_create_of(struct platform_device *pdev)
>> +static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>>  {
>> -     struct device_node *np = pdev->dev.of_node, *child;
>> +     struct device *dev = &pdev->dev;
>>       struct gpio_leds_priv *priv;
>>       int count, ret;
>> +     void *child;
>>
>> -     /* count LEDs in this device, so we know how much to allocate */
>> -     count = of_get_available_child_count(np);
>> +     count = device_get_child_node_count(dev);
>>       if (!count)
>>               return ERR_PTR(-ENODEV);
>>
>> -     for_each_available_child_of_node(np, child)
>> -             if (of_get_gpio(child, 0) == -EPROBE_DEFER)
>> -                     return ERR_PTR(-EPROBE_DEFER);
>> -
>> -     priv = devm_kzalloc(&pdev->dev, sizeof_gpio_leds_priv(count),
>> -                     GFP_KERNEL);
>> +     priv = devm_kzalloc(dev, sizeof_gpio_leds_priv(count), GFP_KERNEL);
>>       if (!priv)
>>               return ERR_PTR(-ENOMEM);
>>
>> -     for_each_available_child_of_node(np, child) {
>> +     device_for_each_child_node(dev, child) {
>>               struct gpio_led led = {};
>> -             enum of_gpio_flags flags;
>> -             const char *state;
>> +             const char *state = NULL;
>> +
>> +             led.gpiod = devm_get_named_gpiod_from_child(dev, child,
>> +                                                         "gpios", 0);
>> +             if (IS_ERR(led.gpiod)) {
>> +                     device_put_child_node(dev, child);
>> +                     goto err;
>> +             }
>>
>> -             led.gpio = of_get_gpio_flags(child, 0, &flags);
>> -             led.active_low = flags & OF_GPIO_ACTIVE_LOW;
>> -             led.name = of_get_property(child, "label", NULL) ? : child->name;
>> -             led.default_trigger =
>> -                     of_get_property(child, "linux,default-trigger", NULL);
>> -             state = of_get_property(child, "default-state", NULL);
>> -             if (state) {
>> +             device_child_property_read_string(dev, child,
>> +                                               "label", &led.name);
>> +             device_child_property_read_string(dev, child,
>> +                                               "linux,default-trigger",
>> +                                               &led.default_trigger);
>> +
>> +             if (!device_child_property_read_string(dev, child,
>> +                                                    "linux,default_state",
>> +                                                    &state)) {
>>                       if (!strcmp(state, "keep"))
>>                               led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
>>                       else if (!strcmp(state, "on"))
>> @@ -213,13 +212,14 @@ static struct gpio_leds_priv *gpio_leds_
>>                               led.default_state = LEDS_GPIO_DEFSTATE_OFF;
>>               }
>>
>> -             if (of_get_property(child, "retain-state-suspended", NULL))
>> +             if (!device_get_child_property(dev, child,
>> +                                            "retain-state-suspended", NULL))
>>                       led.retain_state_suspended = 1;
>>
>>               ret = create_gpio_led(&led, &priv->leds[priv->num_leds++],
>> -                                   &pdev->dev, NULL);
>> +                                   dev, NULL);
>>               if (ret < 0) {
>> -                     of_node_put(child);
>> +                     device_put_child_node(dev, child);
>>                       goto err;
>>               }
>>       }
>> @@ -238,13 +238,6 @@ static const struct of_device_id of_gpio
>>  };
>>
>>  MODULE_DEVICE_TABLE(of, of_gpio_leds_match);
>> -#else /* CONFIG_OF_GPIO */
>> -static struct gpio_leds_priv *gpio_leds_create_of(struct platform_device *pdev)
>> -{
>> -     return ERR_PTR(-ENODEV);
>> -}
>> -#endif /* CONFIG_OF_GPIO */
>> -
>>
>>  static int gpio_led_probe(struct platform_device *pdev)
>>  {
>> @@ -273,7 +266,7 @@ static int gpio_led_probe(struct platfor
>>                       }
>>               }
>>       } else {
>> -             priv = gpio_leds_create_of(pdev);
>> +             priv = gpio_leds_create(pdev);
>>               if (IS_ERR(priv))
>>                       return PTR_ERR(priv);
>>       }
>> @@ -300,7 +293,7 @@ static struct platform_driver gpio_led_d
>>       .driver         = {
>>               .name   = "leds-gpio",
>>               .owner  = THIS_MODULE,
>> -             .of_match_table = of_match_ptr(of_gpio_leds_match),
>> +             .of_match_table = of_gpio_leds_match,
>>       },
>>  };
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
