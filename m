From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Fix a duplicate log level
Date: Tue, 11 Mar 2008 00:58:39 -0400
Message-ID: <200803110058.39587.lenb@kernel.org>
References: <20080227205601.4c65ed1c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43125 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbYCKE67 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 00:58:59 -0400
In-Reply-To: <20080227205601.4c65ed1c@hyperion.delvare>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Wednesday 27 February 2008, you wrote:
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/acpi/osl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.25-rc3.orig/drivers/acpi/osl.c	2008-02-16 10:37:18.000000000 +0100
> +++ linux-2.6.25-rc3/drivers/acpi/osl.c	2008-02-27 19:08:01.000000000 +0100
> @@ -1237,7 +1237,7 @@ int acpi_check_resource_conflict(struct 
>  
>  	if (clash) {
>  		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
> -			printk(KERN_INFO "%sACPI: %s resource %s [0x%llx-0x%llx]"
> +			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
>  			       " conflicts with ACPI region %s"
>  			       " [0x%llx-0x%llx]\n",
>  			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> 
> 


