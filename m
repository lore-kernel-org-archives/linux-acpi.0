From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Wed, 30 Dec 2015 15:28:24 +0200
Message-ID: <CAHp75Ve5x3xmHpC4Ku4OXiXW6UHQqi1vLyzE7XSBhh+=zeeGgQ@mail.gmail.com>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
	<1449677909-12432-2-git-send-email-okaya@codeaurora.org>
	<CAHp75VeW7wizf_FUc=O5+PEdfibYRL1G7gqpdDxUALwXJsnBAA@mail.gmail.com>
	<56686037.70109@codeaurora.org>
	<56686171.5060102@codeaurora.org>
	<5683DAD3.4080006@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5683DAD3.4080006@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Christopher Covington <cov@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, jcm@redhat.com, helgaas@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 30, 2015 at 3:23 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/9/2015 12:14 PM, Christopher Covington wrote:
>>> On 12/9/2015 11:59 AM, Andy Shevchenko wrote:

>>>>> +       if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>>>>>> +           polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>>>>>> +               penalty = PIRQ_PENALTY_ISA_ALWAYS;
>>>>>> +       else
>>>>>> +               penalty = PIRQ_PENALTY_PCI_USING;
>>>>>> +
>>>>>> +       acpi_irq_add_penalty(irq, penalty);

>>>> Why not to change in place? I think a common sense rule is not to
>>>> change something existing if it doesn't add any significant value.

>>>> -               acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
>>>> +              acpi_irq_add_penalty(irq, PIRQ_PENALTY_PCI_USING);
>>
>> I think Andy was suggesting that you make the change without introducing
>> the penalty variable.

> Is Chris' interpretation correct?

Yep, I meant not to use an additional variable.

> BTW, I suggest you spend some time around checkpatch for contributions. I could
> have caught most of the issues you are generally concerned before submitting a patch.

Is it a question?

-- 
With Best Regards,
Andy Shevchenko
