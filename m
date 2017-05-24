From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Wed, 24 May 2017 14:10:17 +0200
Message-ID: <ac3f6fd1-7994-341d-9b4c-25afd0c25601@redhat.com>
References: <20170524104216.23643-1-hdegoede@redhat.com>
 <1495625003.6967.93.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756943AbdEXMKU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 May 2017 08:10:20 -0400
In-Reply-To: <1495625003.6967.93.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

Hi,

On 24-05-17 13:23, Andy Shevchenko wrote:
> On Wed, 2017-05-24 at 12:42 +0200, Hans de Goede wrote:
>> Some peripherals on Bay Trail and Cherry Trail platforms signal PME to
>> the
>> PMC to wakeup the system. When this happens software needs to clear
>> the
>> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ
>> 9.
>>
>> This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.
>>
>> This commit adds a driver which registers the Virtual GPIOs expected
>> by the DSDT on these devices, letting gpiolib-acpi claim the
>> virtual GPIO and install a GPIO-interrupt handler which call the _L02
>> handler as it would for a real GPIO controller.
>>
>> Cc: joeyli <jlee@suse.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> In addition to my comment to v4 (if you are going to apply it) couple of
> nits below. (I'm fine with current version, as tag says, though consider
> them anyway)

I prefer to stick with the current version (v5) unless something
bigger comes up.

Regards,

Hans



> 
>> +#define GPE0A_PME_B0_STS_BIT		BIT(13)
>> +#define GPE0A_PME_B0_EN_BIT		BIT(13)
>> +#define GPE0A_STS_PORT			0x420
>> +#define GPE0A_EN_PORT			0x428
> 
> Perhaps squeeze bits after actual ports like
> 
> ADDRESSa
> ADDRa_BITa
> 
> ADDRESSb
> ADDRb_BITa
> 
>> +	for (i = 0; i < GPE0A_PME_B0_VIRT_GPIO_PIN; i++)
>> +		clear_bit(i, chip->irq_valid_mask);
> 
> bitmap_zero() ?
> 
