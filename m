From: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v3] acpi/nfit: Fix memory corruption/Unregister mce
 decoder on failure
Date: Wed, 31 May 2017 13:46:51 -0600
Message-ID: <20170531194651.GA30167@omniknight.lm.intel.com>
References: <1496252383-6234-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11784 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdEaTsW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 15:48:22 -0400
Content-Disposition: inline
In-Reply-To: <1496252383-6234-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Linda Knippers <linda.knippers@hpe.com>, jmoyer@redhat.com, lszubowi@redhat.com

On 05/31, Prarit Bhargava wrote:
> nfit_init() calls nfit_mce_register() on module load.  When the module
> load fails the nfit mce decoder is not unregistered.  The module's
> memory is freed leaving the decoder chain referencing junk.  This will
> cause panics as future registrations will reference the free'd memory.
> 
> Unregister the nfit mce decoder on module init failure.
> 
> [v2]: register and then unregister mce handler to avoid losing mce events
> [v3]: also cleanup nfit workqueue
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
> Cc: Linda Knippers <linda.knippers@hpe.com>
> Cc: jmoyer@redhat.com
> Cc: lszubowi@redhat.com
> ---
>  drivers/acpi/nfit/core.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Looks good, you can add:
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 656acb5d7166..f3c3e9d4563c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3043,6 +3043,8 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>  
>  static __init int nfit_init(void)
>  {
> +	int ret;
> +
>  	BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
>  	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 56);
>  	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
> @@ -3070,8 +3072,14 @@ static __init int nfit_init(void)
>  		return -ENOMEM;
>  
>  	nfit_mce_register();
> +	ret = acpi_bus_register_driver(&acpi_nfit_driver);
> +	if (ret) {
> +		nfit_mce_unregister();
> +		destroy_workqueue(nfit_wq);
> +	}
> +
> +	return ret;
>  
> -	return acpi_bus_register_driver(&acpi_nfit_driver);
>  }
>  
>  static __exit void nfit_exit(void)
> -- 
> 1.7.9.3
> 
