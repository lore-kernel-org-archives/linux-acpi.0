From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] PNP: don't check for conflicts with bridge windows
Date: Mon, 03 May 2010 16:50:08 -0600
Message-ID: <1272927008.28149.91.camel@dc7800.home>
References: <20100503164647.308.86063.stgit@bob.kio>
	 <20100503164721.308.11075.stgit@bob.kio>
	 <alpine.LFD.2.00.1005030950530.5478@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:38081 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab0ECWvN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 18:51:13 -0400
In-Reply-To: <alpine.LFD.2.00.1005030950530.5478@i5.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Pavel Kysilka <goldenfish@linuxsoft.cz>, Adam Belay <abelay@mit.edu>, Jaroslav Kysela <perex@perex.cz>

On Mon, 2010-05-03 at 09:53 -0700, Linus Torvalds wrote:
> 
> On Mon, 3 May 2010, Bjorn Helgaas wrote:
> >  			if (tres->flags & IORESOURCE_IO) {
> >  				if (cannot_compare(tres->flags))
> >  					continue;
> > +				if (tres->flags & IORESOURCE_WINDOW)
> > +					continue;
> >  				tport = &tres->start;
> >  				tend = &tres->end;
> >  				if (ranged_conflict(port, end, tport, tend))
> > @@ -271,6 +273,8 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res)
> >  			if (tres->flags & IORESOURCE_MEM) {
> >  				if (cannot_compare(tres->flags))
> >  					continue;
> > +				if (tres->flags & IORESOURCE_WINDOW)
> > +					continue;
> 
> Hmm. Looking at the patch, I am wondering if it wouldn't make _more_ sense 
> to instead say that you never mix IORESOURCE_WINDOW with 
> IORESOURCE_IO/MEM? That would make the above patch unnecessary, since it 
> would never trigger the test for IORESOURCE_IO/MEM in the first place.
> 
> A resource window is a window - it's not the resource itself. It's not IO 
> or MEM - that could/should be an attribute of what resource _tree_ the 
> window is linked into, not the resource itself.

That's an interesting idea, and it might make more sense.  I haven't
done anything useful with IORESOURCE_WINDOW yet, so I don't know how it
will work out.

My *plan* was to make pci_root.c a PNP driver, so it would use the
pre-parsed PNP resources to find the host bridge windows rather than
re-parsing the ACPI _CRS info by hand.  Those PNP resources are not in
the resource tree when the driver first sees them (which might be a
deficiency of our current PNP core), so I don't think there's currently
a way for the driver to distinguish IO from MEM unless it's in the
resource itself.

At this stage of the release, my preference would be to use the patch
above (with the intention of coming back later for some more work), or
to just revert fa35b4926 (PNPACPI window support) and maybe 9d7cca04
(generic window support).  If we revert those patches, I'll have to
figure out another way to clean up pci_root.c.

Bjorn


