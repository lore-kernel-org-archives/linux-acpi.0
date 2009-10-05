From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] ACPI / PCI: Fix NULL pointer dereference in
	acpi_get_pci_dev()
Date: Mon, 5 Oct 2009 17:37:59 -0600
Message-ID: <20091005233759.GB14394@ldl.fc.hp.com>
References: <200910060130.43246.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:36231 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701AbZJEXih (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 19:38:37 -0400
Content-Disposition: inline
In-Reply-To: <200910060130.43246.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Danny Feng <dfeng@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, chepioq@gmail.com

* Rafael J. Wysocki <rjw@sisk.pl>:
> 
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14129, which is a
> regression from 2.6.30.

Thanks for doing this.

One small comment below (not major), but other than that:

Reviewed-by: Alex Chiang <achiang@hp.com>

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-by: Danny Feng <dfeng@redhat.com>
> Tested-by: chepioq <chepioq@gmail.com>
> ---
>  drivers/acpi/pci_root.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -389,6 +389,18 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
>  
>  		pbus = pdev->subordinate;
>  		pci_dev_put(pdev);
> +
> +		/*
> +		 * During resume from a sleep state we can get a dock
> +		 * notification for a device that is present in ACPI tables,
> +		 * but not physically accessible at the moment, so tell the
> +		 * caller it's not present in that case.
> +		 */
> +		if (!pbus) {
> +			dev_info(&pdev->dev, "Secondary bus not present\n");

Should this be dev_dbg() or maybe even strike it completely?

> +			pdev = NULL;
> +			break;
> +		}
>  	}
>  out:
>  	list_for_each_entry_safe(node, tmp, &device_list, node)
> 
