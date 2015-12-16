From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v7 3/4] gicv2m: Refactor to prepare for ACPI support
Date: Wed, 16 Dec 2015 16:12:08 -0600
Message-ID: <20151216221208.GC27791@localhost>
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449766530-16935-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54187 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbLPWMM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2015 17:12:12 -0500
Content-Disposition: inline
In-Reply-To: <1449766530-16935-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

On Thu, Dec 10, 2015 at 08:55:29AM -0800, Suravee Suthikulpanit wrote:
> This patch replaces the struct device_node with struct fwnode_handle
> since this structure is common between DT and ACPI.
> 
> It also refactors gicv2m_init_one() to prepare for ACPI support.
> The only functional change is removing the node name from pr_info.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

> @@ -359,10 +355,10 @@ static int __init gicv2m_init_one(struct device_node *node,
>  	}
>  
>  	list_add_tail(&v2m->entry, &v2m_nodes);
> -	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
> -		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
> -		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
>  
> +	pr_info("range[%#lx:%#lx], SPI[%d:%d]\n",
> +		(unsigned long)res->start, (unsigned long)res->end,
> +		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));

You didn't change this, but I don't think this message has enough
context.  It's pretty cryptic all by itself.  It'd be nice if it could
at least include a device name, e.g., if you could use dev_info().

If that's possible, I guess a separate patch would be appropriate,
since there are other similar things in this file.

Bjorn
