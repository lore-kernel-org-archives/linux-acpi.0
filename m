From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Wed, 24 Apr 2019 12:19:02 +0200
Message-ID: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
 <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
 <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
 <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424100130.GB2654@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 24.04.19 12:01, Mika Westerberg wrote:
> On Wed, Apr 24, 2019 at 11:48:09AM +0200, Jan Kiszka wrote:
>> On 24.04.19 11:45, Mika Westerberg wrote:
>>> On Wed, Apr 24, 2019 at 11:36:58AM +0200, Jan Kiszka wrote:
>>>> OK, there is that table, but what is it supposed to tell me about the
>>>> event and where to hook into it better?
>>> ...
>>>> [02Eh 0046   2]                SCI Interrupt : 0009
>>>
>>> This is the SCI interrupt GSI number. IIRC it maps 1:1 to Linux
>>> interrupt number so you should see it in /proc/interrupts. When a GPE
>>> event is triggered it should be handled in the ACPI core.
>>>
>>
>> Yes, clear, all this happens already. But I need to link the core with the
>> sch gpio handler so that the gpio event is filtered out and the right
>> virtual gpio interrupt is triggered. So, other than
>> acpi_install_sci_handler, how should I establish that link?
> 
> I think what you want is "GPIO signaled ACPI event". It works so that
> you declare _AEI method below the GPIO controller listing the GPIOs you
> want to trigger events for and then either _Lxx, _Exx or _EVT method for
> each of them under the same controller. GPIO core then handles it
> automatically when you register the GPIO chip. See also
> acpi_gpiochip_request_interrupts().
> 

Right, that is was I read as well. Let's assume I would be able to patch the 
tables: Would I describe all the logic of this patch in ACPI terms? Where to 
enable interrupts, how to dispatch the SCI event, how to acknowledge it etc.? 
Will it also take care of locking? (BTW, my locking seems to have some remaining 
inconsistency, on second look.)

And even if that were possible, we would be back to the square of existing 
devices without those definitions. If this were a recent chipset, I would say, 
"go, fix future firmware versions". But this one is legacy.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
