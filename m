From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation region
 driver
Date: Thu, 8 Jun 2017 09:03:50 +0200
Message-ID: <00ae0f71-a83e-ff54-eaad-77e835e1dba7@redhat.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
 <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
 <CAHp75Vef=c54O8Xd+aM+eWWVt7nLsczT48WbgrdiOVyWv6xMcg@mail.gmail.com>
 <20170607201050.GE1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170607201050.GE1019@valkosipuli.retiisi.org.uk>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 07-06-17 22:10, Sakari Ailus wrote:
> Hi Andy,
> 
> On Wed, Jun 07, 2017 at 04:40:13PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 7, 2017 at 3:15 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>>> On Tue, Jun 06, 2017 at 05:23:56PM +0300, Andy Shevchenko wrote:
>>>> Follow the pattern, please, I suppose
>>>> ti_pmic_tps68470.c
>>>
>>> This pattern is weird. "ti" in front of the file name is redundant, and in
>>> very few places the vendor prefix is used anyway. Especially when the chip
>>> has a proper name --- as this one does.
>>>
>>> I assume for the Intel PMICs it could be there for a couple of reasons which
>>> are
>>>
>>> 1) lack of a clearly unique chip ID and
>>>
>>> 2) the use of common frameworklet for Intel PMICs.
>>>
>>> There are also no other PMIC chips supported currently.
>>>
>>> The pmic_tps68470 naming is in line with the GPIO driver (apart from the
>>> dash / underscore difference).
>>
>> Since
>>
>> % git ls-files *pmic*
>>
>> returns somewhat interesting results, I would even go further and use
>>
>> tps68470.c here
>>
>> and
>>
>> s/ti_pmic/tps6840/g
>>
>> inside the file.
>>
>> Would it work for you?
> 
> This is still a different driver from the tps68470 driver which is an MFD
> driver. For clarity, I'd keep pmic as part of the name (and I'd use
> tps68470_pmic_ prefix for internal symbols, too).
> 
> As PMICs are typically linked to the kernel (vs. being modules), there's no
> issue with the module name. I would suppose few if any PMICs will be
> compiled as modules in general.

Good point about the OpRegion driver usually being built-in, in my experience
it MUST always be built-in, so the Kconfig option should be a bool. Note this
is useless unless the mfd driver is also a bool (I would advice to go that
route) and the mfd driver's Kconfig should select the right i2c bus driver
to make sure that is built-in too, see for example:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=2f91ded5f8f4fdd67d8daae514b0d434c98ab1e0
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=c5065d8625ebdc164199b99d838ac0636faa7f0b
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=5f125f1f570568a29edf783fba1ebb606d5c6b24

Which are all recent commits from me dealing with making the mfd driver
built-in / selecting the i2c bus driver.

Regards,

Hans
