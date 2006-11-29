From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 01/21] ACPI: ibm-acpi: do not use / in driver names
Date: Wed, 29 Nov 2006 17:08:57 +0800
Message-ID: <1164791337.6097.15.camel@localhost.localdomain>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
	 <20061125204216.6604.44912.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1926 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966428AbWK2JFV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Nov 2006 04:05:21 -0500
In-Reply-To: <20061125204216.6604.44912.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Sat, 2006-11-25 at 18:42 -0200, Henrique de Moraes Holschuh wrote:
> From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
> a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
> Rui for noticing this.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
> 
>  drivers/acpi/ibm_acpi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
> index 9658253..9baae34 100644
> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -1854,7 +1854,7 @@ static int __init register_driver(struct
>  	}
>  
>  	memset(ibm->driver, 0, sizeof(struct acpi_driver));
> -	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
> +	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
>  	ibm->driver->ids = ibm->hid;
>  	ibm->driver->ops.add = &ibm_device_add;
>  
I think this patch should be added to ACPI sysfs patch series, as it's
critical for ACPI sysfs conversion. We should make sure that the patches
won't break ibm_acpi any longer. :)
