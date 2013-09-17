From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 11/14] ACPICA: Tables: Cleanup RSDP signature codes.
Date: Mon, 16 Sep 2013 20:51:42 -0400
Message-ID: <CAJvTdKkwNXZQXz1A2zB8se=gfCT-K_=xsLRyyd44TEvPjAismw@mail.gmail.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<fb939442320d1f3f68250b4a33fd4e97f6f689d9.1377844863.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61208 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3IQAvq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 20:51:46 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so4212415wib.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Sep 2013 17:51:42 -0700 (PDT)
In-Reply-To: <fb939442320d1f3f68250b4a33fd4e97f6f689d9.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> This patch introduces new macors to handle RSDP signature and cleans up the
> affected codes.  Lv Zheng.
>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpica/tbprint.c  |    2 +-
>  drivers/acpi/acpica/tbxfroot.c |    3 +--
>  include/acpi/actypes.h         |    5 +++++
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
> index 499759a..9a47715 100644
> --- a/drivers/acpi/acpica/tbprint.c
> +++ b/drivers/acpi/acpica/tbprint.c
> @@ -138,7 +138,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
>                 ACPI_INFO((AE_INFO, "%4.4s %p %05X",
>                            header->signature, ACPI_CAST_PTR(void, address),
>                            header->length));
> -       } else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
> +       } else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
>
>                 /* RSDP has no common fields */
>
> diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
> index 948c95e..1c95fab 100644
> --- a/drivers/acpi/acpica/tbxfroot.c
> +++ b/drivers/acpi/acpica/tbxfroot.c
> @@ -68,8 +68,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
>          * Note: Sometimes there exists more than one RSDP in memory; the valid
>          * RSDP has a valid checksum, all others have an invalid checksum.
>          */
> -       if (ACPI_STRNCMP((char *)rsdp->signature, ACPI_SIG_RSDP,
> -                        sizeof(ACPI_SIG_RSDP) - 1) != 0) {
> +       if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
>
>                 /* Nope, BAD Signature */
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 850f750..5400672 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -474,6 +474,11 @@ typedef u64 acpi_integer;
>  #define ACPI_MOVE_NAME(dest,src)        (ACPI_STRNCPY (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
>  #endif
>
> +/* Support for the special RSDP signature (8 characters) */
> +
> +#define ACPI_VALIDATE_RSDP_SIG(a)       (!ACPI_STRNCMP (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
> +#define ACPI_MAKE_RSDP_SIG(dest)        (ACPI_MEMCPY (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))

is ACPI_MAKE_RSDP_SIGI(), defined, but not used?
If so, don't define it.

Len Brown, Intel Open Source Technology Center
