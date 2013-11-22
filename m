From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH V2 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
Date: Fri, 22 Nov 2013 19:52:45 +0000
Message-ID: <CACxGe6sfaWgZ59E5n_5Ozv6CQ8Z76dyy346Uz0Lf2E0GdKYrZw@mail.gmail.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com> <1385143964-22938-4-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35736 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab3KVTxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 14:53:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so2843580iec.19
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 11:53:05 -0800 (PST)
In-Reply-To: <1385143964-22938-4-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brandon Anderson <brandon.anderson@amd.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-acpi <linaro-acpi@lists.linaro.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Fri, Nov 22, 2013 at 6:12 PM, Brandon Anderson
<brandon.anderson@amd.com> wrote:
> Neither Foundation nor RTSM have a SPI device, but here are the necessary driver
> changes as an example of how to use acpi_amba_dsm_lookup() to get non-standard
> parameters from ACPI.
>
> This was tested by wiring up a SPI device into an RTSM Fast Model.
>
>
> Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
> ---
>  drivers/spi/spi-pl022.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 9c511a9..1d0a8ec 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -43,6 +43,7 @@
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/amba/acpi.h>
>
>  /*
>   * This macro is used to define some register default values.
> @@ -2069,6 +2070,55 @@ pl022_platform_data_dt_get(struct device *dev)
>         return pd;
>  }
>
> +#ifdef CONFIG_ACPI
> +static struct pl022_ssp_controller *
> +acpi_pl022_get_platform_data(struct device *dev)
> +{
> +       struct pl022_ssp_controller *pd, *ret;
> +       struct acpi_amba_dsm_entry entry;
> +
> +       pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
> +       if (!pd) {
> +               dev_err(dev, "cannot allocate platform data memory\n");
> +               return NULL;
> +       }
> +       ret = pd;
> +
> +       pd->bus_id = -1;
> +       pd->enable_dma = 1;
> +       if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "num-cs", 0, &entry) == 0) {
> +               if (kstrtou8(entry.value, 0, &pd->num_chipselect) != 0) {
> +                       dev_err(dev, "invalid 'num-cs' in ACPI definition\n");
> +                       ret = NULL;
> +               }
> +               kfree(entry.key);
> +               kfree(entry.value);
> +       }
> +       if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev),
> +                       "autosuspend-delay", 0, &entry) == 0) {
> +               if (kstrtoint(entry.value, 0, &pd->autosuspend_delay) != 0) {
> +                       dev_err(dev, "invalid 'autosuspend-delay' in ACPI definition\n");
> +                       ret = NULL;
> +               }
> +               kfree(entry.key);
> +               kfree(entry.value);
> +       }
> +       if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "rt", 0, &entry) == 0) {
> +               pd->rt = (entry.value && strcmp(entry.value, "1") == 0);
> +               kfree(entry.key);
> +               kfree(entry.value);
> +       }
> +
> +       return ret;
> +}

As discussed in the ACPI vs DT thread. The kinds of lookups here are
identical to the DT property lookups except that the function name is
different and the property name is needlessly different. That's
madness. In all of the trivial cases the DT and ACPI lookup code
should be identical. We need a property value lookup function that
both DT and ACPI can use.

g.
