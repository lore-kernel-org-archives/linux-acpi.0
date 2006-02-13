From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] HPET: handle multiple ACPI EXTENDED_IRQ resources
Date: Mon, 13 Feb 2006 14:24:28 -0700
Message-ID: <200602131424.28369.bjorn.helgaas@hp.com>
References: <200602071650.27379.bjorn.helgaas@hp.com> <20060212225528.GC21804@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:30899 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030192AbWBMVYc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Feb 2006 16:24:32 -0500
In-Reply-To: <20060212225528.GC21804@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Picco <bob.picco@hp.com>
Cc: Bob Picco <robert.picco@hp.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>

Andrew, I know it's late in the 2.6.16 cycle, but it would be really
nice if this patch made it.  Without it, HPETs on new HP boxes don't
work, so we're going to have to get it in the distros some way or
another.

On Sunday 12 February 2006 15:55, Bob Picco wrote:
> Bjorn Helgaas wrote:	[Tue Feb 07 2006, 06:50:27PM EST]
> > When the _CRS for a single HPET contains multiple EXTENDED_IRQ
> > resources, we overwrote hdp->hd_nirqs every time we found one.
> > 
> > So the driver worked when all the IRQs were described in a
> > single EXTENDED_IRQ resource, but failed when multiple resources
> > were used.  (Strictly speaking, I think the latter is actually
> > more correct, but both styles have been used.)
> > 
> > Someday we should remove all the ACPI stuff from hpet.c and use
> > PNP driver registration instead.  But currently PNP_MAX_IRQ is 2,
> > and HPETs often have more IRQs.  Hint, hint, Adam :-)
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > Index: work-mm4/drivers/char/hpet.c
> > ===================================================================
> > --- work-mm4.orig/drivers/char/hpet.c	2006-02-07 16:18:46.000000000 -0700
> > +++ work-mm4/drivers/char/hpet.c	2006-02-07 16:29:00.000000000 -0700
> > @@ -953,22 +953,18 @@
> >  		}
> >  	} else if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
> >  		struct acpi_resource_extended_irq *irqp;
> > -		int i;
> > +		int i, irq;
> >  
> >  		irqp = &res->data.extended_irq;
> >  
> > -		if (irqp->interrupt_count > 0) {
> > -			hdp->hd_nirqs = irqp->interrupt_count;
> > +		for (i = 0; i < irqp->interrupt_count; i++) {
> > +			irq = acpi_register_gsi(irqp->interrupts[i],
> > +				      irqp->triggering, irqp->polarity);
> > +			if (irq < 0)
> > +				return AE_ERROR;
> >  
> > -			for (i = 0; i < hdp->hd_nirqs; i++) {
> > -				int rc =
> > -				    acpi_register_gsi(irqp->interrupts[i],
> > -						      irqp->triggering,
> > -						      irqp->polarity);
> > -				if (rc < 0)
> > -					return AE_ERROR;
> > -				hdp->hd_irq[i] = rc;
> > -			}
> > +			hdp->hd_irq[hdp->hd_nirqs] = irq;
> > +			hdp->hd_nirqs++;
> >  		}
> >  	}
> >  
> 
> Acked-by: Bob Picco <bob.picco@hp.com>
> 
> 
