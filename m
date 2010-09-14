From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI: apei: Cast u64 to unsigned long, fix compile
 warning
Date: Tue, 14 Sep 2010 08:54:53 +0800
Message-ID: <1284425693.2256.12.camel@yhuang-dev.sh.intel.com>
References: <1284299305.7239.4.camel@lenovo>
	 <20100913130035.decb0d44.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37359 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab0INAy5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Sep 2010 20:54:57 -0400
In-Reply-To: <20100913130035.decb0d44.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Len Brown <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

Hi, Andrew,

On Tue, 2010-09-14 at 04:00 +0800, Andrew Morton wrote:
> On Sun, 12 Sep 2010 09:48:25 -0400
> Javier Martinez Canillas <martinez.javier@gmail.com> wrote:
> 
> > In today linux-net I got a compile warning in acpi/apei
> > 
> > drivers/acpi/apei/erst.c: In function ___erst_exec_move_data___:
> > drivers/acpi/apei/erst.c:273: warning: cast to pointer from integer of different size
> > drivers/acpi/apei/erst.c:274: warning: cast to pointer from integer of different size
> > 
> > The problem is that apei_exec_context->dst_base type is u64.
> > But in 32 bits architecture void * is 32 bits long. 
> > Casting it to unsigned long solves the issue
> > 
> > Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
> > ---
> >  drivers/acpi/apei/erst.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> > index a4904f1..37d7a05 100644
> > --- a/drivers/acpi/apei/erst.c
> > +++ b/drivers/acpi/apei/erst.c
> > @@ -270,8 +270,8 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
> >  	rc = __apei_exec_read_register(entry, &offset);
> >  	if (rc)
> >  		return rc;
> > -	memmove((void *)ctx->dst_base + offset,
> > -		(void *)ctx->src_base + offset,
> > +	memmove((void *)(unsigned long)ctx->dst_base + offset,
> > +		(void *)(unsigned long)ctx->src_base + offset,
> >  		ctx->var2);
> >  
> >  	return 0;
> 
> This might indicate that the incorrect types were used within the
> `struct apei_exec_context'.  I can't tell (or can't be bothered working
> it out), because whoever wrote that didn't bother documenting any of it
> at all.

Sorry about lacking the document. All these code are based on ACPI
specification 4.0a, section 17.5 "Error Serialization". The fields in
struct apei_exec_context such as var1, var2, src_base, dst_base, etc
come from there too. I will add some document for it.

> Are those things kernel virtual addresses?  If so, a pointer type
> should have been used.

Sorry, I found another bug here. These should be physical memory and
should be ioremapped before accessing. I will fix it as soon as
possible.

Best Regards,
Huang Ying


