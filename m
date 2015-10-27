From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH V4 7/8] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
Date: Tue, 27 Oct 2015 09:38:12 -0500
Message-ID: <20151027143812.GB8660@localhost>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54518 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbbJ0OiU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2015 10:38:20 -0400
Content-Disposition: inline
In-Reply-To: <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, davem@davemloft.net, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Murali Karicheri <m-karicheri2@ti.com>

Hi Suravee,

On Wed, Oct 21, 2015 at 08:52:10AM -0700, Suravee Suthikulpanit wrote:
> This patch move of_pci_dma_configure() to a more generic
> pci_dma_configure(), which can be extended by non-OF code (e.g. ACPI).

> -void of_pci_dma_configure(struct pci_dev *pci_dev)
> -{
> -	struct device *dev = &pci_dev->dev;
> -	struct device *bridge = pci_get_host_bridge_device(pci_dev);
> -
> -	if (!bridge->parent)
> -		return;
> -
> -	of_dma_configure(dev, bridge->parent->of_node);
> -	pci_put_host_bridge_device(bridge);
> -}

> +static void pci_dma_configure(struct pci_dev *dev)
> +{
> +	struct device *bridge = pci_get_host_bridge_device(dev);
> +
> +	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> +		if (!bridge->parent)
> +			return;

Don't we leak a bridge reference here?  This looks like it was a problem in
the original code, not something you added.  Ideally I guess I would add a
new patch that only fixes the leak in the original code, followed by this
patch that moves it from of_pci_dma_configure() to pci_dma_configure().

> +
> +		of_dma_configure(&dev->dev, bridge->parent->of_node);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +}
