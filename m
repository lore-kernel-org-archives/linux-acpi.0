From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 2/4] ACPI / EC: Fix a memory leakage issue in
 acpi_ec_add()
Date: Sat, 3 Sep 2016 18:28:56 +0200
Message-ID: <20160903162856.GB5252@al>
References: <cover.1472802172.git.lv.zheng@intel.com>
 <51bc232e82784a302fcba870d55ffa1a178f7e09.1472802172.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:38188 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754383AbcICQ3K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 3 Sep 2016 12:29:10 -0400
Content-Disposition: inline
In-Reply-To: <51bc232e82784a302fcba870d55ffa1a178f7e09.1472802172.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Luya Tshimbalanga <luya@fedoraproject.org>

On Fri, Sep 02, 2016 at 03:46:38PM +0800, Lv Zheng wrote:
> When the handler installation failed, there was no code to free the
> allocated EC device. This patch fixes this memory leakage issue.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=115021
> Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
> Suggested-by: Peter Wu <peter@lekensteyn.nl>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Luya Tshimbalanga <luya@fedoraproject.org>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/ec.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 4a5f3ab..4b4c0cb 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1438,22 +1438,25 @@ static int acpi_ec_add(struct acpi_device *device)
>  		return -ENOMEM;
>  	if (ec_parse_device(device->handle, 0, ec, NULL) !=
>  		AE_CTRL_TERMINATE) {
> -			acpi_ec_free(ec);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto error;
>  	}
>  
>  	/* Find and register all query methods */
>  	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
>  			    acpi_ec_register_query_methods, NULL, ec, NULL);

I think you should call acpi_ec_remove_query_handlers too if at this
point acpi_config_boot_ec fails.

Peter

>  
> +	ret = acpi_config_boot_ec(ec, false);
> +	if (ret)
> +		goto error;
> +
>  	device->driver_data = ec;
>  
>  	ret = !!request_region(ec->data_addr, 1, "EC data");
>  	WARN(!ret, "Could not request EC data io port 0x%lx", ec->data_addr);
>  	ret = !!request_region(ec->command_addr, 1, "EC cmd");
>  	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
> -
> -	ret = acpi_config_boot_ec(ec, false);
> +	ret = 0;
>  
>  	/* Reprobe devices depending on the EC */
>  	acpi_walk_dep_device_list(ec->handle);
> @@ -1464,6 +1467,9 @@ static int acpi_ec_add(struct acpi_device *device)
>  	/* Clear stale _Q events if hardware might require that */
>  	if (EC_FLAGS_CLEAR_ON_RESUME)
>  		acpi_ec_clear(ec);
> +error:
> +	if (ret)
> +		acpi_ec_free(ec);
>  	return ret;
>  }
>  
> -- 
> 1.7.10
> 
