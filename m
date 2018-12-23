From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 01/11] ACPI / LPSS: Add guards against CONFIG_PCI
Date: Sun, 23 Dec 2018 22:45:09 +0100
Message-ID: <CAJZ5v0hiBT5Zg5+sQekgjvcOVgfQsXcRutkTNEOEeAFHYYRz4A@mail.gmail.com>
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222090720.19234-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 22, 2018 at 6:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We can now compile ACPI without PCI support. If code depends on CONFIG_PCI,
> it needs to explicitly guard that piece.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/acpi_lpss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 5f94c35d165f..4148abcdf9ef 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -534,8 +534,11 @@ static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
>         dev = bus_find_device(&platform_bus_type, NULL, &data, match_hid_uid);
>         if (dev)
>                 return dev;
> -
> +#ifdef CONFIG_PCI
>         return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
> +#else
> +       return NULL;
> +#endif
>  }

No.

Please make this driver depend on PCI instead.

>
>  static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
