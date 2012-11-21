From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 387/493] acpi: remove use of __devexit
Date: Wed, 21 Nov 2012 01:46:25 +0100
Message-ID: <1897683.O1u4QRqlH7@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-387-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56771 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab2KUAl6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2012 19:41:58 -0500
In-Reply-To: <1353349642-3677-387-git-send-email-wfp5p@virginia.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org

On Monday, November 19, 2012 01:25:36 PM Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: linux-acpi@vger.kernel.org 
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  drivers/acpi/hed.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 73bca11..7ae2750 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -994,7 +994,7 @@ err:
>  	return rc;
>  }
>  
> -static int __devexit ghes_remove(struct platform_device *ghes_dev)
> +static int ghes_remove(struct platform_device *ghes_dev)
>  {
>  	struct ghes *ghes;
>  	struct acpi_hest_generic *generic;
> diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
> index 0ec28a3..a0cc796 100644
> --- a/drivers/acpi/hed.c
> +++ b/drivers/acpi/hed.c
> @@ -70,7 +70,7 @@ static int acpi_hed_add(struct acpi_device *device)
>  	return 0;
>  }
>  
> -static int __devexit acpi_hed_remove(struct acpi_device *device, int type)
> +static int acpi_hed_remove(struct acpi_device *device, int type)
>  {
>  	hed_handle = NULL;
>  	return 0;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
