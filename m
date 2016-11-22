From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH V9 11/11] ARM64/PCI: Support for ACPI based PCI host
 controller
Date: Tue, 22 Nov 2016 17:13:21 -0600
Message-ID: <20161122231321.GA20246@bhelgaas-glaptop.roam.corp.google.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <1465588519-11334-12-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755651AbcKVXNn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Nov 2016 18:13:43 -0500
Content-Disposition: inline
In-Reply-To: <1465588519-11334-12-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org

Hi Tomasz,

On Fri, Jun 10, 2016 at 09:55:19PM +0200, Tomasz Nowicki wrote:
> Implement pci_acpi_scan_root and other arch-specific call so that ARM64
> can start using ACPI to setup and enumerate PCI buses.
> 
> Prior to buses enumeration the pci_acpi_scan_root() implementation looks
> for configuration space start address (obtained through ACPI _CBA method or
> MCFG interface). If succeed, it uses ECAM library to create new mapping.
> Then it attaches generic ECAM ops (pci_generic_ecam_ops) which are used
> for accessing configuration space later on.
> ...

> +static struct acpi_pci_root_ops acpi_pci_root_ops = {
> +	.release_info = pci_acpi_generic_release_info,
> +};
> +
> +/* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
> -	/* TODO: Should be revisited when implementing PCI on ACPI */
> -	return NULL;
> +	int node = acpi_get_node(root->device->handle);
> +	struct acpi_pci_generic_root_info *ri;
> +	struct pci_bus *bus, *child;
> +
> +	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> +	if (!ri)
> +		return NULL;
> +
> +	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> +	if (!ri->cfg) {
> +		kfree(ri);
> +		return NULL;
> +	}
> +
> +	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;

This has already been merged, but this isn't right, is it?  We're
writing a host controller-specific pointer into the single system-wide
acpi_pci_root_ops, then passing it on to acpi_pci_root_create().

Today, I think ri->cfg->ops->pci_ops is always &pci_generic_ecam_ops,
from this path:

  ri->cfg = pci_acpi_setup_ecam_mapping
    cfg = pci_ecam_create(..., &pci_generic_ecam_ops)
      cfg = kzalloc(...)
      cfg->ops = ops             # &pci_generic_ecam_ops

But we're about to merge the ECAM quirks series, which will mean it
may not be &pci_generic_ecam_ops.  Even apart from the ECAM quirks, we
should avoid this pattern of putting device-specific info in a single
shared structure because it's too difficult to verify that it's
correct.

> +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
> +				   ri->cfg);

Bjorn
