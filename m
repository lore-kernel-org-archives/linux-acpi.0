From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 02/19] acpi: fix single linked list manipulation
Date: Wed, 20 Dec 2006 00:43:27 -0500
Message-ID: <200612200043.27289.lenb@kernel.org>
References: <200612192056.kBJKuAIb010011@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39618 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964891AbWLTFn6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 00:43:58 -0500
In-Reply-To: <200612192056.kBJKuAIb010011@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, akinobu.mita@gmail.com

Applied.

thanks,
-Len

On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Fix single linked list manipulation for sub_driver.  If the remving entry
> is not on the head of the sub_driver list, it goes into infinate loop.
> 
> Though that infinite loop doesn't happen.  Because the only user of
> acpi_pci_register_dirver() is acpiphp.
> 
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/pci_root.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff -puN drivers/acpi/pci_root.c~acpi-fix-single-linked-list-manipulation drivers/acpi/pci_root.c
> --- a/drivers/acpi/pci_root.c~acpi-fix-single-linked-list-manipulation
> +++ a/drivers/acpi/pci_root.c
> @@ -98,11 +98,12 @@ void acpi_pci_unregister_driver(struct a
>  
>  	struct acpi_pci_driver **pptr = &sub_driver;
>  	while (*pptr) {
> -		if (*pptr != driver)
> -			continue;
> -		*pptr = (*pptr)->next;
> -		break;
> +		if (*pptr == driver)
> +			break;
> +		pptr = &(*pptr)->next;
>  	}
> +	BUG_ON(!*pptr);
> +	*pptr = (*pptr)->next;
>  
>  	if (!driver->remove)
>  		return;
> _
> 
