From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration
 when CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 10:31:30 +0100
Message-ID: <CAJZ5v0gCQdAA3ppMhwobniOaCbEknhGie1hbO1QyOjqvCq194A@mail.gmail.com>
References: <20181212052846.32370-1-okaya@kernel.org> <20181212052846.32370-3-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212052846.32370-3-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 12, 2018 at 6:29 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Getting ready to allow PCI to be disabled with ACPI enabled. Stub out
> acpi_os_read_pci_configuration function that depend on PCI.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/osl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index b48874b8e1ea..3e82b50ba811 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -773,6 +773,7 @@ acpi_status
>  acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>                                u64 *value, u32 width)
>  {
> +#ifdef CONFIG_PCI
>         int result, size;
>         u32 value32;
>
> @@ -799,6 +800,9 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>         *value = value32;
>
>         return (result ? AE_ERROR : AE_OK);
> +#else
> +       return pr_warn_once("CONFIG_PCI is disabled\n") ? AE_SUPPORT : AE_OK;

What about saying "PCI configuration space access is not supported" instead?

> +#endif
>  }
>
>  acpi_status
> --
