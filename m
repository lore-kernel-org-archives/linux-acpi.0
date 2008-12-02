From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Use 32-bit FADT values on X86
Date: Tue, 02 Dec 2008 09:05:13 +0800
Message-ID: <1228179913.2713.45.camel@rzhang-dt>
References: <20081201111713.GA26069@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31839 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbYLBBGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Dec 2008 20:06:53 -0500
In-Reply-To: <20081201111713.GA26069@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2008-12-01 at 19:17 +0800, Matthew Garrett wrote:
> The ACPI specification says that we should use the 64-bit address offsets
> contained within the FADT if they exist. However, Windows uses the legacy
> address.
Including vista?

thanks,
rui
>  Various vendors have left incorrect values in the 64-bit field
> which then causes problems later. Since the vast majority of machines have
> never been tested with an OS that uses the 64-bit value by default, we should
> behave like Windows and ignore the spec by only using the 64-bit address if
> it contains something that can't be represented in the legacy field. Since
> system io space is only 16 bits on x86, this should be entirely safe.
>     
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 
> ---
> 
> Len, this is a clear case of the spec not matching real-life behaviour. 
> I'd be amazed if anyone can find an x86 system that uses system-io space 
> for these values and doesn't contain an accurate value in the 32-bit 
> field. On the other hand, we've seen machines that assume the 
> Windows-style behaviour and we keep finding more. A blacklist isn't the 
> correct solution for this problem.
> 
> diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
> index 2817158..89a3c82 100644
> --- a/drivers/acpi/tables/tbfadt.c
> +++ b/drivers/acpi/tables/tbfadt.c
> @@ -320,9 +320,30 @@ static void acpi_tb_convert_fadt(void)
>  		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
>  				 fadt_info_table[i].target);
>  
> -		/* Expand only if the X target is null */
> -
> -		if (!target->address) {
> +		/*
> +		 * The ACPI specification says that we should use the
> +		 * 64-bit address offsets if they exists. However,
> +		 * Windows uses the legacy address. Various vendors
> +		 * have left incorrect values in the 64-bit field,
> +		 * which then causes problems later. Since the vast
> +		 * majority of machines have never been tested with an
> +		 * OS that uses the 64-bit value by default, we should
> +		 * behave like Windows and ignore the spec by only
> +		 * using the 64-bit address if it contains something
> +		 * that can't be represented in the legacy
> +		 * field. Since system io space is only 16 bits on
> +		 * x86, this should be entirely safe. We also extend
> +		 * the 32-bit value into the 64-bit one if no 64-bit
> +		 * address is provided.
> +		 */
> +
> +		if (!target->address
> +#ifdef CONFIG_X86
> +		    || (target->space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
> +			*ACPI_ADD_PTR(u32, &acpi_gbl_FADT,
> +				      fadt_info_table[i].source))
> +#endif
> +			) {
>  			acpi_tb_init_generic_address(target,
>  						     *ACPI_ADD_PTR(u8,
>  								   &acpi_gbl_FADT,
> 

