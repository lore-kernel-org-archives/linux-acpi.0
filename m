From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V3] acpi: add support for extended IRQ to PCI link
Date: Sun, 15 Nov 2015 22:14:29 +0200
Message-ID: <CAHp75VeKLG2yVhHqSFixmo+jvNG=9tLk5pBnGjbT6660dy694g@mail.gmail.com>
References: <1447617653-29743-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36520 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbKOUOa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2015 15:14:30 -0500
In-Reply-To: <1447617653-29743-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, cov@codeaurora.org, jcm@redhat.com, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Nov 15, 2015 at 10:00 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The ACPI compiler uses the extended format when used
> interrupt numbers are greater than 256. The PCI link code
> currently only supports simple interrupt format. The IRQ
> numbers are represented using 32 bits when extended IRQ
> syntax. This patch changes the interrupt number type to
> 32 bits and places an upper limit of 1020 as possible
> interrupt id.
>
> 1020 is the maximum interrupt ID that can be assigned to
> an ARM SPI interrupt according to ARM architecture.
>
> Additional checks have been placed to prevent out of bounds
> writes.

One comment below.

> @@ -541,14 +547,16 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>         else
>                 irq = link->irq.possible[link->irq.possible_count - 1];
>
> -       if (acpi_irq_balance || !link->irq.active) {
> +       if ((acpi_irq_balance || !link->irq.active) && (irq < ACPI_MAX_IRQS)) {
>                 /*
>                  * Select the best IRQ.  This is done in reverse to promote
>                  * the use of IRQs 9, 10, 11, and >15.
>                  */
> -               for (i = (link->irq.possible_count - 1); i >= 0; i--) {
> -                       if (acpi_irq_penalty[irq] >
> -                           acpi_irq_penalty[link->irq.possible[i]])
> +               i = link->irq.possible_count;
> +               while (--i) {

Actually it should be (--i >= 0). Sorry if I misled you.

> +                       if ((link->irq.possible[i] < ACPI_MAX_IRQS) &&
> +                           (acpi_irq_penalty[irq] >
> +                           acpi_irq_penalty[link->irq.possible[i]]))
>                                 irq = link->irq.possible[i];
>                 }
>         }


-- 
With Best Regards,
Andy Shevchenko
