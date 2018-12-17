From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
Date: Mon, 17 Dec 2018 11:04:54 +0100
Message-ID: <2768059.sVLBmlUf0W@aspire.rjw.lan>
References: <20181215010247.26101-1-okaya@kernel.org> <20181215010247.26101-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181215010247.26101-7-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, December 15, 2018 2:02:47 AM CET Sinan Kaya wrote:
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
>  
>  	return false;
>  }
> 

I need a maintainer ACK here.
