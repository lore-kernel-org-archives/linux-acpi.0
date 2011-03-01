From: Bjorn Helgaas <bjorn@helgaas.com>
Subject: Re: [PATCH] pnpacpi: Better format error message
Date: Tue, 1 Mar 2011 09:25:04 -0700
Message-ID: <20110301162504.GC2940@helgaas.com>
References: <201103011513.40235.trenn@suse.de>
 <201103011524.50340.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:46819 "EHLO
	qmta05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000Ab1CAQcu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2011 11:32:50 -0500
Content-Disposition: inline
In-Reply-To: <201103011524.50340.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org

On Tue, Mar 01, 2011 at 03:24:50PM +0100, Thomas Renninger wrote:
> On a system with empty _CRS method I see:
> pnp 00:0c: can't evaluate _CRS: 12311
> which is 0x3017, which would mean: AE_AML_INVALID_RESOURCE_TYPE
> 
> This patch would directly show: AE_AML_INVALID_RESOURCE_TYPE

The patch seems fine to me, but I question whether we need these
printks at all.  It seems pointless to have an empty _CRS method,
but it does seem legal, or at least debatable, so I'm not sure
that the message is telling us anything useful.

Bjorn

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: bjorn@helgaas.com
> CC: lenb@kernel.org
> CC: robert.moore@intel.com
> 
> ---
> Corrected email address of Bjorn.
> 
>  drivers/pnp/pnpacpi/rsparser.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.37-master/drivers/pnp/pnpacpi/rsparser.c
> ===================================================================
> --- linux-2.6.37-master.orig/drivers/pnp/pnpacpi/rsparser.c
> +++ linux-2.6.37-master/drivers/pnp/pnpacpi/rsparser.c
> @@ -498,7 +498,8 @@ int pnpacpi_parse_allocated_resource(str
>  
>  	if (ACPI_FAILURE(status)) {
>  		if (status != AE_NOT_FOUND)
> -			dev_err(&dev->dev, "can't evaluate _CRS: %d", status);
> +			dev_err(&dev->dev, "can't evaluate _CRS: %s",
> +				acpi_format_exception(status));
>  		return -EPERM;
>  	}
>  	return 0;
> @@ -809,7 +810,8 @@ int __init pnpacpi_parse_resource_option
>  
>  	if (ACPI_FAILURE(status)) {
>  		if (status != AE_NOT_FOUND)
> -			dev_err(&dev->dev, "can't evaluate _PRS: %d", status);
> +			dev_err(&dev->dev, "can't evaluate _PRS: %s",
> +				acpi_format_exception(status));
>  		return -EPERM;
>  	}
>  	return 0;
> @@ -876,7 +878,8 @@ int pnpacpi_build_resource_template(stru
>  	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
>  				     pnpacpi_count_resources, &res_cnt);
>  	if (ACPI_FAILURE(status)) {
> -		dev_err(&dev->dev, "can't evaluate _CRS: %d\n", status);
> +		dev_err(&dev->dev, "can't evaluate _CRS: %s\n",
> +			acpi_format_exception(status));
>  		return -EINVAL;
>  	}
>  	if (!res_cnt)
> @@ -891,7 +894,8 @@ int pnpacpi_build_resource_template(stru
>  				     pnpacpi_type_resources, &resource);
>  	if (ACPI_FAILURE(status)) {
>  		kfree(buffer->pointer);
> -		dev_err(&dev->dev, "can't evaluate _CRS: %d\n", status);
> +		dev_err(&dev->dev, "can't evaluate _CRS: %s\n",
> +			acpi_format_exception(status));
>  		return -EINVAL;
>  	}
>  	/* resource will pointer the end resource now */
