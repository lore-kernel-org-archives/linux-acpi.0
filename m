From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Allocate pnp resources dynamically via krealloc
Date: Sun, 20 Jan 2008 02:23:13 +0200
Message-ID: <84144f020801191623i2ad344a8t1c40969578793d13@mail.gmail.com>
References: <1200772810.3708.42.camel@queen>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759052AbYATAX0@vger.kernel.org>
In-Reply-To: <1200772810.3708.42.camel@queen>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Thomas,

On Jan 19, 2008 10:00 PM, Thomas Renninger <trenn@suse.de> wrote:
> +static int pnp_alloc_port(struct pnp_resource_table *res)
> +{

[snip]

> +       res->port_resource = krealloc(res->port_resource,
> +             (sizeof(struct resource) * res->allocated_ports)
> +             + (sizeof(struct resource) * PNP_ALLOC_PORT), GFP_KERNEL);
> +
> +       if (!res->port_resource)
> +               return -ENOMEM;

When krealloc() returns NULL, there wasn't enough memory to fit the
new size but the original memory region remains unchanged. Therefore
you must not unconditionally overwrite the res->port_resource with the
return value of krealloc(); otherwise you might leak memory.

                Pekka
