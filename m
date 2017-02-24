From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 00/20] Move firmware specific code to firmware specific
 locations
Date: Fri, 24 Feb 2017 10:25:02 +0200
Message-ID: <20170224082501.GV16975@valkosipuli.retiisi.org.uk>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
 <2915459.fDeP2CYj8T@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2915459.fDeP2CYj8T-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 23, 2017 at 11:37:12PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 23, 2017 07:00:56 PM Sakari Ailus wrote:
> > Hi,
> > 
> > This set moves firmware specific implementations of the device / fwnode
> > property API to locations that are specific to firmware implementation,
> > still leaving property set (which isn't really firmware) implementation in
> > drivers/base/property.c.
> > 
> > The set begins with a few bugfixes (patches 1--3), followed by adding
> > fwnode_operations struct and then gradually moving firmware dependent code
> > to drivers/acpi/property.c and drivers/of/base.c.
> > 
> > The set depends on the ACPI graph support here:
> > 
> > <URL:http://marc.info/?l=linux-acpi&m=148786716920942&w=2>
> > 
> > Comments are welcome.
> 
> Patches [1-3/20] from this series seem to be fixes that don't depend on the
> rest of it and don't depend on the other series you posted.
> 
> If that is the case, it would be good to get them in during this cycle instead
> of sitting on them for several weeks.
> 
> So is that the case?

Correct. There are no dependencies from patches 1--3 to the rest (first set
or this one).

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
