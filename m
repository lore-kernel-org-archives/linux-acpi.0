From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
Date: Thu, 14 Dec 2017 12:28:50 +0200
Message-ID: <20171214102849.fqselexjzfh63ytd@paasikivi.fi.intel.com>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
 <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
 <c2b38889-888a-3518-bf59-c2377f64a8ce@codeaurora.org>
 <20171207220642.qqiwf4vvk2gf42uf@valkosipuli.retiisi.org.uk>
 <CAJZ5v0inHMCLGyPaAeuJNo2VH7f3Th0KdpT2UkPBCsvrSDi0gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inHMCLGyPaAeuJNo2VH7f3Th0KdpT2UkPBCsvrSDi0gQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kieran Bingham <kieran.bingham+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 07, 2017 at 11:19:51PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 7, 2017 at 11:06 PM, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
> > On Thu, Dec 07, 2017 at 03:17:52PM -0500, Sinan Kaya wrote:
> >> On 12/7/2017 7:40 AM, Sakari Ailus wrote:
> >> > On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
> >> >> @@ -101,6 +103,8 @@ struct fwnode_operations {
> >> >>    (*graph_get_port_parent)(struct fwnode_handle *fwnode);
> >> >>    int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
> >> >>                                struct fwnode_endpoint *endpoint);
> >> >> +  void *(*get_match_data)(const struct fwnode_handle *fwnode,
> >> >> +                          struct device *dev);
> >> >
> >> > You can make dev const, too.
> >> >
> >>
> >> done, I couldn't change device_get_match_data() parameter const due to
> >> dev_fwnode() function.
> >>
> >>                  from /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:13:
> >>
> >> /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:1341:39: warning: passing argument 1 of 'dev_fwnode' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >>   return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
> >
> > Right. Makes sense.
> >
> > I guess it's not perhaps worth it introducing dev_fwnode_const just for
> > this. devices are seldom if ever const anyway.
> 
> They cannot be const.  Had they been const, it wouldn't have been
> possible to register them even. :-)

In general no, but this function does not change the device in any way,
therefore it could be const in principle.

-- 
Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
