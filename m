From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi notifier hook
	functions
Date: Mon, 26 Jul 2010 16:11:48 +0100
Message-ID: <20100726151148.GA31084@srcf.ucam.org>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com> <1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52341 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab0GZPMI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jul 2010 11:12:08 -0400
Content-Disposition: inline
In-Reply-To: <1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, minyard@acm.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Mon, Jul 26, 2010 at 10:46:04PM +0800, yakui.zhao@intel.com wrote:
> @@ -2133,6 +2142,11 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
>  	if (!info)
>  		return -ENOMEM;
>  
> +	pnp_ipmi = kzalloc(sizeof(*pnp_ipmi), GFP_KERNEL);
> +	if (!pnp_ipmi) {
> +		kfree(info);
> +		return -ENOMEM;
> +	}

This will never get called if the hardware has a PCI IPMI interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
