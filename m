From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] libata-acpi: Fix NULL ptr derference in ata_acpi_dev_handle
Date: Thu, 11 Oct 2012 15:57:52 +0800
Message-ID: <50767C00.6070001@intel.com>
References: <5073D44C.7070101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28573 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757748Ab2JKH6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2012 03:58:15 -0400
In-Reply-To: <5073D44C.7070101@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan van der Ster <dan@vanderster.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Dan,

It would be good if you can give this patch a Tested-by tag, thanks.

-Aaron

On 10/09/2012 03:37 PM, Aaron Lu wrote:
> commit 6b66d95895c149cbc04d4fac5a2f5477c543a8ae didn't handle SATA PMP
> case in ata_acpi_bind_device and will cause a NULL ptr dereference when
> user attached a SATA drive to the PMP port. Fix this by checking PMP
> support.
> 
> This bug is reported by Dan van der Ster in the following bugzilla page:
> https://bugzilla.kernel.org/show_bug.cgi?id=48211
> 
> Reported-by: Dan van der Ster <dan@vanderster.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/ata/libata-acpi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index fd9ecf7..5b0ba3f 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -1105,10 +1105,15 @@ static int ata_acpi_bind_device(struct ata_port *ap, struct scsi_device *sdev,
>  	struct acpi_device *acpi_dev;
>  	struct acpi_device_power_state *states;
>  
> -	if (ap->flags & ATA_FLAG_ACPI_SATA)
> -		ata_dev = &ap->link.device[sdev->channel];
> -	else
> +	if (ap->flags & ATA_FLAG_ACPI_SATA) {
> +		if (!sata_pmp_attached(ap))
> +			ata_dev = &ap->link.device[sdev->id];
> +		else
> +			ata_dev = &ap->pmp_link[sdev->channel].device[sdev->id];
> +	}
> +	else {
>  		ata_dev = &ap->link.device[sdev->id];
> +	}
>  
>  	*handle = ata_dev_acpi_handle(ata_dev);
>  
> 

