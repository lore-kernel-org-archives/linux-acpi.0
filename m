From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 01/14] ACPI: ARM64: IORT: minor cleanup for
 iort_match_node_callback()
Date: Fri, 30 Dec 2016 16:56:28 +0800
Message-ID: <5866213C.9010203@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-2-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:30024 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbcL3I5x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2016 03:57:53 -0500
In-Reply-To: <1482384922-21507-2-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> Cleanup iort_match_node_callback() a little bit to reduce
> some lines of code, aslo fix the indentation in iort_scan_node().
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/acpi/arm64/iort.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e0d2e6e..46e2d82 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -225,7 +225,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
>   
>   		if (iort_node->type == type &&
>   		    ACPI_SUCCESS(callback(iort_node, context)))
> -				return iort_node;
> +			return iort_node;
>   
>   		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
>   					 iort_node->length);
> @@ -253,17 +253,15 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>   					    void *context)
>   {
>   	struct device *dev = context;
> -	acpi_status status;
> +	acpi_status status = AE_NOT_FOUND;
>   
>   	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
>   		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>   		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
>   		struct acpi_iort_named_component *ncomp;
>   
> -		if (!adev) {
> -			status = AE_NOT_FOUND;
> +		if (!adev)
>   			goto out;
> -		}
>   
>   		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
>   		if (ACPI_FAILURE(status)) {
> @@ -289,8 +287,6 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>   		 */
>   		status = pci_rc->pci_segment_number == pci_domain_nr(bus) ?
>   							AE_OK : AE_NOT_FOUND;
> -	} else {
> -		status = AE_NOT_FOUND;
>   	}
>   out:
>   	return status;
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>

