From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Allocate pnp resources dynamically via krealloc
Date: Sun, 20 Jan 2008 12:04:26 +0100
Message-ID: <1200827066.3713.4.camel@queen>
References: <1200772810.3708.42.camel@queen>
	 <84144f020801191623i2ad344a8t1c40969578793d13@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753449AbYATLEl@vger.kernel.org>
In-Reply-To: <84144f020801191623i2ad344a8t1c40969578793d13@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


On Sun, 2008-01-20 at 02:23 +0200, Pekka Enberg wrote:
> Hi Thomas,
> 
> On Jan 19, 2008 10:00 PM, Thomas Renninger <trenn@suse.de> wrote:
> > +static int pnp_alloc_port(struct pnp_resource_table *res)
> > +{
> 
> [snip]
> 
> > +       res->port_resource = krealloc(res->port_resource,
> > +             (sizeof(struct resource) * res->allocated_ports)
> > +             + (sizeof(struct resource) * PNP_ALLOC_PORT), GFP_KERNEL);
> > +
> > +       if (!res->port_resource)
> > +               return -ENOMEM;
> 
> When krealloc() returns NULL, there wasn't enough memory to fit the
> new size but the original memory region remains unchanged. Therefore
> you must not unconditionally overwrite the res->port_resource with the
> return value of krealloc(); otherwise you might leak memory.
> 
Thanks.
While looking at this I found something else..., I think I sent an old
version.

Please hold off, I will double check and resend soon.

   Thomas

