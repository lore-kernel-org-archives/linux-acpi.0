From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Add Intel Poulsbo Stub Driver
Date: Wed, 1 Sep 2010 08:00:52 -0700
Message-ID: <20100901150052.GA26036@suse.de>
References: <1283332119-26352-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40744 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754953Ab0IAPAk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Sep 2010 11:00:40 -0400
Content-Disposition: inline
In-Reply-To: <1283332119-26352-1-git-send-email-jlee@novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, mjg@redhat.com, jlee@novell.com, Dennis.Jansen@web.de, linux-acpi@vger.kernel.org, trenn@suse.de

On Wed, Sep 01, 2010 at 05:08:39PM +0800, Lee, Chun-Yi wrote:
> +static struct pci_device_id pciidlist[] = {
> +	{0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8108}, \
> +	{0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8109}, \
> +	{0, 0, 0}
> +};

Now that you have this, just use:
	MODULE_DEVICE_TABLE(pci, pciidlist);
instead of:

> +MODULE_ALIAS("pci:v00008086d00008108sv*sd*bc*sc*i*");
> +MODULE_ALIAS("pci:v00008086d00008109sv*sd*bc*sc*i*");

As the proper alias will automatically get generated from the
MODULE_DEVICE_TABLE() macro.

thanks,

greg k-h
