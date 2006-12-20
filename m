From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 06/19] drivers/acpi/osl.c: fix a NULL check
Date: Wed, 20 Dec 2006 01:30:02 -0500
Message-ID: <200612200130.02294.lenb@kernel.org>
References: <200612192056.kBJKuDdQ010023@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47587 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964916AbWLTGhB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 01:37:01 -0500
In-Reply-To: <200612192056.kBJKuDdQ010023@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bunk@stusta.de

Applied.

(note the comment was incorrect this was introduced long before that commit).

Thanks Coverity, Adrian,
-Len

On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> From: Adrian Bunk <bunk@stusta.de>
> 
> This patch fixes a non-working NULL check introduced by commit
> b229cf92eee616c7cb5ad8cdb35a19b119f00bc8.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/osl.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/osl.c~drivers-acpi-oslc-fix-a-null-check drivers/acpi/osl.c
> --- a/drivers/acpi/osl.c~drivers-acpi-oslc-fix-a-null-check
> +++ a/drivers/acpi/osl.c
> @@ -1032,7 +1032,7 @@ acpi_status
>  acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
>  {
>  	*cache = kmem_cache_create(name, size, 0, 0, NULL, NULL);
> -	if (cache == NULL)
> +	if (*cache == NULL)
>  		return AE_ERROR;
>  	else
>  		return AE_OK;
> _
> 
