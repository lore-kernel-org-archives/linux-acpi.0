From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
Date: Wed, 21 Oct 2015 17:51:52 -0500
Message-ID: <1445467912.701.90.camel@freescale.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
	 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
	 <1445406845.701.55.camel@freescale.com>
	 <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Hu Mingkai-B21284 <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2015-10-21 at 08:44 -0500, Rob Herring wrote:
> On Wed, Oct 21, 2015 at 12:54 AM, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org> 
> wrote:
> > On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
> > > Instead of trying to match and probe platform and AMBA devices right
> > > after each is registered, delay their probes until device_initcall_sync.
> > > 
> > > This means that devices will start probing once all built-in drivers
> > > have registered, and after all platform and AMBA devices from the DT
> > > have been registered already.
> > > 
> > > This allows us to prevent deferred probes by probing dependencies on
> > > demand.
> > > 
> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > > ---
> > > 
> > > Changes in v4:
> > > - Also defer probes of AMBA devices registered from the DT as they can
> > >   also request resources.
> > > 
> > >  drivers/of/platform.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform
> > device, and it must be probed before pcibios_init() which is a
> > subsys_initcall(), or else the PCI bus never gets scanned.
> 
> Thanks for the report. This is probably getting dropped, but it could
> be disabled for PPC.

I don't think that adding another arbitrary arch difference would be the 
right solution.

> Any plans to fix this and make PCI hosts hotplugable? For the scanning
> part, generally the host controller drivers are responsible for
> scanning their bus now.

Scanning from the host controller driver seems like a reasonable goal, though 

it'd take a bit of digging to extract whatever other things fsl_pci may 
depend on from the common PPC PCI code, in particular the various things that 

pcibios_resource_survey() does after all PCI buses have been scanned.

There's also check_swiotlb_enabled(), another subsys_initcall, which frees 
the swiotlb memory if ppc_swiotlb_enable hasn't been set.  The PCI host 
controller probe sets ppc_swiotlb_enable if it wasn't able to create an 
inbound mapping for all RAM.  Even if we were to change that to a later 
initcall, there's nothing later than late_initcall that we could use.

-Scott

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
