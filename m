From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control bits returned
 by a query (v2)
Date: Tue, 03 Aug 2010 13:52:43 +0900
Message-ID: <4C57A09B.9070206@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <201008022359.33177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:53999 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab0HCEw6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2010 00:52:58 -0400
In-Reply-To: <201008022359.33177.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

(2010/08/03 6:59), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rjw@sisk.pl>
>
> All of the remaining callers of acpi_pci_osc_control_set() either
> use acpi_pci_root_osc_query() right before it, like
> pcie_port_acpi_setup(), or ask for control of one feature only,
> like acpi_get_hp_hw_control_from_firmware().  Thus there is no
> reason to preserve the _OSC control bits returned by an _OSC query
> and the osc_control_qry and osc_queried fields of struct
> acpi_pci_root are not necessary any more.  Remove them and modify the
> code that uses them accordingly.
>
> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> Reviewed-by: Hidetoshi Seto<seto.hidetoshi@jp.fujitsu.com>
> ---
>   drivers/acpi/pci_root.c |   15 ---------------
>   include/acpi/acpi_bus.h |    3 ---
>   2 files changed, 18 deletions(-)
>
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -248,10 +248,8 @@ static acpi_status acpi_pci_query_osc(st
>   	status = acpi_pci_run_osc(root->device->handle, capbuf,&result);
>   	if (ACPI_SUCCESS(status)) {
>   		root->osc_support_set = support;
> -		root->osc_control_qry = result;
>   		if (control)
>   			*control = result;
> -		root->osc_queried = 1;
>   	}
>   	return status;
>   }
> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
>   	if ((root->osc_control_set&  control_req) == control_req)
>   		goto out;
>
> -	/* Need to query controls first before requesting them */
> -	if (!root->osc_queried) {
> -		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
> -		if (ACPI_FAILURE(status))
> -			goto out;
> -	}
> -	if ((root->osc_control_qry&  control_req) != control_req) {
> -		printk(KERN_DEBUG
> -		       "Firmware did not grant requested _OSC control\n");
> -		status = AE_SUPPORT;
> -		goto out;
> -	}

I think acpi_pci_osc_control_set() still need to query before commit
to ensure all the requested controls are granted to OS.

So the code needs to be

	status = acpi_pci_query_osc(root, root->osc_support_set, &control_req);
	if (ACPI_FAILURE(status))
		goto out;

Thanks,
Kenji Kaneshige

