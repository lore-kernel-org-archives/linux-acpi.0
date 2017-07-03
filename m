From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: SPCR: Workaround for APM X-Gene 8250 UART
 32-alignment errata
Date: Mon, 3 Jul 2017 23:45:21 +0200
Message-ID: <CAJZ5v0hX+WeTwE1wbc+61JYkAMR7Utkovtw4_UGRR=YPEGWdag@mail.gmail.com>
References: <1499117589-4829-1-git-send-email-lho@apm.com> <1499117589-4829-3-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35934 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbdGCVpX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2017 17:45:23 -0400
In-Reply-To: <1499117589-4829-3-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Loc Ho <lho@apm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jon Mason <jon.mason@broadcom.com>, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, patches@apm.com

On Mon, Jul 3, 2017 at 11:33 PM, Loc Ho <lho@apm.com> wrote:
> APM X-Gene verion 1 and 2 have an 8250 UART with its register
> aligned to 32-bit. In addition, the latest released BIOS
> encodes the access field as 8-bit access instead 32-bit access.
> This causes no console with ACPI boot as the console
> will not match X-Gene UART port due to the lack of mmio32
> option.
>
> Signed-off-by: Loc Ho <lho@apm.com>

Greg, Aleksey, any objections?

If not, I'll route this through the ACPI tree.

> ---
>  drivers/acpi/spcr.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 2905063..4ac3e06 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -36,6 +36,26 @@ static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
>         return false;
>  }
>
> +/*
> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
> + * register aligned to 32-bit. In addition, the BIOS also encoded the
> + * access width to be 8 bits. This function detects this errata condition.
> + */
> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
> +{
> +       if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
> +               return false;
> +
> +       if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
> +               return false;
> +
> +       if (!memcmp(tb->header.oem_table_id, "XGENESPC",
> +           ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
> +               return true;
> +
> +       return false;
> +}
> +
>  /**
>   * parse_spcr() - parse ACPI SPCR table and add preferred console
>   *
> @@ -129,6 +149,8 @@ int __init parse_spcr(bool earlycon)
>
>         if (qdf2400_erratum_44_present(&table->header))
>                 uart = "qdf2400_e44";
> +       if (xgene_8250_erratum_present(table))
> +               iotype = "mmio32";
>
>         snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
>                  table->serial_port.address, baud_rate);
> --
> 1.8.3.1
>
