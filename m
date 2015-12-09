From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Wed, 9 Dec 2015 12:09:11 -0500
Message-ID: <56686037.70109@codeaurora.org>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
 <1449677909-12432-2-git-send-email-okaya@codeaurora.org>
 <CAHp75VeW7wizf_FUc=O5+PEdfibYRL1G7gqpdDxUALwXJsnBAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeW7wizf_FUc=O5+PEdfibYRL1G7gqpdDxUALwXJsnBAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, cov@codeaurora.org, jcm@redhat.com, helgaas@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/9/2015 11:59 AM, Andy Shevchenko wrote:
>> +       if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>> > +           polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>> > +               penalty = PIRQ_PENALTY_ISA_ALWAYS;
>> > +       else
>> > +               penalty = PIRQ_PENALTY_PCI_USING;
>> > +
>> > +       acpi_irq_add_penalty(irq, penalty);
> Why not to change in place? I think a common sense rule is not to
> change something existing if it doesn't add any significant value.
> 
Sorry, I didn't understand what you mean. Are you asking why we are
changing lines like above?

If yes, acpi_irq_penalty used to be an array of 256 entries. Now,
acpi_irq_penalty doesn't exist anymore as it was replaced with a linklist.

> -               acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> +              acpi_irq_add_penalty(irq, PIRQ_PENALTY_PCI_USING);
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
