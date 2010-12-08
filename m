From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH, resend] ACPI/HEST: avoid stack traces when	
 encountering duplicate source IDs
Date: Wed, 08 Dec 2010 08:36:41 +0800
Message-ID: <1291768601.12648.663.camel@yhuang-dev>
References: <4CFE59A50200007800026700@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35697 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643Ab0LHAgo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Dec 2010 19:36:44 -0500
In-Reply-To: <4CFE59A50200007800026700@vpn.id2.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-12-07 at 22:58 +0800, Jan Beulich wrote:
> Rather than trying to create duplicate platform devices, check for
> duplication up front.
> 
> Generally the kernel doesn't require uniqueness of the source IDs
> other than for obtaining unique platform device names (and making log
> message non-ambiguous) - therefore, it would be possible to simply
> replace eventual duplicate IDs with kernel assigned ones.

Do you have a machine with duplicated source ID in HEST?

> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Huang Ying <ying.huang@intel.com>
> 
> ---
>  drivers/acpi/apei/hest.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- linux-2.6.37-rc5/drivers/acpi/apei/hest.c
> +++ 2.6.37-rc5-acpi-hest-unique/drivers/acpi/apei/hest.c
> @@ -139,6 +139,7 @@ static int hest_parse_ghes(struct acpi_h
>  {
>  	struct platform_device *ghes_dev;
>  	struct ghes_arr *ghes_arr = data;
> +	unsigned int i;
>  	int rc;
>  
>  	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR)
> @@ -146,6 +147,16 @@ static int hest_parse_ghes(struct acpi_h
>  
>  	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
>  		return 0;
> +	for (i = 0; i < ghes_arr->count; ++i) {
> +		const struct acpi_hest_header *h;
> +
> +		h = *(void **)dev_get_platdata(&ghes_arr->ghes_devs[i]->dev);
> +		if (hest_hdr->source_id == h->source_id) {
> +			pr_warn("Duplicate generic error source ID %#x\n",

I think we can add FW_WARN prefix here.

Best Regards,
Huang Ying


