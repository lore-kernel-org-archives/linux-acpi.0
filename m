From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
Date: Wed, 29 Jun 2016 15:16:11 +0200
Message-ID: <CAJZ5v0j+CJ3qWTdvm6Sk3DqFYVnkuEmaR1EPZM6DDVMC8rsK+g@mail.gmail.com>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org> <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Jon Masters <jcm@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl, perex@perex.cz, tiwai@suse.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The omitted parenthesis prevents the addition operation when
> acpi_penalize_isa_irq function is called.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Well, this is a rather obvious one, so I'm wondering why it is the
last one in the series?

> ---
>  drivers/acpi/pci_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 8c08971..c983bf7 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -872,7 +872,7 @@ void acpi_penalize_isa_irq(int irq, int active)
>  {
>         if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
>                 acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> -                       active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
> +                 (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>  }
>
>  bool acpi_isa_irq_available(int irq)
> --

Thanks,
Rafael
