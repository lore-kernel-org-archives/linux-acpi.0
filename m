From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI
 is not set
Date: Tue, 18 Dec 2018 10:14:01 +0800
Message-ID: <40e31e86-a4ac-d9a6-d752-b04203d5ced7@huawei.com>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181215010247.26101-7-okaya@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, linux-acpi@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Sinan,

On 2018/12/15 9:02, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..d0f68607efe6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1437,6 +1437,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  {
> +#ifdef CONFIG_PCI
>  	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>  		struct acpi_iort_node *parent;
>  		struct acpi_iort_id_mapping *map;
> @@ -1462,6 +1463,7 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  			}
>  		}
>  	}
> +#endif

I prefer stub function for iort_enable_acs(), not adding #ifdef/#endif pair inside
this function.

By the way, there are other pci function called in iort.c, could you explain a
little bit why no need to update other function calls in commit message?

Thanks
Hanjun
