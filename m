From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI, APEI, Fix use resource_size
Date: Wed, 13 Dec 2017 01:19:55 +0100
Message-ID: <4222319.ltJQ6b6Cov@aspire.rjw.lan>
References: <1513007072-32020-1-git-send-email-gomonovych@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47411 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752805AbdLMAUi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Dec 2017 19:20:38 -0500
In-Reply-To: <1513007072-32020-1-git-send-email-gomonovych@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasyl Gomonovych <gomonovych@gmail.com>, Borislav Petkov <bp@suse.de>
Cc: lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, December 11, 2017 4:44:31 PM CET Vasyl Gomonovych wrote:
> Use resource_size function on resource object
> Underneath __request_region set res->end to start + n - 1
> Lets use resourse_size to set value properly.
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>

Boris, what do you think?

> ---
>  drivers/acpi/apei/apei-base.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index da370e1..af712a8 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -506,8 +506,7 @@ int apei_resources_request(struct apei_resources *resources,
>  
>  	rc = -EINVAL;
>  	list_for_each_entry(res, &resources->iomem, list) {
> -		r = request_mem_region(res->start, res->end - res->start,
> -				       desc);
> +		r = request_mem_region(res->start, resource_size(res), desc);
>  		if (!r) {
>  			pr_err(APEI_PFX
>  		"Can not request [mem %#010llx-%#010llx] for %s registers\n",
> @@ -519,7 +518,7 @@ int apei_resources_request(struct apei_resources *resources,
>  	}
>  
>  	list_for_each_entry(res, &resources->ioport, list) {
> -		r = request_region(res->start, res->end - res->start, desc);
> +		r = request_region(res->start, resource_size(res), desc);
>  		if (!r) {
>  			pr_err(APEI_PFX
>  		"Can not request [io  %#06llx-%#06llx] for %s registers\n",
> @@ -542,14 +541,14 @@ int apei_resources_request(struct apei_resources *resources,
>  	list_for_each_entry(res, &resources->ioport, list) {
>  		if (res == res_bak)
>  			break;
> -		release_region(res->start, res->end - res->start);
> +		release_region(res->start, resource_size(res));
>  	}
>  	res_bak = NULL;
>  err_unmap_iomem:
>  	list_for_each_entry(res, &resources->iomem, list) {
>  		if (res == res_bak)
>  			break;
> -		release_mem_region(res->start, res->end - res->start);
> +		release_mem_region(res->start, resource_size(res));
>  	}
>  arch_res_fini:
>  	if (arch_apei_filter_addr)
> @@ -566,9 +565,9 @@ void apei_resources_release(struct apei_resources *resources)
>  	struct apei_res *res;
>  
>  	list_for_each_entry(res, &resources->iomem, list)
> -		release_mem_region(res->start, res->end - res->start);
> +		release_mem_region(res->start, resource_size(res));
>  	list_for_each_entry(res, &resources->ioport, list)
> -		release_region(res->start, res->end - res->start);
> +		release_region(res->start, resource_size(res));
>  
>  	rc = apei_resources_sub(&apei_resources_all, resources);
>  	if (rc)
> 


