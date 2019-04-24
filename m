From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Wed, 24 Apr 2019 16:24:16 +0200
Message-ID: <0bb42b3e-58cc-a11c-b8ad-fec67da477b4@siemens.com>
References: <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190424104613.GD2654@lahna.fi.intel.com>
 <761ed823-58f4-d166-c415-6b100b1fe615@siemens.com>
 <20190424131357.GJ2654@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424131357.GJ2654@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 24.04.19 15:13, Mika Westerberg wrote:
> On Wed, Apr 24, 2019 at 02:41:02PM +0200, Jan Kiszka wrote:
>> On 24.04.19 12:46, Mika Westerberg wrote:
>>> On Wed, Apr 24, 2019 at 12:39:35PM +0200, Jan Kiszka wrote:
>>>> On 24.04.19 12:33, Mika Westerberg wrote:
>>>>> On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:
>>>>>>> I think what you want is "GPIO signaled ACPI event". It works so that
>>>>>>> you declare _AEI method below the GPIO controller listing the GPIOs you
>>>>>>> want to trigger events for and then either _Lxx, _Exx or _EVT method for
>>>>>>> each of them under the same controller. GPIO core then handles it
>>>>>>> automatically when you register the GPIO chip. See also
>>>>>>> acpi_gpiochip_request_interrupts().
>>>>>>
>>>>>> Right, that is was I read as well. Let's assume I would be able to patch the
>>>>>> tables: Would I describe all the logic of this patch in ACPI terms? Where to
>>>>>> enable interrupts, how to dispatch the SCI event, how to acknowledge it
>>>>>> etc.? Will it also take care of locking? (BTW, my locking seems to have some
>>>>>> remaining inconsistency, on second look.)
>>>>>
>>>>> The GPIO core would then take care of it by requesting the GPIO in
>>>>> question and dispatching to the correct event handler. In this patch you
>>>>> just leave out the SCI part and only implement the irqchip like you did
>>>>> already.
>>>>
>>>> Could you point me to a gpio driver that works like that already? Would be
>>>> easier to learn that from an example. That infrastructure with all its
>>>> different modes is seriously complex and not very well documented.
>>>
>>> Pretty much all drivers under drivers/pinctrl/intel.
>>
>> OK... that's a purely descriptive way. So, provided we had such ACPI table
>> entries, that plus some corresponding pinctrl driver would obsolete
>> gpio-sch.c? Or are there other reason than historical ones for having
>> gpio-*ch.c drivers around?
> 
> No they are for different hardware. The GPIO core will parse necessary
> ACPI entires when any GPIO driver (with ACPI description) calls
> gpiochip_add_data() or any of the wrappers.
> 
>>>>>> And even if that were possible, we would be back to the square of existing
>>>>>> devices without those definitions. If this were a recent chipset, I would
>>>>>> say, "go, fix future firmware versions". But this one is legacy.
>>>>>
>>>>> Is it fixing some real issue with these legacy platforms? I mean without
>>>>> the patch some GPE event is not handled properly? It was not clear to me
>>>>> from the commit message.
>>>>>
>>>> Without that patch, you are forced to poll for event changes in your
>>>> application, timer-driven. There are application that cannot process these
>>>> GPIOs because they lack such logic (mraa with node-red-node-intel-gpio is a
>>>> public example).
>>>
>>> But those are using the GPIOs via sysfs or the char device which should
>>> work without the SCI handling part of your patch, no?
>>
>> They work via sysfs. How would the char dev compensate the missing interrupt
>> support?
> 
> I'm trying to say that for the sysfs access (well or char dev) you
> should not need the sch_sci_handler() thing that is in your current
> patch.

Then I'm still missing the black magic where - in my case - CGTS or RGTS are 
read, evaluated and written back.

And we would still need the gpio-sch driver to handle GGPE, GTNE, GTPE when edge 
events are requested? Is the a reference for /such/ a case? The newer Intels 
must be different then.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
