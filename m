From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during
 early boot stages
Date: Sun, 23 Oct 2016 23:48:32 -0400
Message-ID: <22ad2e6b-e4da-1eba-0d2c-b7b86b2a4dbc@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jm-n8hbS_GFUY4EVKHiRaNPrkNcWDY+6c3SRxWhy4VAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbcJXDsh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Oct 2016 23:48:37 -0400
In-Reply-To: <CAJZ5v0jm-n8hbS_GFUY4EVKHiRaNPrkNcWDY+6c3SRxWhy4VAg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com, Ondrej Zary <linux@rainbow-software.org>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Jon Masters <jcm@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 10/20/2016 5:39 PM, Rafael J. Wysocki wrote:
>> @@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>> >  void acpi_penalize_isa_irq(int irq, int active)
>> >  {
>> >         if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
>> > -               acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
>> > +               acpi_isa_irq_penalty[irq] = acpi_isa_irq_penalty[irq] +
> This looks slightly odd.  What about
> 
> +               acpi_isa_irq_penalty[irq] +=
> 
>> >                   (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>> >  }

Makes sense.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
