From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] -  Altix: more ACPI PRT support
Date: Fri, 2 Feb 2007 21:56:42 -0500
Message-ID: <200702022156.42805.lenb@kernel.org>
References: <20070202205412.14367.60290.sendpatchset@attica.americas.sgi.com> <20070202173746.9fc66172.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51386 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946238AbXBCC6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Feb 2007 21:58:09 -0500
In-Reply-To: <20070202173746.9fc66172.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: John Keller <jpk@sgi.com>, linux-acpi@vger.kernel.org, ayoung@sgi.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>

On Friday 02 February 2007 20:37, Andrew Morton wrote:
> On Fri, 02 Feb 2007 14:54:12 -0600
> John Keller <jpk@sgi.com> wrote:
> 
> > The SN Altix platform does not conform to the 
> > IOSAPIC IRQ routing model. Add code in acpi_unregister_gsi()
> > to check if (acpi_irq_model == ACPI_IRQ_MODEL_PLATFORM) and
> > return.
> > 
> > Signed-off-by: John Keller <jpk@sgi.com>
> > ---
> > 
> > Due to an oversight, this code was not added previously when
> > similar code was added to acpi_register_gsi().
> > 
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=116680983430121&w=2
> > 
> >  arch/ia64/kernel/acpi.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > 
> > Index: linux-2.6/arch/ia64/kernel/acpi.c
> > ===================================================================
> > --- linux-2.6.orig/arch/ia64/kernel/acpi.c	2007-02-02 14:44:31.000000000 -0600
> > +++ linux-2.6/arch/ia64/kernel/acpi.c	2007-02-02 14:47:44.658143727 -0600
> > @@ -609,6 +609,9 @@ EXPORT_SYMBOL(acpi_register_gsi);
> >  
> >  void acpi_unregister_gsi(u32 gsi)
> >  {
> > +	if (acpi_irq_model == ACPI_IRQ_MODEL_PLATFORM)
> > +		return;
> > +
> >  	iosapic_unregister_intr(gsi);
> >  }
> 
> Given that the December 22 patch appears to be in mainline, and that this
> patch is simple, I shall cheerily bypass maintainers and send it in for
> 2.6.20.

Yep.

Acked-by: Len Brown <len.brown@intel.com>

thanks,
-Len

