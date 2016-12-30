From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 08/14] ACPI: ARM64: IORT: rework iort_node_get_id()
Date: Fri, 30 Dec 2016 17:00:34 +0800
Message-ID: <58662232.2010001@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-9-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482384922-21507-9-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> iort_node_get_id() has two output, one is the mapped ids,
> the other is the referenced parent node which is returned
> from the function.
>
> For now we need a API just return its parent node for
> single mapping, so just update this function slightly then
> reuse it later.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/acpi/arm64/iort.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ab7bae7..bc68d93 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -347,7 +347,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>   	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			*id_out = map[index].output_base;
> +			if (id_out)
> +				*id_out = map[index].output_base;
>   			return parent;
>   		}
>   	}
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>
