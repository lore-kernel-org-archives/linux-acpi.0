From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 2/2] ACPI, PCI, ISA: Fix memory leak when there is no
 IRQ in the ACPI subsystem.
Date: Wed, 19 Feb 2014 11:26:47 +0100
Message-ID: <530486E7.8040100@linaro.org>
References: <1392037211-29349-1-git-send-email-tomasz.nowicki@linaro.org> <87065822.vfIc9IskHH@vostro.rjw.lan> <53033433.7080002@linaro.org> <1444429.LQSjxavlaG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444429.LQSjxavlaG@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 18.02.2014 16:26, Rafael J. Wysocki wrote:
> On Tuesday, February 18, 2014 11:21:39 AM Tomasz Nowicki wrote:
>> On 18.02.2014 02:02, Rafael J. Wysocki wrote:
>>> On Monday, February 10, 2014 02:00:11 PM Tomasz Nowicki wrote:
>>>> Whenever we register ISA interrupt or not, we need to free the IRQ routing
>>>> table entry.
>>>>
>>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>> ---
>>>>    drivers/acpi/pci_irq.c |    1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>>>> index b0e31b6..6ec0f36 100644
>>>> --- a/drivers/acpi/pci_irq.c
>>>> +++ b/drivers/acpi/pci_irq.c
>>>> @@ -432,6 +432,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>>>>    #endif
>>>>    		dev_warn(&dev->dev, "PCI INT %c: no GSI\n", pin_name(pin));
>>>>
>>>> +		kfree(entry);
>>>
>>> If I'm not mistaken, entry is always NULL here, isn't it?
>>
>> acpi_pci_link_allocate_irq() can return negative gsi even if entry !=
>> NULL. For that case we'd have memory leak.
>
> And that's what your changelog should be saying, isn't it?
It should, sorry.
>
> Queued up for 3.14 and marked for -stable.  I had to rebase it, though, so
> please check the result in linux-pm.git/linux-next.
It's OK. Thanks.

Tomasz
