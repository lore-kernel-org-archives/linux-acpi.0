From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
Date: Fri, 12 Apr 2019 21:26:41 +0800
Message-ID: <241a0251-3d2d-b304-c103-a6d240e89ce6@huawei.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
 <20190405142112.26592-1-yuehaibing@huawei.com>
 <20190405145009.GD9224@smile.fi.intel.com> <2719325.nu6fPkO1U5@kreacher>
 <CAHp75VccF9-ax8nJ9qOfAFMvLR19K6NqwyePEf-86r4ifMnJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VccF9-ax8nJ9qOfAFMvLR19K6NqwyePEf-86r4ifMnJKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2019/4/12 21:13, Andy Shevchenko wrote:
> On Fri, Apr 12, 2019 at 3:55 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, April 5, 2019 4:50:09 PM CEST Andy Shevchenko wrote:
>>> On Fri, Apr 05, 2019 at 10:21:12PM +0800, Yue Haibing wrote:
>>>> From: YueHaibing <yuehaibing@huawei.com>
>>>>
>>>> When building CONFIG_ACPI is not set
>>>> gcc warn this:
>>>>
>>>> drivers/gpio/gpio-merrifield.c: In function
>>>> mrfld_gpio_get_pinctrl_dev_name: drivers/gpio/gpio-merrifield.c:388:19:
>>>> error: dereferencing pointer to incomplete type struct acpi_device>
>>>>    put_device(&adev->dev);
>>>>
>>>>                    ^
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use
>>>> acpi_dev_get_first_match_dev()") Signed-off-by: YueHaibing
>>>> <yuehaibing@huawei.com>
>>>
>>> Thank you for an update, I have a comment below, but before sending v3, let
>>> Rafael to have a chance to look at it.
>>>
>>>>  #ifdef CONFIG_ACPI
>>>>  extern int acpi_platform_notify(struct device *dev, enum kobject_action
>>>>  action);>
>>>> +
>>>> +static inline void put_acpi_device(struct acpi_device *adev)
>>>> +{
>>>> +   put_device(&adev->dev);
>>>> +}
>>>
>>> This should probably go to acpi_bus.h under acpi_dev_get_first_match_dev().
>>> And talking to Mika we agreed that naming would be better as acpi_dev_put().
>>
>> Agreed on both accounts.
> 
> Thanks!
> YueHaibing, please, send v3 with suggested changes.

Ok.

> 
