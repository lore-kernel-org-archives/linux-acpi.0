From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: EC: Some hardware requires burst mode to operate properly
Date: Thu, 10 Jan 2008 20:51:13 -0500
Message-ID: <200801102051.13533.lenb@kernel.org>
References: <20080110234250.26720.16527.stgit@localhost.localdomain> <20080110234257.26720.77000.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49826 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437AbYAKBva (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 10 Jan 2008 20:51:30 -0500
In-Reply-To: <20080110234257.26720.77000.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi test

thanks,
-Len

On Thursday 10 January 2008 18:42, Alexey Starikovskiy wrote:
> Burst mode temporary (50 ms) locks EC to do only transactions with
> driver, without it some hardware returns abstract garbage.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9341
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 1de0905..98a5388 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -575,6 +575,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
>  	if (bits != 8 && acpi_strict)
>  		return AE_BAD_PARAMETER;
>  
> +	acpi_ec_burst_enable(ec);
> +
>  	if (function == ACPI_READ) {
>  		result = acpi_ec_read(ec, address, &temp);
>  		*value = temp;
> @@ -594,6 +596,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
>  		}
>  	}
>  
> +	acpi_ec_burst_disable(ec);
> +
>  	switch (result) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
