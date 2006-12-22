From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 06/19] drivers/acpi/osl.c: fix a NULL check
Date: Fri, 22 Dec 2006 09:17:30 +0100
Message-ID: <20061222081730.GN6993@stusta.de>
References: <200612192056.kBJKuDdQ010023@shell0.pdx.osdl.net> <200612200130.02294.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3683 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1945967AbWLVIRa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Dec 2006 03:17:30 -0500
Content-Disposition: inline
In-Reply-To: <200612200130.02294.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

On Wed, Dec 20, 2006 at 01:30:02AM -0500, Len Brown wrote:
> Applied.
> 
> (note the comment was incorrect this was introduced long before that commit).

It was introduced by this commit since this commit added the NULL check.

> Thanks Coverity, Adrian,
> -Len
> 
> On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> > From: Adrian Bunk <bunk@stusta.de>
> > 
> > This patch fixes a non-working NULL check introduced by commit
> > b229cf92eee616c7cb5ad8cdb35a19b119f00bc8.
> > 
> > Spotted by the Coverity checker.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> >  drivers/acpi/osl.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff -puN drivers/acpi/osl.c~drivers-acpi-oslc-fix-a-null-check drivers/acpi/osl.c
> > --- a/drivers/acpi/osl.c~drivers-acpi-oslc-fix-a-null-check
> > +++ a/drivers/acpi/osl.c
> > @@ -1032,7 +1032,7 @@ acpi_status
> >  acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
> >  {
> >  	*cache = kmem_cache_create(name, size, 0, 0, NULL, NULL);
> > -	if (cache == NULL)
> > +	if (*cache == NULL)
> >  		return AE_ERROR;
> >  	else
> >  		return AE_OK;
> > _
> > 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

