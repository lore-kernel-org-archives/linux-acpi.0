From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: bus.c: Let acpi_device_get_match_data() return
 DT compatibility data
Date: Wed, 4 Jul 2018 17:40:34 +0300
Message-ID: <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
References: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nv@vosn.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, Srinath Mannam <srinath.mannam@broadcom.com>, Nikolaus Voss <nikolaus.vo>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss <nv@vosn.de> wrote:
> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> of_device_id table "compatible" strings in DSD, a pointer to the
> corresponding DT table entry should be returned instead of a null
> pointer. An acpi_device_id match still takes precedence.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

with a caveat that this is only an improvement for a _temporary_
PRP0001 users like I2C or SPI slave devices.
Please, don't consider this change as a valid point to (ab)use PRP0001
in a cases where devices are not "hotpluggable".

> v2: improve readability (as suggested by Andy Shevchenko)
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/acpi/bus.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..58575fdace78 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -832,13 +832,22 @@ EXPORT_SYMBOL_GPL(acpi_match_device);
>
>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
> -       const struct acpi_device_id *match;
> +       const struct acpi_device_id *acpi_id = NULL;
> +       const struct of_device_id *of_id = NULL;
> +       const struct device_driver *drv = dev->driver;
> +       bool match;
> +
> +       match = __acpi_match_device(acpi_companion_match(dev),
> +                                   drv->acpi_match_table,
> +                                   drv->of_match_table, &acpi_id, &of_id);
>
> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>         if (!match)
>                 return NULL;
> +
> +       if (of_id)
> +               return (const void*)of_id->data;
>
> -       return (const void *)match->driver_data;
> +       return (const void*)acpi_id->driver_data;
>  }
>  EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
