From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [patch 2/4]  acpiphp: handle dock bridges
Date: Wed, 18 Jan 2006 11:26:41 +0900
Message-ID: <43CDA761.5040707@jp.fujitsu.com>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38559 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751369AbWARC2c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 21:28:32 -0500
In-Reply-To: <1137545819.19858.47.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz

Hi,

> +static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
> +					struct pci_dev *dev)
> +{
> +	struct list_head *l;
> +	struct acpiphp_func *func;
> +	struct pci_bus *bus = slot->bridge->pci_bus;
> +
> +	list_for_each (l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);
> +		if (pci_get_slot(bus, PCI_DEVFN(slot->device,
> +					func->function)) == dev)
> +			return func;
> +	}

This seems to leak reference counter of pci_dev. I think you
must call pci_dev_put() also.

Thanks,
Kenji Kaneshige
