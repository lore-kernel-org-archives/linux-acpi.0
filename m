From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI, Print resource errors in conventional format
Date: Mon, 29 Aug 2011 08:49:20 +0800
Message-ID: <4E5AE210.2000105@intel.com>
References: <20110826171052.7959.94505.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6656 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab1H2AtW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Aug 2011 20:49:22 -0400
In-Reply-To: <20110826171052.7959.94505.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 08/27/2011 01:10 AM, Bjorn Helgaas wrote:
> Use the normal %pR-like format for MMIO and I/O port ranges.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/apei/apei-base.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 8041248..8bd5f1a 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -460,9 +460,9 @@ int apei_resources_request(struct apei_resources *resources,
>  				       desc);
>  		if (!r) {
>  			pr_err(APEI_PFX
> -		"Can not request iomem region <%016llx-%016llx> for GARs.\n",
> +		"Can not request [mem %#010llx-%#010llx] for %s registers\n",

Why %#010llx instead of %#016llx?

Best Regards,
Huang Ying
