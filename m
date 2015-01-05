From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] acpi: acpica: utmisc.c:  Remove unused function
Date: Mon, 5 Jan 2015 08:32:59 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026AAC8D@SHSMSX101.ccr.corp.intel.com>
References: <1420132554-32049-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420132554-32049-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, "Moore, Robert" <robert.moore@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Rickard

> From: Rickard Strandqvist [mailto:rickard_strandqvist@spectrumdigital.se]
> Sent: Friday, January 02, 2015 1:16 AM
> 
> Remove the function acpi_ut_is_aml_table() that is not used anywhere.

This function is used by the ACPICA debugger and disassembler.
The ACPICA release process has just automatically released this function from the ACPICA code base to the Linux kernel.

We shouldn't just remove it from the Linux kernel code base.
If we do so, it's just turned into divergences that can hurt the release automation.
You may use ACPI_FUTURE_USAGE around these functions instead.

Same rule should apply to all of the other patches from you.

Thanks and best regards
-Lv

> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/acpi/acpica/acutils.h |    2 --
>  drivers/acpi/acpica/utmisc.c  |   28 ----------------------------
>  2 files changed, 30 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
> index 486d342..ec5da45 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -570,8 +570,6 @@ const struct acpi_exception_info *acpi_ut_validate_exception(acpi_status
> 
>  u8 acpi_ut_is_pci_root_bridge(char *id);
> 
> -u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
> -
>  acpi_status
>  acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
>  			  void *target_object,
> diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
> index 2e2bb14..a9440af 100644
> --- a/drivers/acpi/acpica/utmisc.c
> +++ b/drivers/acpi/acpica/utmisc.c
> @@ -77,34 +77,6 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
> 
>  /*******************************************************************************
>   *
> - * FUNCTION:    acpi_ut_is_aml_table
> - *
> - * PARAMETERS:  table               - An ACPI table
> - *
> - * RETURN:      TRUE if table contains executable AML; FALSE otherwise
> - *
> - * DESCRIPTION: Check ACPI Signature for a table that contains AML code.
> - *              Currently, these are DSDT,SSDT,PSDT. All other table types are
> - *              data tables that do not contain AML code.
> - *
> - ******************************************************************************/
> -
> -u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
> -{
> -
> -	/* These are the only tables that contain executable AML */
> -
> -	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) ||
> -	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_PSDT) ||
> -	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT)) {
> -		return (TRUE);
> -	}
> -
> -	return (FALSE);
> -}
> -
> -/*******************************************************************************
> - *
>   * FUNCTION:    acpi_ut_dword_byte_swap
>   *
>   * PARAMETERS:  value           - Value to be converted
> --
> 1.7.10.4
