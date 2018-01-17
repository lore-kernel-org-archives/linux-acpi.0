From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86/acpi: check rsdp address received via bootparams to
 be valid
Date: Wed, 17 Jan 2018 12:49:31 +0100
Message-ID: <CAJZ5v0j2GMvpYjURfx9N=RFYsVAmdWDwVNMG3-rxDf72ckmn_A@mail.gmail.com>
References: <20180116135730.19216-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33293 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeAQLtc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2018 06:49:32 -0500
In-Reply-To: <20180116135730.19216-1-jgross@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On Tue, Jan 16, 2018 at 2:57 PM, Juergen Gross <jgross@suse.com> wrote:
> There seem to exist several grub2 versions trashing
> boot_params.hdr.acpi_rsdp_addr.
>
> So don't just believe this address to be valid, but verify it pointing
> to a valid RSDP table.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> To be applied on top of my RSDP series currently in tip.git x86/boot
> Mike Galbraith has tested this patch to repair his broken boot
> ---
>  drivers/acpi/acpica/tbxfroot.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/osl.c             |  2 +-
>  include/acpi/acpixf.h          |  5 +++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
> index f9f9a7da2cad..9edc71780a38 100644
> --- a/drivers/acpi/acpica/tbxfroot.c
> +++ b/drivers/acpi/acpica/tbxfroot.c
> @@ -249,6 +249,42 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_find_root_pointer)
>
>  /*******************************************************************************
>   *
> + * FUNCTION:    acpi_verify_root_pointer

Why do you want this to go into ACPICA?

> + *
> + *
> + * PARAMETERS:  rsdp_address        - Pointer to suspected RSDP
> + *
> + * RETURN:      AE_OK if rsdp_address really points to a RSDP, AE_NOT_FOUND
> + *              else
> + *
> + * DESCRIPTION: Verify a physical address being a valid RSDP
> + *
> + ******************************************************************************/
> +
> +acpi_status ACPI_INIT_FUNCTION
> +acpi_verify_root_pointer(acpi_physical_address rsdp_address)
> +{
> +       acpi_status status;
> +       struct acpi_table_rsdp *rsdp;
> +
> +       ACPI_FUNCTION_TRACE(acpi_verify_root_pointer);
> +
> +       rsdp = acpi_os_map_memory(rsdp_address, sizeof(*rsdp));
> +
> +       if (!rsdp)
> +               return_ACPI_STATUS(AE_NO_MEMORY);
> +
> +       status = acpi_tb_validate_rsdp(rsdp);
> +
> +       acpi_os_unmap_memory(rsdp, sizeof(*rsdp));
> +
> +       return_ACPI_STATUS(status);
> +}
> +
> +ACPI_EXPORT_SYMBOL_INIT(acpi_verify_root_pointer)
> +
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_tb_scan_memory_for_rsdp
>   *
>   * PARAMETERS:  start_address       - Starting pointer for search
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 2b77db914752..facff5c11f32 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -201,7 +201,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>                 return acpi_rsdp;
>  #endif
>         pa = acpi_arch_get_root_pointer();
> -       if (pa)
> +       if (pa && acpi_verify_root_pointer(pa) == AE_OK)

All things needed could just be done locally in this file.

>                 return pa;
>
>         if (efi_enabled(EFI_CONFIG_TABLES)) {
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index e1dd1a8d42b6..1edc47bd13c1 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -505,6 +505,11 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>                             acpi_find_root_pointer(acpi_physical_address
>                                                    *rsdp_address))
> +
> +ACPI_EXTERNAL_RETURN_OK(acpi_status ACPI_INIT_FUNCTION
> +                       acpi_verify_root_pointer(acpi_physical_address
> +                                                rsdp_address))
> +
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>                              acpi_get_table_header(acpi_string signature,
>                                                    u32 instance,
> --
