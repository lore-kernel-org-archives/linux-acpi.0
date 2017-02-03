From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 06/15] device property: Add support for remote endpoints
Date: Fri, 3 Feb 2017 11:59:22 +0200
Message-ID: <20170203095922.GA12291@valkosipuli.retiisi.org.uk>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
 <1485532990-8431-7-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqL+avBhLD9jwk-yfCsxYWTBPZo5OrNB0JBLs8Ri6xtOgw@mail.gmail.com>
 <20170131095827.GS7139@valkosipuli.retiisi.org.uk>
 <CAL_JsqJar8AtP__Vyfdra3_Q-6jkcJ_MH3DL55P4t4GzaNOLJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:42248 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753098AbdBCJ7h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 04:59:37 -0500
Content-Disposition: inline
In-Reply-To: <CAL_JsqJar8AtP__Vyfdra3_Q-6jkcJ_MH3DL55P4t4GzaNOLJA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, laurent.pinchart@ideasonboard.com, g.liakhovetski@gmx.de

Hi Rob,

On Thu, Feb 02, 2017 at 11:19:08AM -0600, Rob Herring wrote:
> On Tue, Jan 31, 2017 at 3:58 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > Hi Rob,
> >
> > Thank you for the review.
> >
> > On Fri, Jan 27, 2017 at 03:45:04PM -0600, Rob Herring wrote:
> >> On Fri, Jan 27, 2017 at 10:03 AM, Sakari Ailus
> >> <sakari.ailus@linux.intel.com> wrote:
> >> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> >
> >> > This follows DT implementation of of_graph_* APIs but we call them
> >> > fwnode_graph_* instead. For DT nodes the existing of_graph_* implementation
> >> > will be used. For ACPI we use the new ACPI graph implementation instead.
> >> >
> >> > This commit includes code from Sakari Ailus.
> >>
> >> Then it should have your S-o-b. Actually, either way it should have it.
> >
> > I'll add that.
> >
> >>
> >> Whether or not copying DT graphs is a good idea or not, I'll let
> >> someone else chime in on that...
> >>
> >> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> > ---
> >> >  drivers/base/property.c  | 122 +++++++++++++++++++++++++++++++++++++++++++++++
> >> >  include/linux/property.h |   9 ++++
> >> >  2 files changed, 131 insertions(+)
> >> >
> >> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> >> > index c0011cf..cf602c3 100644
> >> > --- a/drivers/base/property.c
> >> > +++ b/drivers/base/property.c
> >> > @@ -15,6 +15,7 @@
> >> >  #include <linux/kernel.h>
> >> >  #include <linux/of.h>
> >> >  #include <linux/of_address.h>
> >> > +#include <linux/of_graph.h>
> >> >  #include <linux/property.h>
> >> >  #include <linux/etherdevice.h>
> >> >  #include <linux/phy.h>
> >> > @@ -1111,3 +1112,124 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
> >> >         return device_get_mac_addr(dev, "address", addr, alen);
> >> >  }
> >> >  EXPORT_SYMBOL(device_get_mac_address);
> >> > +
> >> > +/**
> >> > + * device_graph_get_next_endpoint - Get next endpoint firmware node
> >> > + * @fwnode: Pointer to the parent firmware node
> >> > + * @prev: Previous endpoint node or %NULL to get the first
> >> > + *
> >> > + * Returns an endpoint firmware node pointer or %NULL if no more endpoints
> >> > + * are available.
> >> > + */
> >> > +struct fwnode_handle *
> >> > +fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
> >> > +                              struct fwnode_handle *prev)
> >> > +{
> >> > +       struct fwnode_handle *endpoint = NULL;
> >> > +
> >> > +       if (is_of_node(fwnode)) {
> >> > +               struct device_node *node;
> >> > +
> >> > +               node = of_graph_get_next_endpoint(to_of_node(fwnode),
> >> > +                                                 to_of_node(prev));
> >> > +
> >> > +               if (node)
> >> > +                       endpoint = &node->fwnode;
> >> > +       } else if (is_acpi_node(fwnode)) {
> >> > +               endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
> >> > +               if (IS_ERR(endpoint))
> >> > +                       endpoint = NULL;
> >> > +       }
> >>
> >> This is an ugly pattern IMO. Why not define an ops struct and set it
> >> to OF or ACPI rather than check on every function call with
> >> is_{of,acpi}_node()?
> >
> > That appears to be an established practice in the implementation of the
> > device / fwnode property API.
> 
> I know. That doesn't mean it is good practice or not in need of
> refactoring as fwnode API expands.
> 
> > One option could be to choose the relevant ops struct based on fwnode type
> > in each function operating on the fwnode.
> 
> That helps absolutely nothing.

You could add a bunch of macros to help with that, and wrap the actual
functions so that you'd find the ops using the macro. It'd be less pretty
than having an ops pointer in the struct, I agree.

> 
> > Alternatively it could be set at the time when the fwnode field is set. A
> > large number of drivers are manipulating their OF nodes, some do that for
> > fwnodes as well.
> 
> What do you mean by manipulating? A fwnode should be statically
> pointing to a DT node and the DT node is static.

I should have phrased that differently. The OF node (or fwnode_handle)
pointers are stored locally in driver specific structs. Now that I look at
that more closely, the only problems appears to be that most forget
of_node_get() but that's unrelated to this.

> 
> > Manually setting the ops struct pointer in those cases
> > might not be robust enough: sometimes one could simply forget. Also, adding
> > a pointer to struct fwnode_handle would increase the size of the struct
> > significantly without much gain.
> 
> 4 or 8 bytes, really?

Per node. Going forward, 8 is getting more and more common.

> 
> >
> > The number of functions operating on fwnode_handle is rather limited. I
> > wonder if it'd be simply better to keep it as-is.
> 
> It was, but you're adding a lot.

With the patchset, there are 14 occurrences of is_of_node() and 12
occurrences of is_acpi_node(). Before the numbers were 6 and 4,
respectively.

I think it'd be good to have a third opinion on that.

I presume you'd prefer these changes done before this set?

> 
> >> The of_graph_* functions need some better helpers too, so duplicating
> >> them 2 more times is not ideal. Basically, drivers are left to do too
> >> much of the walking of nodes themselves.
> >
> > I have to admit my experience in using them is limited to V4L2, but I have
> > to say they've been working pretty well for what they're used for. Actually
> > the graph functionality was originally specific for V4L2, that could be the
> > reason why the current API is a good fit for V4L2. :-)
> 
> I'd guess the problem is V4L2 has common graph code and DRM does not.

The graph code is generic, what V4L2 has concerning OF is common parsing of
the properties. That's the current state at least.

> I'd also guess we can find common patterns in both that could be
> abstracted. And as you noticed, ALSA folks are working on using OF
> graph.

Please see drivers/media/platform/omap3isp/isp.c, and isp_of_parse_nodes()
there. This is where the omap3isp driver parses information originating from
DT. That's a pretty good example, most other V4L2 drivers that work with OF
nodes do something similar.

isp_of_parse_nodes() function could certainly be improved, but the
improvement would be related to the interface of V4L2 async framework.
That's not really related to DT or graphs.

The V4L2 async framework is already aware of DT but it just makes it
possible to match devices using OF nodes. It could well facilitate the
process a lot more than it does now.

I wonder if something similar could be done for DRM.

Cc Guennadi and Laurent.

> 
> > The current use ACPI use case is related to V4L2 as well (I'll post a new
> > version in the near future):
> >
> > <URL:http://www.spinics.net/lists/linux-media/msg106160.html>
> >
> > Are there any particular pain points that should be addressed?
> 
> I think generally we want drivers to avoid walking the port and
> endpoint nodes themselves. Rather, have functions like "For my device
> node, give me the device node connected via port N, endpoint M."

I'd like to question whether that really helps: you need to iterate over all
the ports and all the endpoints in them, instead of being simply given all
the endpoints that have connected devices, one by one. At least when it
comes to V4L2, I prefer the latter. As noted, I believe the enumerating
work could (and should) be moved to the V4L2 async framework.

It does show the firmware concepts to the driver but is there any harm from
doing so?

> Essentially, that is of_graph_get_endpoint_by_regs and
> of_graph_get_remote_port_parent. The only time drivers really should
> have port or endpoint node ptrs is to read properties, so maybe we add
> property retrieval functions that take the device node and port and
> endpoint numbers.
> 
> Really it may be an exercise in just removing some of the functions
> which are too low level.
> 
> Take of_cal_create_instance() as an example. Here's what it does:
> 
> - Find port with reg == inst
> - Get port's first endpoint
> - Get remote port parent and save sensor_node
> - Get the remote endpoint node
> - Parse the remote endpoint properties (v4l2_of_parse_endpoint)
> 
> The first 3 steps are 40 lines of code and could be just 1 function
> call returning node ptr for sensor_node.
> 
> v4l2_of_parse_link also open codes stuff that should be in the core.
> 
> > I noticed Kunimori Morimoto's patchset adding of_graph_get_remote_endpoint()
> > which is just a new convenience function to the current API.
> 
> Right, I had similar comments there.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
