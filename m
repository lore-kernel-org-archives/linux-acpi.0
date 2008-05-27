From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PNPACPI: use _CRS IRQ descriptor length for _SRS
Date: Tue, 27 May 2008 10:47:53 -0600
Message-ID: <200805271047.54620.bjorn.helgaas@hp.com>
References: <200805231629.24421.bjorn.helgaas@hp.com> <48386498.6010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:31106 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717AbYE0Qrv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2008 12:47:51 -0400
In-Reply-To: <48386498.6010006@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Jaeger <thjaeger@gmail.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robert Moore <Robert.Moore@intel.com>, linux-acpi@vger.kernel.org

On Saturday 24 May 2008 12:55:20 pm Thomas Jaeger wrote:
> Bjorn Helgaas wrote:
> > [This fixes a long-standing parport PNPACPI bug, and it would
> > nice to have it in 2.6.26.]
> >   
> I agree, especially since the ground work has already been laid in 
> 1d5b285da1893b90507b081664ac27f1a8a3dc5b.
> > @@ -799,11 +802,14 @@ static void pnpacpi_encode_irq(struct pn
> >  		irq->sharable = ACPI_SHARED;
> >  	irq->interrupt_count = 1;
> >  	irq->interrupts[0] = p->start;
> > +	irq->descriptor_length = resource->data.irq.descriptor_length;
> >   
> I don't understand the point of this line.  Aren't 
> irq->descriptor_length and resource->data.irq.descriptor_length the same 
> thing?

You're right, I don't know what I was thinking there.  I'm sorry I
cast aspersions on your patch, which should be correct and sufficient.
I will still post an updated version, if you don't mind, to add a
little debug output.  And I think I'll still skip the "start dependent
function" piece, since we don't encode those.  (I don't see anything
in the spec that says you can't have a "start DPF" descriptor in a
_CRS or _SRS buffer, but I have no idea what it would mean.)

Later, I'm going to take another look at this template/encode business.
It looks like we currently allocate a new buffer sized to hold only the
descriptors we know about.  I think it would be better if we just
evaluated _CRS, kept the buffer it returned, then encoded our new
resources directly into the same buffer, ignoring things we don't know
about.  That way we wouldn't be quite so susceptible to issues like
this.

> Bjorn, while we're on the subject, could you have a look at 
> http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32 ? I've noticed that 
> you've already fixed the third point there; the other two points may 
> well be irrelevant or never occur in practice, but then they could be 
> the sort of thing that costs somebody hours of debugging time.

I agree, that should be cleaned up.  I'll take a look at that, too.

Thanks,
  Bjorn

