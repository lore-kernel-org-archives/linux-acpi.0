From: okaya@codeaurora.org
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Thu, 12 Nov 2015 15:54:21 -0000
Message-ID: <0ef6f6fb8bdce49101ec60ca464f9118.squirrel@www.codeaurora.org>
References: <1447308882-29634-1-git-send-email-okaya@codeaurora.org>
    <1447308882-29634-2-git-send-email-okaya@codeaurora.org>
    <CAHp75VfHi=p_QTFr-AG06f=7HSH11bPBVvSSHfEnEHqoEvDG5w@mail.gmail.com>
    <5644AA63.2070205@codeaurora.org>
    <CAHp75VcU5xjMB4-=Q1fkRM9Z6v+=EKwgi+_Uk8-RoKQLu3VTNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54705 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbKLPyW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 10:54:22 -0500
In-Reply-To: <CAHp75VcU5xjMB4-=Q1fkRM9Z6v+=EKwgi+_Uk8-RoKQLu3VTNw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> On Thu, Nov 12, 2015 at 5:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 11/12/2015 4:56 AM, Andy Shevchenko wrote:
>>> On Thu, Nov 12, 2015 at 8:14 AM, Sinan Kaya <okaya@codeaurora.org>
>>> wrote:
>>>> -       if (acpi_irq_balance || !link->irq.active) {
>>>> +       if ((acpi_irq_balance || !link->irq.active) && (irq <
>>>> ACPI_MAX_IRQS)) {
>>>>                 /*
>>>
>>>> -                * Select the best IRQ.  This is done in reverse to
>>>> promote
>>>> -                * the use of IRQs 9, 10, 11, and >15.
>>>> +                * Select the best IRQ.  This is done in reverse to
>>>> +                * promote the use of IRQs 9, 10, 11, and >15.
>>>
>>> What was changed here?
>>
>> See your comments here.
>> https://lkml.org/lkml/2015/11/8/231
>
> So, you refer to narrow commentary blocks, right?
> It was about *new* code, leave as is what was before your patch series.
>
> --
> With Best Regards,
> Andy Shevchenko
>

This is what it was before.

>         if (acpi_irq_balance || !link->irq.active) {
> -               /*
> -                * Select the best IRQ.  This is done in reverse to promote
> -                * the use of IRQs 9, 10, 11, and >15.
> -                */
> -               for (i = (link->irq.possible_count - 1); i >= 0; i--) {
> -                       if (acpi_irq_penalty[irq] >
> -                           acpi_irq_penalty[link->irq.possible[i]])
> -                               irq = link->irq.possible[i];

I added a range check for link->irq.possible[i] and irq into this code.


