From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI: EC: use BURST mode only for MSI notebooks
Date: Sat, 29 Aug 2009 14:40:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908291439320.23028@localhost.localdomain>
References: <20090828192938.19961.63714.stgit@thinkpad>
 <20090828192944.19961.76281.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:58996 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbZH2Sk2 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 14:40:28 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP500KJRIJEY1Y3@vms173013.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Sat, 29 Aug 2009 13:40:29 -0500 (CDT)
In-reply-to: <20090828192944.19961.76281.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to ec branch in acpi-test for 2.6.32

The patch needs a check-in comment before it goes upstream, however.

thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 28 Aug 2009, Alexey Starikovskiy wrote:

> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 78f8380..829e62e 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -627,7 +627,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
>  	if (bits != 8 && acpi_strict)
>  		return AE_BAD_PARAMETER;
>  
> -	acpi_ec_burst_enable(ec);
> +	if (EC_FLAGS_MSI)
> +		acpi_ec_burst_enable(ec);
>  
>  	if (function == ACPI_READ) {
>  		result = acpi_ec_read(ec, address, &temp);
> @@ -648,7 +649,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
>  		}
>  	}
>  
> -	acpi_ec_burst_disable(ec);
> +	if (EC_FLAGS_MSI)
> +		acpi_ec_burst_disable(ec);
>  
>  	switch (result) {
>  	case -EINVAL:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
