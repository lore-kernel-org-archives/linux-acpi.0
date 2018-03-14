From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Wed, 14 Mar 2018 12:36:42 +0200
Message-ID: <CAHp75Vdi_X9DHVMAM07eAhbPGJ4R3HrKpPVg0JK2vKjTzs0D9g@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-3-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314003655.12141-3-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Aaron Durbin <adurbin@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 14, 2018 at 2:36 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
> earlycon setup handler to configure its input clock in order to compute
> baud rate divisor registers.
> Detect them by examining the OEMID field in the SPCR header, and pass
> then pass uart type amdcz to earlycon.

Thanks, this is what I meant.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/acpi/spcr.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 9d52743080a4..52d840d0e05b 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -73,6 +73,24 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>         return xgene_8250;
>  }
>
> +/*
> + * AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
> + * earlycon setup handler to configure its input clock in order to compute
> + * baud rate divisor registers.
> + * Detect them by examining the OEM fields in the SPCR header.
> + */
> +static bool amdcz_present(struct acpi_table_spcr *tb)
> +{
> +       if (memcmp(tb->header.oem_id, "AMDCZ ", ACPI_OEM_ID_SIZE))
> +               return false;
> +
> +       if (memcmp(tb->header.oem_table_id, "AMDCZ   ",
> +                   ACPI_OEM_TABLE_ID_SIZE))
> +               return false;
> +
> +       return true;
> +}
> +
>  /**
>   * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
>   *
> @@ -189,6 +207,11 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>                         uart = "qdf2400_e44";
>         }
>
> +       if (amdcz_present(table)) {
> +               if (enable_earlycon)
> +                       uart = "amdcz";
> +       }
> +
>         if (xgene_8250_erratum_present(table)) {
>                 iotype = "mmio32";
>
> --
> 2.16.2.804.g6dcf76e118-goog
>



-- 
With Best Regards,
Andy Shevchenko
