From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Thu, 12 Nov 2015 17:17:48 +0200
Message-ID: <CAHp75VcU5xjMB4-=Q1fkRM9Z6v+=EKwgi+_Uk8-RoKQLu3VTNw@mail.gmail.com>
References: <1447308882-29634-1-git-send-email-okaya@codeaurora.org>
	<1447308882-29634-2-git-send-email-okaya@codeaurora.org>
	<CAHp75VfHi=p_QTFr-AG06f=7HSH11bPBVvSSHfEnEHqoEvDG5w@mail.gmail.com>
	<5644AA63.2070205@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36468 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbbKLPRs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 10:17:48 -0500
In-Reply-To: <5644AA63.2070205@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Nov 12, 2015 at 5:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 11/12/2015 4:56 AM, Andy Shevchenko wrote:
>> On Thu, Nov 12, 2015 at 8:14 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> -       if (acpi_irq_balance || !link->irq.active) {
>>> +       if ((acpi_irq_balance || !link->irq.active) && (irq < ACPI_MAX_IRQS)) {
>>>                 /*
>>
>>> -                * Select the best IRQ.  This is done in reverse to promote
>>> -                * the use of IRQs 9, 10, 11, and >15.
>>> +                * Select the best IRQ.  This is done in reverse to
>>> +                * promote the use of IRQs 9, 10, 11, and >15.
>>
>> What was changed here?
>
> See your comments here.
> https://lkml.org/lkml/2015/11/8/231

So, you refer to narrow commentary blocks, right?
It was about *new* code, leave as is what was before your patch series.

-- 
With Best Regards,
Andy Shevchenko
