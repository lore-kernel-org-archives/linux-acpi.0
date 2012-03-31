From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI, psargs: Fix small mem leaks on error paths
Date: Sat, 31 Mar 2012 08:56:43 +0800
Message-ID: <1333155403.2939.0.camel@minggr>
References: <alpine.LNX.2.00.1202050210060.30244@swampdragon.chaosbits.net>
	 <4F755CAC.9070209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:38469 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2CaA4q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2012 20:56:46 -0400
In-Reply-To: <4F755CAC.9070209@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, Jesper Juhl <jj@chaosbits.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

We have ported this patch into ACPICA tree.

On Fri, 2012-03-30 at 03:11 -0400, Len Brown wrote:
> Bob?
> 
> On 02/04/2012 08:12 PM, Jesper Juhl wrote:
> 
> > As far as I can see, there are two small mem leaks in error paths of
> > 'acpi_ps_get_next_field()' where we neglect to free the memory
> > previously allocated to 'field'.
> > 
> > I believe this patch should fix the leaks.
> > 
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> > ---
> >  drivers/acpi/acpica/psargs.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> >  Note: Compile tested only.
> > 
> > diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
> > index 5ac36ab..a683d66 100644
> > --- a/drivers/acpi/acpica/psargs.c
> > +++ b/drivers/acpi/acpica/psargs.c
> > @@ -618,6 +618,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
> >  
> >  				arg = acpi_ps_alloc_op(AML_INT_BYTELIST_OP);
> >  				if (!arg) {
> > +					acpi_ps_free_op(field);
> >  					return_PTR(NULL);
> >  				}
> >  
> > @@ -662,6 +663,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
> >  		} else {
> >  			arg = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP);
> >  			if (!arg) {
> > +				acpi_ps_free_op(field);
> >  				return_PTR(NULL);
> >  			}
> >  
> 
> 


