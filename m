From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: return first _ADR match for acpi_get_child
Date: Fri, 16 Nov 2012 11:25:47 -0500
Message-ID: <50A6690B.2060805@kernel.org>
References: <8150264.b2f1OROKxE@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53054 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab2KPQZ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Nov 2012 11:25:57 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1830939qcr.19
        for <linux-acpi@vger.kernel.org>; Fri, 16 Nov 2012 08:25:57 -0800 (PST)
In-Reply-To: <8150264.b2f1OROKxE@al>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Sergio Perez <dagobertstaler@gmail.com>

Peter,

It is great that you debugged this issue
and proved where the problem is.

However, this patch can't possibly be the right way to go --
as it is just as broken as the code it replaces.
Were I to bet, I'd say that it will break as many machines
as it fixes.  And when it does, where are we?

Clearly we need to be using a more clever search algorithm.

thanks,
Len Brown, Intel Open Source Technology Center


On 11/12/2012 05:28 PM, Lekensteyn wrote:
> From: Peter Wu <lekensteyn@gmail.com>
> 
> When acpi_get_child is called, it loops through all direct child
> devices and calls do_acpi_find_child to find an ACPI handle matching the
> _ADR. The previous implementation visits every direct child, if there
> were multiple devices with a matching _ADR, the last match was always
> returned.
> 
> This behaviour (returning the last result) does not work for many recent
> Lenovo machines when looking for the correct ACPI handle for a Nvidia
> PCI video device. On these machines, the first handle should be used
> instead of the last one. On these machines, the PCI Bus ID is 01:00.0,
> hence the address that is searched for is 0 (via acpi_pci_find_device).
> 
> When acpi_pci_find_device calls acpi_get_child, it iterates through:
> 
>     Address: 00000000 (valid); handle: \_SB_.PCI0.PEG0.PEGP
>     Address: 00000001 (valid); handle: \_SB_.PCI0.PEG0.VGA1
>     Address: 00000000 (valid); handle: \_SB_.PCI0.PEG0.VGA_
> 
> The correct handle here is "\_SB_.PCI0.PEG0.PEGP" which contains the
> _ROM method as well as _PSx for PM, and not \_SB.PCI0.PEG0.VGA.
> 
> On my own laptop, and many others I believe, there is only one matching
> handle for a PCI device. The acpi_get_child method has been added in
> 2005, 4e10d12a3d88c88fba3258809aa42d14fd8cf1d1, and there is no message
> indicating that the last (or first) handle should be returned. However,
> it is kind of useless to iterate from beginning to the end if you only
> need the last match. Therefore, just return the first match (which is
> likely the last one too in almost all cases).
> 
> Verified to work for an affected Lenovo Ideapad Y480, tested for no
> regressions on my laptop (Clevo B7130).
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=42696
> 
> Tested-by: Sergio Perez <dagobertstaler@gmail.com>
> Signed-off-by: Peter Wu <lekensteyn@gmail.com>
> ---
>  drivers/acpi/glue.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 0837308..dc9c945 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -99,18 +99,20 @@ struct acpi_find_child {
>  static acpi_status
>  do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
>  {
> -	acpi_status status;
> +	acpi_status status, ret = AE_OK;
>  	struct acpi_device_info *info;
>  	struct acpi_find_child *find = context;
>  
>  	status = acpi_get_object_info(handle, &info);
>  	if (ACPI_SUCCESS(status)) {
>  		if ((info->address == find->address)
> -			&& (info->valid & ACPI_VALID_ADR))
> +			&& (info->valid & ACPI_VALID_ADR)) {
>  			find->handle = handle;
> +			ret = AE_CTRL_TERMINATE;
> +		}
>  		kfree(info);
>  	}
> -	return AE_OK;
> +	return ret;
>  }
>  
>  acpi_handle acpi_get_child(acpi_handle parent, u64 address)
> 

