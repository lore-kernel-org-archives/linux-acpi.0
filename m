From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: unregister interrupts during shutdown
Date: Thu, 7 Dec 2017 18:10:23 +0100
Message-ID: <CAJZ5v0g7APeWHkL+c5LT7sx4xpZn=TxCSpt5y=DU7yOiyUkNRg@mail.gmail.com>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0hEdK_vJcHeoz=Z2H6od=bktspPpTo37Y6qiOT2qptnaA@mail.gmail.com>
 <20171207082958.GA11882@kroah.com> <2960222.F3CtrQ5k26@aspire.rjw.lan> <e17a3ac6-aac3-09ee-7307-01ddc780507a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <e17a3ac6-aac3-09ee-7307-01ddc780507a@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 7, 2017 at 3:52 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Rafael,
>
> On 12/7/2017 8:00 AM, Rafael J. Wysocki wrote:
>>> Just don't use devm_request_threaded_irq()?  :)
>>>
>>> Seriously, those are just "helper" functions if your code happens to
>>> follow the pattern they provide, if not, then don't use them, it's not
>>> that hard to provide the correct code to unwind things properly by "open
>>> coding" this logic as needed.
>>>
>>> The devm_*irq() functions are known for not being able to be used all of
>>> the time for lots of shutdown and cleanup issues, this isn't the first
>>> time it has happened, which is why we are very careful when taking
>>> "cleanup" patches that use those functions.
>> I see, thanks for the clarification.
>>
>> OK, we'll need to rework the driver somewhat, then.
>
> Even if we got rid of devm_*irq() functions, I see that the free_irq() function
> requires dev_id argument.
>
>          * There can be multiple actions per IRQ descriptor, find the right
>          * one based on the dev_id:
>
> I still need to keep track of the dev_ids attached to request_irq() functions.

Right.

> My take away from the discussion is:
> 1. don't use devm family of functions for IRQ registration/free
> 2. still keep track of the events
> 3. call free_irq on shutdown.

Yes.  And on remove too.

Thanks,
Rafael
