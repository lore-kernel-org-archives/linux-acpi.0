From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/9] drivers/of: Introduce of_node_alloc
Date: Tue, 29 Sep 2015 09:01:28 +0100
Message-ID: <20150929090128.4647f27a@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
	<1443458582-7497-2-git-send-email-marc.zyngier@arm.com>
	<5609C43E.1040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5609C43E.1040106-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tomasz.nowicki-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, Graeme Gregory <graeme-/SyDAi3Rz4f10XsdtD+oqA@public.gmane.org>, Jake Oshins <jakeo-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 28 Sep 2015 15:50:38 -0700
Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 9/28/2015 9:42 AM, Marc Zyngier wrote:
> > We want to be able to generate "fake" device nodes that can be
> > used as an identifier for irq domains. For that, we reuse the
> > dynamic DT layer in order to generate DT nodes in a detached state
> > (so that it doesn't interfere with the rest of the tree).
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  drivers/of/dynamic.c | 22 ++++++++++++++++++++++
> >  include/linux/of.h   |  5 +++++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index 53826b8..709d363 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -445,6 +445,28 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
> >  	return NULL;
> >  }
> >  
> > +/**
> > + * of_node_alloc() - Allocate an empty device node dynamically.
> > + * @fmt: Format string (plus vargs) for new full name of the device node
> > + *
> > + * Create an device tree node, either by by allocating an empty one
> 
>       Create a device tree node by allocating an empty one

Ah! Thanks!

	M.
-- 
Jazz is not dead. It just smells funny.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
