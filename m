From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
Date: Tue, 11 Dec 2018 11:12:36 +0100
Message-ID: <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
References: <20181208214644.5374-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208214644.5374-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 8, 2018 at 10:47 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Make PCI reboot conditional on PCI support being present on the kernel
> configuration.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Same comment as for patch [2/3]: make the subject say clearly that
this is about CONFIG_PCI.

> ---
>  drivers/acpi/reboot.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index 6fa9c2a4cfe9..9aa367f098a6 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -7,8 +7,6 @@
>  void acpi_reboot(void)
>  {
>         struct acpi_generic_address *rr;
> -       struct pci_bus *bus0;
> -       unsigned int devfn;
>         u8 reset_value;
>
>         if (acpi_disabled)
> @@ -33,6 +31,11 @@ void acpi_reboot(void)
>          * on a device on bus 0. */
>         switch (rr->space_id) {
>         case ACPI_ADR_SPACE_PCI_CONFIG:
> +       {
> +#ifdef CONFIG_PCI
> +               unsigned int devfn;
> +               struct pci_bus *bus0;
> +
>                 /* The reset register can only live on bus 0. */
>                 bus0 = pci_find_bus(0, 0);
>                 if (!bus0)
> @@ -45,7 +48,10 @@ void acpi_reboot(void)
>                 pci_bus_write_config_byte(bus0, devfn,
>                                 (rr->address & 0xffff), reset_value);
>                 break;
> -
> +#else
> +               return;

Why not "break"?

> +#endif
> +       }
>         case ACPI_ADR_SPACE_SYSTEM_MEMORY:
>         case ACPI_ADR_SPACE_SYSTEM_IO:
>                 printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
> --
