From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] trival: fix acpi_hest_firmware_first_pci() caused oops
Date: Tue, 20 Apr 2010 11:01:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004201100220.2402@sony>
References: <1270696575-3385-1-git-send-email-shaohua.li@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [12.175.186.2] ([12.175.186.2]:41717 "EHLO
	vbn.0055647.lodgenet.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932798Ab0EABom (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Apr 2010 21:44:42 -0400
In-Reply-To: <1270696575-3385-1-git-send-email-shaohua.li@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

wouldn't it be better for acpi_get_table()
to return failure for acpi=off?

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 8 Apr 2010, Shaohua Li wrote:

> acpi_hest_firmware_first_pci() could be called when acpi is disabled
> and cause system oops.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/hest.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/hest.c b/drivers/acpi/hest.c
> index 4bb18c9..1c527a1 100644
> --- a/drivers/acpi/hest.c
> +++ b/drivers/acpi/hest.c
> @@ -123,6 +123,10 @@ int acpi_hest_firmware_first_pci(struct pci_dev *pci)
>  {
>  	acpi_status status = AE_NOT_FOUND;
>  	struct acpi_table_header *hest = NULL;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
>  	status = acpi_get_table(ACPI_SIG_HEST, 1, &hest);
>  
>  	if (ACPI_SUCCESS(status)) {
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
