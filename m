From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ghes: fix error return code in ghes_probe()
Date: Mon, 03 Jun 2013 10:14:54 +0800
Message-ID: <1370225694.7548.9.camel@yhuang-dev>
References: <CAPgLHd8ONsRjZr9vKMiSR3ZgD7nD8mg+x3pM88+U6DPB=bO_XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9850 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050Ab3FCCO5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Jun 2013 22:14:57 -0400
In-Reply-To: <CAPgLHd8ONsRjZr9vKMiSR3ZgD7nD8mg+x3pM88+U6DPB=bO_XQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lenb@kernel.org, rjw@sisk.pl, wfp5p@virginia.edu, mchehab@redhat.com, gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

On Mon, 2013-06-03 at 10:08 +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code in the acpi_gsi_to_irq() and
> request_irq() error handling case instead of 0, as done elsewhere
> in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Good catch!

Reviewed-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying

> ---
>  drivers/acpi/apei/ghes.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 403baf4..fcd7d91 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -919,13 +919,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  		break;
>  	case ACPI_HEST_NOTIFY_EXTERNAL:
>  		/* External interrupt vector is GSI */
> -		if (acpi_gsi_to_irq(generic->notify.vector, &ghes->irq)) {
> +		rc = acpi_gsi_to_irq(generic->notify.vector, &ghes->irq);
> +		if (rc) {
>  			pr_err(GHES_PFX "Failed to map GSI to IRQ for generic hardware error source: %d\n",
>  			       generic->header.source_id);
>  			goto err_edac_unreg;
>  		}
> -		if (request_irq(ghes->irq, ghes_irq_func,
> -				0, "GHES IRQ", ghes)) {
> +		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
> +		if (rc) {
>  			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
>  			       generic->header.source_id);
>  			goto err_edac_unreg;
> 


