From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Sun, 8 Nov 2015 22:35:10 +0200
Message-ID: <CAHp75VfH9-OpQdX_aoraLEcHewdRPFoR5My8mN2jU30ittS7oA@mail.gmail.com>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 8, 2015 at 6:07 PM, Sinan Kaya <okaya@codeaurora.org> wrote=
:
> The ACPI compiler uses the extended format when
> used interrupt numbers are greater than 256.
> The PCI link code currently only supports simple
> interrupt format. The IRQ numbers are represented
> using 32 bits when extended IRQ syntax. This patch
> changes the interrupt number type to 32 bits and
> places an upper limit of 1020 as possible interrupt
> id. Additional checks have been placed to prevent
> out of bounds writes.

In commit messages and in comments I see this narrow lines, any reason
to make them short, except increasing number of lines?

> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -1,6 +1,7 @@
>  /*
>   *  pci_link.c - ACPI PCI Interrupt Link Device Driver ($Revision: 3=
4 $)
>   *
> + *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@in=
tel.com>
>   *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
> @@ -67,12 +68,12 @@ static struct acpi_scan_handler pci_link_handler =
=3D {
>   * later even the link is disable. Instead, we just repick the activ=
e irq
>   */
>  struct acpi_pci_link_irq {
> -       u8 active;              /* Current IRQ */
> +       u32 active;             /* Current IRQ */
>         u8 triggering;          /* All IRQs */
>         u8 polarity;            /* All IRQs */
>         u8 resource_type;
>         u8 possible_count;
> -       u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
> +       u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>         u8 initialized:1;
>         u8 reserved:7;
>  };
> @@ -437,7 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link=
 *link, int irq)
>   * enabled system.
>   */
>
> -#define ACPI_MAX_IRQS          256
> +#define ACPI_MAX_IRQS          1020
>  #define ACPI_MAX_ISA_IRQ       16
>
>  #define PIRQ_PENALTY_PCI_AVAILABLE     (0)
> @@ -493,7 +494,8 @@ int __init acpi_irq_penalty_init(void)
>                                             penalty;
>                         }
>
> -               } else if (link->irq.active) {
> +               } else if (link->irq.active &&
> +                       (link->irq.active < ACPI_MAX_IRQS)) {
>                         acpi_irq_penalty[link->irq.active] +=3D
>                             PIRQ_PENALTY_PCI_POSSIBLE;
>                 }
> @@ -542,14 +544,19 @@ static int acpi_pci_link_allocate(struct acpi_p=
ci_link *link)
>                 irq =3D link->irq.possible[link->irq.possible_count -=
 1];
>
>         if (acpi_irq_balance || !link->irq.active) {
> -               /*
> -                * Select the best IRQ.  This is done in reverse to p=
romote
> -                * the use of IRQs 9, 10, 11, and >15.
> -                */
> -               for (i =3D (link->irq.possible_count - 1); i >=3D 0; =
i--) {
> -                       if (acpi_irq_penalty[irq] >
> -                           acpi_irq_penalty[link->irq.possible[i]])
> -                               irq =3D link->irq.possible[i];
> +
> +               if (irq < ACPI_MAX_IRQS) {
> +                       /*
> +                        * Select the best IRQ.  This is done in reve=
rse to
> +                        * promote the use of IRQs 9, 10, 11, and >15=
=2E
> +                        */
> +                       for (i =3D (link->irq.possible_count - 1); i =
>=3D 0;
> +                               i--) {

Why not

if ((acpi_irq_balance || !link->irq.active) && irq < ACPI_MAX_IRQS) {
 int i =3D link->irq.possible_count;

 while (--i) {
 =E2=80=A6
 }
}

> +                               if ((link->irq.possible[i] < ACPI_MAX=
_IRQS) &&
> +                                   (acpi_irq_penalty[irq] >
> +                                   acpi_irq_penalty[link->irq.possib=
le[i]]))
> +                                       irq =3D link->irq.possible[i]=
;
> +                       }
>                 }
>         }
>         if (acpi_irq_penalty[irq] >=3D PIRQ_PENALTY_ISA_ALWAYS) {

--=20
With Best Regards,
Andy Shevchenko
