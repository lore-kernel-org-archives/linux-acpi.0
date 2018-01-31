From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/PCI: pci_link: remove error messages when no _PRS methods
Date: Wed, 31 Jan 2018 10:20:51 +0100
Message-ID: <1646413.6Bc7kdyLTf@aspire.rjw.lan>
References: <1517377939-9817-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:64789 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeAaJW0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2018 04:22:26 -0500
In-Reply-To: <1517377939-9817-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Wednesday, January 31, 2018 6:52:19 AM CET Alex Hung wrote:
> In recent Intel hardware the IRQs become non-configurable after BIOS
> initializes them in PEI phase and _PRS objects are no longer included in
> ASL.
> 
> This is the same as "static (non-configurable) devices do not
> specify a _PRS object" in ACPI spec. As a result, error messages
> saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" are not
> needed.

That's questionable at best.

The errors basically indicate that _PRT entries corresponding to these
IRQs are messed up (because they should contain the value of 0 instead of
a NamePath in the Source column), so we are now going to paper over bugs
in ACPI tables as someone in the firmware land cannot be bothered with
putting correct values into them. :-/

> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/pci_link.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 85ad679390e3..f98215971f30 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -172,10 +172,8 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
>  
>  	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
>  				     acpi_pci_link_check_possible, link);
> -	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
> +	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> -	}
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			  "Found %d possible IRQs\n",
> 


