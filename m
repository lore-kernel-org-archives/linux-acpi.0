From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] nfit: use devm_add_action_or_reset()
Date: Mon, 4 Jul 2016 15:54:04 +0800
Message-ID: <20160704075404.GB10278@linux-rxt1.site>
References: <1467606771-21704-1-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35536 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbcGDHy2 (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Mon, 4 Jul 2016 03:54:28 -0400
Content-Disposition: inline
In-Reply-To: <1467606771-21704-1-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Cc: dan.j.williams@intel.com, ross.zwisler@linux.intel.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linda.knippers@hpe.com

On Mon, Jul 04, 2016 at 10:02:51AM +0530, Vikas C Sajjan wrote:
> If devm_add_action() fails, we are explicitly calling the cleanup to free
> the resources allocated. Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, since the cleanup function
> has been already called by the helper if there was any error.
> 
> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
> ---
>  drivers/acpi/nfit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index c2ad967..44ebe1e 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1920,11 +1920,11 @@ static int acpi_nfit_insert_resource(struct acpi_nfit_desc *acpi_desc,
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_add_action(acpi_desc->dev, acpi_nfit_remove_resource, res);
> -	if (ret) {
> -		remove_resource(res);
> +	ret = devm_add_action_or_reset(acpi_desc->dev,
> +					acpi_nfit_remove_resource,
> +					res);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	return 0;
>  }
> -- 
> 1.9.1
>

Reviewed-by: Lee, Chun-Yi <jlee@suse.com>

Joey Lee 
