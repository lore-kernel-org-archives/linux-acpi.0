From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Fix possible null ptr dereference
Date: Fri, 17 Oct 2008 12:44:08 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810171244000.3006@localhost.localdomain>
References: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50899 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbYJQQoT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 12:44:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8W00AX26HLLS51@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 11:44:10 -0500 (CDT)
In-reply-to: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: donald.d.dugger@intel.com
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, akpm@linux-foundation.org, astarikovskiy@suse.de

applied.

thanks,
-Len

On Fri, 17 Oct 2008, donald.d.dugger@intel.com wrote:

> Code in `pci_link.c' is calling the internal routine `acpi_ut_evaluate_object'
> which is dangerous given that it is passing a NULL pointer when it should
> be passing a pointer to a real object.  The patch corrects the issue by
> having the code call the external routine `acpi_evaluate_object', which
> correctly handles a NULL pointer.
> 
> Signed-off-by: Don Dugger <donald.d.dugger@intel.com>
> 
> 
> ----- cut here for patch.d/acpi_null-1017.patch -----
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index cf47805..65bf4fa 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -709,7 +709,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
>  			  acpi_device_bid(link->device)));
>  
>  	if (link->refcnt == 0) {
> -		acpi_ut_evaluate_object(link->device->handle, "_DIS", 0, NULL);
> +		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
>  	}
>  	mutex_unlock(&acpi_link_lock);
>  	return (link->irq.active);
> @@ -773,7 +773,7 @@ static int acpi_pci_link_add(struct acpi_device *device)
>  
>        end:
>  	/* disable all links -- to be activated on use */
> -	acpi_ut_evaluate_object(device->handle, "_DIS", 0, NULL);
> +	acpi_evaluate_object(device->handle, "_DIS", NULL, NULL);
>  	mutex_unlock(&acpi_link_lock);
>  
>  	if (result)
> 
