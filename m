From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 21/54] PNP: add debug when assigning PNP resources
Date: Mon, 28 Apr 2008 09:25:56 -0600
Message-ID: <200804280925.56771.bjorn.helgaas@hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183928.375529075@ldl.fc.hp.com> <48139DFC.500@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935245AbYD1P06@vger.kernel.org>
In-Reply-To: <48139DFC.500@keyaccess.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 26 April 2008 03:26:20 pm Rene Herman wrote:
> On 25-04-08 20:38, Bjorn Helgaas wrote:
> > +#else
> > +void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
> > +{
> > +}
> > +#endif
> 
> Not too important, but #ifdef could be inside body.

Much nicer, thanks.

I'll add your updates and acks and repost this series today.

> > +		dev_dbg(&dev->dev, "  io %d already set to 0x%llx-0x%llx "
> > +			"flags 0x%x\n", idx, (unsigned long long) *start,
> > +			(unsigned long long) *end, (int) *flags);
> 
> I wanted to ask/comment why you're casting the flags to int though. It's an 
> unsigned long, both in the resource and by type here. Ie, 0x%lx and no 
> casting? (I btw also like %#lx better then the explicit 0x, but that doesn't 
> really matter).

Two more good ideas.  The cast was just me not paying attention, and
the "0x%x" habit is deeply ingrained.  I'll change both.

Bjorn
