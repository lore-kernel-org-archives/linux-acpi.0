From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] (for review and testing first) Implement dynamic allocated array for pnp port/io resources
Date: Wed, 15 Aug 2007 17:16:45 +0300
Message-ID: <84144f020708150716j55a0b904v846825cab2ab88eb@mail.gmail.com>
References: <1187186605.8780.669.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760995AbXHOOQ7@vger.kernel.org>
In-Reply-To: <1187186605.8780.669.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jean Delvare <khali@linux-fr.org>, abelay@novell.com, Andi Kleen <ak@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Thomas,

On 8/15/07, Thomas Renninger <trenn@suse.de> wrote:
> +int pnp_port_alloc (struct pnp_resource_table *res)
> +{
> +       int ret = 0, i;
> +       if (res->allocated_ports == 0) {
> +               res->port_resource = kmalloc(sizeof(struct resource)
> +                                                 * PNP_ALLOC_PORTS,
> +                                                 GFP_KERNEL);

No need to use kmalloc() here. It's enough that you make sure
res->port_resource is NULL when res->allocated_ports is zero and
krealloc() will do the right thing.

On 8/15/07, Thomas Renninger <trenn@suse.de> wrote:
> +               if (!res->port_resource) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +       } else {
> +               res->port_resource = krealloc(res->port_resource,
> +                                           (sizeof(struct resource)
> +                                            * res->allocated_ports)
> +                                           +
> +                                           (sizeof(struct resource)
> +                                            * PNP_ALLOC_PORTS),
> +                                           GFP_KERNEL);

Assuming res->port_resource is non-NULL here and krealloc() fails,
you've leaked the originally allocated memory.

                                         Pekka
