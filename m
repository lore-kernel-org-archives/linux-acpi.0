From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 217/493] acpi: remove use of __devinit
Date: Wed, 21 Nov 2012 01:46:36 +0100
Message-ID: <3003032.3Hm8RaEcML@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-217-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56778 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab2KUAmJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2012 19:42:09 -0500
In-Reply-To: <1353349642-3677-217-git-send-email-wfp5p@virginia.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org

On Monday, November 19, 2012 01:22:46 PM Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: linux-acpi@vger.kernel.org 
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  drivers/acpi/hed.c       | 2 +-
>  drivers/acpi/pci_root.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1599566..73bca11 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -901,7 +901,7 @@ static unsigned long ghes_esource_prealloc_size(
>  	return prealloc_size;
>  }
>  
> -static int __devinit ghes_probe(struct platform_device *ghes_dev)
> +static int ghes_probe(struct platform_device *ghes_dev)
>  {
>  	struct acpi_hest_generic *generic;
>  	struct ghes *ghes = NULL;
> diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
> index 20a0f2c..0ec28a3 100644
> --- a/drivers/acpi/hed.c
> +++ b/drivers/acpi/hed.c
> @@ -61,7 +61,7 @@ static void acpi_hed_notify(struct acpi_device *device, u32 event)
>  	blocking_notifier_call_chain(&acpi_hed_notify_list, 0, NULL);
>  }
>  
> -static int __devinit acpi_hed_add(struct acpi_device *device)
> +static int acpi_hed_add(struct acpi_device *device)
>  {
>  	/* Only one hardware error device */
>  	if (hed_handle)
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ab781f0..7928d4d 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -445,7 +445,7 @@ out:
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> -static int __devinit acpi_pci_root_add(struct acpi_device *device)
> +static int acpi_pci_root_add(struct acpi_device *device)
>  {
>  	unsigned long long segment, bus;
>  	acpi_status status;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
