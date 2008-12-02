From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Use 32-bit FADT values on X86
Date: Mon, 01 Dec 2008 22:48:05 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812012246320.934@localhost.localdomain>
References: <20081201111713.GA26069@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:39497 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYLBDsJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 22:48:09 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB80069SD6CZG47@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Dec 2008 21:47:01 -0600 (CST)
In-reply-to: <20081201111713.GA26069@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

It seems extremely risky to make this blanket change
for all registers without very detailed supporting
proof that this is the right thing to do.

-- 
-Len Brown
Intel Open Source Technology Center

On Mon, 1 Dec 2008, Matthew Garrett wrote:

> The ACPI specification says that we should use the 64-bit address offsets
> contained within the FADT if they exist. However, Windows uses the legacy
> address. Various vendors have left incorrect values in the 64-bit field
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
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
