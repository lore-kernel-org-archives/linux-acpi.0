From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: Add the check of ADR flag in course of finding
	ACPI handle for PCI device
Date: Wed, 21 Jul 2010 10:15:46 +0800
Message-ID: <1279678546.13929.0.camel@localhost.localdomain>
References: <1278992168-7457-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34845 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932963Ab0GUCTe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 22:19:34 -0400
In-Reply-To: <1278992168-7457-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-07-13 at 11:36 +0800, Zhao, Yakui wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The _ADR object is used to provide OSPM with the address of one device on its
> parent bus. In course of finding ACPI handle for the corresponding PCI device,
> we will firstly evaluate the _ADR object and then compare the two addresses to
> see whether it is the target ACPI device. But for one PCI device(0000:00:00.0)
> under the PCI root bridge, the corresponding address will be constructed as
> zero.In such case maybe the ACPI device without _ADR object will be misdetected
> and then be used to create the relationship between PCI device and ACPI device.

This patch is to fix the following bug:

https://bugzilla.kernel.org/show_bug.cgi?id=16422

> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/glue.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 4af6301..78b0164 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -100,7 +100,8 @@ do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
>  
>  	status = acpi_get_object_info(handle, &info);
>  	if (ACPI_SUCCESS(status)) {
> -		if (info->address == find->address)
> +		if ((info->address == find->address)
> +			&& (info->valid & ACPI_VALID_ADR))
>  			find->handle = handle;
>  		kfree(info);
>  	}

