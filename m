From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2_v7] ACPI: Export symbol of pnp_bus_type
Date: Wed, 14 Jul 2010 10:57:54 -0600
Message-ID: <201007141057.54420.bjorn.helgaas@hp.com>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com> <1279112094-16749-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:39146 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0GNQ54 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2010 12:57:56 -0400
In-Reply-To: <1279112094-16749-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, minyard@acm.org

On Wednesday, July 14, 2010 06:54:53 am yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>

This should have a changelog saying *why* we need to export
pnp_bus_type.

I looked it up myself, and I see that the next patch adds
acpi_ipmi, which can be a module, and acpi_ipmi references
pnp_bus_type.

I don't like this exposure of pnp_bus_type.  I don't think
drivers should be using it.  I'll comment more in a response
to the next patch.

Bjorn

> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/pnp/driver.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index cd11b11..9aec98a 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -218,6 +218,8 @@ struct bus_type pnp_bus_type = {
>  	.dev_attrs = pnp_interface_attrs,
>  };
>  
> +EXPORT_SYMBOL(pnp_bus_type);
> +
>  int pnp_register_driver(struct pnp_driver *drv)
>  {
>  	drv->driver.name = drv->name;
> 
