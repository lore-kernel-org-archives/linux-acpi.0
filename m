From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic  allocation
Date: Wed, 16 Aug 2006 19:02:01 -0400
Message-ID: <200608161902.02221.len.brown@intel.com>
References: <200608150537.k7F5bTu8011560@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57060 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932316AbWHPXAY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 19:00:24 -0400
In-Reply-To: <200608150537.k7F5bTu8011560@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, jikos@jikos.cz

On Tuesday 15 August 2006 01:37, akpm@osdl.org wrote:
> From: Jiri Kosina <jikos@jikos.cz>
> 
> acpi_pci_link_set() allocates with GFP_ATOMIC. On resume from suspend,
> this is called with interrupts off, otherwise GFP_KERNEL is safe.

So you are suggesting this?

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 7f3e7e7..d53bd98 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -307,7 +307,7 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return -EINVAL;
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	resource = kmalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
 


> On the other hand, when resuming from suspend with interrupts off, the
> following callchain allocates with GFP_KERNEL, which is wrong:
>
> acpi_pci_link_resume -> acpi_pci_link_set -> acpi_set_current_resources ->
> acpi_rs_set_srs_method_data -> acpi_ut_create_internal_object_dbg ->
> acpi_ut_allocate_object_desc_dbg -> acpi_os_acquire_object ->
> kmem_cache_alloc(GFP_KERNEL) flag.

I don't understand this comment.
acpi_os_acquire_object is implemented in aclinux.h:

static inline void *acpi_os_acquire_object(acpi_cache_t * cache) {
        return kmem_cache_zalloc(cache, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
}

-Len

> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/pci_link.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/pci_link.c~acpi-change-gfp_atomic-to-gfp_kernel-for-non-atomic drivers/acpi/pci_link.c
> --- a/drivers/acpi/pci_link.c~acpi-change-gfp_atomic-to-gfp_kernel-for-non-atomic
> +++ a/drivers/acpi/pci_link.c
> @@ -307,7 +307,12 @@ static int acpi_pci_link_set(struct acpi
>  	if (!link || !irq)
>  		return -EINVAL;
>  
> -	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
> +	/* irqs could be disabled when resuming from suspend */
> +	if (irqs_disabled())
> +		resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
> +	else
> +		resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
> +
>  	if (!resource)
>  		return -ENOMEM;
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
