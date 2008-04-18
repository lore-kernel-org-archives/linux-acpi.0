From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI : RSDT is forced to be used when 32/64X address
	mismatch in FADT
Date: Fri, 18 Apr 2008 13:29:22 +0200
Message-ID: <1208518162.1784.418.camel@queen.suse.de>
References: <1208515293.4072.3.camel@yakui_zhao.sh.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34201 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbYDRL3Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Apr 2008 07:29:25 -0400
In-Reply-To: <1208515293.4072.3.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, 2008-04-18 at 18:41 +0800, Zhao Yakui wrote:
> Subject: ACPI: RSDT is forced to be used when 32/64X address mismatch in FADT
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> On some laptops 32/64x address mismatches in FADT when XSDT is used,
> which will cause some potential problem. In such cases the RSDT is 
> used instead of XSDT.
This sounds wrong.

It sounds like the system got tested using the RSDT (probably on
Windows). Nowadays, the XSDT will be the more tested table and RSDT
entries are likely to be wrong. If you get a mismatch on a more recent
machines it's likely that you choose the wrong table by taking the RSDT.
IMO these machines (if there are not much) should be blacklisted to use
the RSDT using dmi info (which should already be available at that
time).

   Thomas
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8246
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Zhang Rui  <rui.zhang@intel.com>
> 
> ---
>  drivers/acpi/tables/tbfadt.c  |   46 +++++++++++++++++++++++++++++++-----------
>  drivers/acpi/tables/tbutils.c |   28 +++++++++++++++++++++++--
>  include/acpi/actables.h       |    4 +--
>  3 files changed, 63 insertions(+), 15 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/tables/tbutils.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/tables/tbutils.c
> +++ linux-2.6/drivers/acpi/tables/tbutils.c
> @@ -404,9 +404,22 @@ acpi_tb_parse_root_table(acpi_physical_a
>  	u32 length;
>  	u8 *table_entry;
>  	acpi_status status;
> +	int rsdt_forced;
>  
>  	ACPI_FUNCTION_TRACE(tb_parse_root_table);
>  
> +	rsdt_forced = 0;
> +
> +rsdt_retry:
> +	if (rsdt_forced) {
> +		/*
> +		 * When rsdt is forced to be used, it is necessary to
> +		 * reinitialize the acpi_gbl_root_table_list.
> +		 */
> +		for (i = 0; i < acpi_gbl_root_table_list.count; i++)
> +			ACPI_MEMSET(&(acpi_gbl_root_table_list.tables[i]),
> +				0, sizeof(struct acpi_table_desc));
> +	}
>  	/*
>  	 * Map the entire RSDP and extract the address of the RSDT or XSDT
>  	 */
> @@ -421,7 +434,8 @@ acpi_tb_parse_root_table(acpi_physical_a
>  
>  	/* Differentiate between RSDT and XSDT root tables */
>  
> -	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
> +	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
> +		&& !rsdt_forced) {
>  		/*
>  		 * Root table is an XSDT (64-bit physical addresses). We must use the
>  		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
> @@ -550,7 +564,17 @@ acpi_tb_parse_root_table(acpi_physical_a
>  		if (ACPI_COMPARE_NAME
>  		    (&acpi_gbl_root_table_list.tables[i].signature,
>  		     ACPI_SIG_FADT)) {
> -			acpi_tb_parse_fadt(i, flags);
> +			status = acpi_tb_parse_fadt(i, flags);
> +			if (ACPI_FAILURE(status) && !rsdt_forced) {
> +				/*
> +				 * If FADT has some errors and XSDT is used,
> +				 * rsdt will be tried.
> +				 */
> +				ACPI_WARNING((AE_INFO, "FADT has errors. "
> +					"RSDT will be used instead"));
> +				rsdt_forced = 1;
> +				goto rsdt_retry;
> +			}
>  		}
>  	}
>  
> Index: linux-2.6/include/acpi/actables.h
> ===================================================================
> --- linux-2.6.orig/include/acpi/actables.h
> +++ linux-2.6/include/acpi/actables.h
> @@ -49,9 +49,9 @@ acpi_status acpi_allocate_root_table(u32
>  /*
>   * tbfadt - FADT parse/convert/validate
>   */
> -void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
> +acpi_status acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
>  
> -void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
> +acpi_status acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
>  
>  /*
>   * tbfind - find ACPI table
> Index: linux-2.6/drivers/acpi/tables/tbfadt.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/tables/tbfadt.c
> +++ linux-2.6/drivers/acpi/tables/tbfadt.c
> @@ -54,7 +54,7 @@ acpi_tb_init_generic_address(struct acpi
>  
>  static void acpi_tb_convert_fadt(void);
>  
> -static void acpi_tb_validate_fadt(void);
> +static acpi_status acpi_tb_validate_fadt(void);
>  
>  /* Table for conversion of FADT to common internal format and FADT validation */
>  
> @@ -148,17 +148,18 @@ acpi_tb_init_generic_address(struct acpi
>   * PARAMETERS:  table_index         - Index for the FADT
>   *              Flags               - Flags
>   *
> - * RETURN:      None
> + * RETURN:      status
>   *
>   * DESCRIPTION: Initialize the FADT, DSDT and FACS tables
>   *              (FADT contains the addresses of the DSDT and FACS)
>   *
>   ******************************************************************************/
>  
> -void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
> +acpi_status acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
>  {
>  	u32 length;
>  	struct acpi_table_header *table;
> +	acpi_status status;
>  
>  	/*
>  	 * The FADT has multiple versions with different lengths,
> @@ -173,7 +174,7 @@ void acpi_tb_parse_fadt(acpi_native_uint
>  	    acpi_os_map_memory(acpi_gbl_root_table_list.tables[table_index].
>  			       address, length);
>  	if (!table) {
> -		return;
> +		return_ACPI_STATUS(AE_NO_MEMORY);
>  	}
>  
>  	/*
> @@ -184,7 +185,7 @@ void acpi_tb_parse_fadt(acpi_native_uint
>  
>  	/* Obtain a local copy of the FADT in common ACPI 2.0+ format */
>  
> -	acpi_tb_create_local_fadt(table, length);
> +	status = acpi_tb_create_local_fadt(table, length);
>  
>  	/* All done with the real FADT, unmap it */
>  
> @@ -197,6 +198,8 @@ void acpi_tb_parse_fadt(acpi_native_uint
>  
>  	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
>  			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
> +
> +	return_ACPI_STATUS(status);
>  }
>  
>  /*******************************************************************************
> @@ -206,7 +209,7 @@ void acpi_tb_parse_fadt(acpi_native_uint
>   * PARAMETERS:  Table               - Pointer to BIOS FADT
>   *              Length              - Length of the table
>   *
> - * RETURN:      None
> + * RETURN:      status
>   *
>   * DESCRIPTION: Get a local copy of the FADT and convert it to a common format.
>   *              Performs validation on some important FADT fields.
> @@ -215,9 +218,10 @@ void acpi_tb_parse_fadt(acpi_native_uint
>   *
>   ******************************************************************************/
>  
> -void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
> +acpi_status
> +acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
>  {
> -
> +	acpi_status status;
>  	/*
>  	 * Check if the FADT is larger than the largest table that we expect
>  	 * (the ACPI 2.0/3.0 version). If so, truncate the table, and issue
> @@ -244,7 +248,9 @@ void acpi_tb_create_local_fadt(struct ac
>  	 * 2) Validate some of the important values within the FADT
>  	 */
>  	acpi_tb_convert_fadt();
> -	acpi_tb_validate_fadt();
> +	status = acpi_tb_validate_fadt();
> +
> +	return_ACPI_STATUS(status);
>  }
>  
>  /*******************************************************************************
> @@ -377,7 +383,7 @@ static void acpi_tb_convert_fadt(void)
>   *
>   * PARAMETERS:  Table           - Pointer to the FADT to be validated
>   *
> - * RETURN:      None
> + * RETURN:      status
>   *
>   * DESCRIPTION: Validate various important fields within the FADT. If a problem
>   *              is found, issue a message, but no status is returned.
> @@ -391,12 +397,16 @@ static void acpi_tb_convert_fadt(void)
>   *
>   ******************************************************************************/
>  
> -static void acpi_tb_validate_fadt(void)
> +static acpi_status acpi_tb_validate_fadt(void)
>  {
>  	u32 *address32;
>  	struct acpi_generic_address *address64;
>  	u8 length;
>  	acpi_native_uint i;
> +	acpi_status status;
> +
> +	/* The default status is AE_OK */
> +	status = AE_OK;
>  
>  	/* Examine all of the 64-bit extended address fields (X fields) */
>  
> @@ -420,6 +430,12 @@ static void acpi_tb_validate_fadt(void)
>  			 * Both the address and length must be non-zero.
>  			 */
>  			if (!address64->address || !length) {
> +				/*
> +				 * Is it necessary to break the loop when the
> +				 * required filed has zero address or length?
> +				 * If it is required, please fix me.
> +				 */
> +				status = AE_ERROR;
>  				ACPI_ERROR((AE_INFO,
>  					    "Required field \"%s\" has zero address and/or length: %8.8X%8.8X/%X",
>  					    fadt_info_table[i].name,
> @@ -447,10 +463,18 @@ static void acpi_tb_validate_fadt(void)
>  
>  		if (address64->address && *address32 &&
>  		    (address64->address != (u64) * address32)) {
> +			/*
> +			 * Is it necessary to break the loop when the 32/64
> +			 * address mismatches ?
> +			 * If it is required, please fix me.
> +			 */
> +			status = AE_ERROR;
>  			ACPI_ERROR((AE_INFO,
>  				    "32/64X address mismatch in \"%s\": [%8.8X] [%8.8X%8.8X], using 64X",
>  				    fadt_info_table[i].name, *address32,
>  				    ACPI_FORMAT_UINT64(address64->address)));
>  		}
>  	}
> +
> +	return_ACPI_STATUS(status);
>  }
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

