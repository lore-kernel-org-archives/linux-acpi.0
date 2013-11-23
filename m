From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 2/7] ARM: tegra: add gpiod_lookup table for paz00
Date: Sat, 23 Nov 2013 14:36:36 +0900
Message-ID: <CAAVeFuKBAJS8LyDJ=99ZTWH6j=Z+H-KPAjA0SEWJ9oC5BSbe7w@mail.gmail.com>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com>
 <1385122474-14926-3-git-send-email-mika.westerberg@linux.intel.com> <528FA509.6080907@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <528FA509.6080907@wwwdotorg.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 23, 2013 at 3:40 AM, Stephen Warren <swarren@wwwdotorg.org>=
 wrote:
> On 11/22/2013 05:14 AM, Mika Westerberg wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> This makes it possible to request the gpio descriptors in
>> rfkill-gpio driver regardless of the platform.
>
> Patches 1-3,
> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> All the testing I did was to "cat /sys/kernel/debug/gpios" to make su=
re
> those two GPIOs had been correctly acquired by the driver, and that t=
hey
> changed state as expected via the command-line "rfkill {un,}block" co=
mmands.
>
> However, please note that I had to apply a couple fixes to the gpioli=
b
> core to get this working:
>
> 1)
>
> To solve the following build warning:
>
>> In file included from arch/arm/mach-tegra/board-paz00.c:21:0:
>> include/linux/gpio/driver.h:102:17: warning: =E2=80=98struct of_phan=
dle_args=E2=80=99 declared inside parameter list [enabled by default]
>> include/linux/gpio/driver.h:102:17: warning: its scope is only this =
definition or declaration, which is probably not what you want [enabled=
 by default]
>
> I applied:
>
>
>> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver=
=2Eh
>> index 82eac610ce1a..5133cf29803a 100644
>> --- a/include/linux/gpio/driver.h
>> +++ b/include/linux/gpio/driver.h
>> @@ -5,6 +5,7 @@
>>
>>  struct device;
>>  struct gpio_desc;
>> +struct of_phandle_args;
>>  struct seq_file;
>>
>>  /**
>
> 2)
>
> In order to get the GPIO lookups from the rfkill driver working, I ap=
plied:
>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index ac53a9593662..b73c39f99858 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -2368,7 +2368,7 @@ static struct gpio_desc *gpiod_find(struct dev=
ice *dev, const char *con_id,
>>                               continue;
>>                       }
>>
>> -                     if (chip->ngpio >=3D p->chip_hwnum) {
>> +                     if (chip->ngpio <=3D p->chip_hwnum) {
>>                               dev_warn(dev, "GPIO chip %s has %d GPI=
Os\n",
>>                                        chip->label, chip->ngpio);
>>                               continue;

Mmm. I guess should be blamed for this one. I haven't tested GPIO
platform lookup in a while and this seems to have slipped in at some
point. :( I will send fixup patches to Linus for both issues, thanks
for pointing them out.

Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
