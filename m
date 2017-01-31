From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 06/15] device property: Add support for remote endpoints
Date: Tue, 31 Jan 2017 11:58:27 +0200
Message-ID: <20170131095827.GS7139@valkosipuli.retiisi.org.uk>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
 <1485532990-8431-7-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqL+avBhLD9jwk-yfCsxYWTBPZo5OrNB0JBLs8Ri6xtOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:51384 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750809AbdAaJ7P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Jan 2017 04:59:15 -0500
Content-Disposition: inline
In-Reply-To: <CAL_JsqL+avBhLD9jwk-yfCsxYWTBPZo5OrNB0JBLs8Ri6xtOgw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

Hi Rob,

Thank you for the review.

On Fri, Jan 27, 2017 at 03:45:04PM -0600, Rob Herring wrote:
> On Fri, Jan 27, 2017 at 10:03 AM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > This follows DT implementation of of_graph_* APIs but we call them
> > fwnode_graph_* instead. For DT nodes the existing of_graph_* implementation
> > will be used. For ACPI we use the new ACPI graph implementation instead.
> >
> > This commit includes code from Sakari Ailus.
> 
> Then it should have your S-o-b. Actually, either way it should have it.

I'll add that.

> 
> Whether or not copying DT graphs is a good idea or not, I'll let
> someone else chime in on that...
> 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/base/property.c  | 122 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |   9 ++++
> >  2 files changed, 131 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index c0011cf..cf602c3 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/property.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/phy.h>
> > @@ -1111,3 +1112,124 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
> >         return device_get_mac_addr(dev, "address", addr, alen);
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
> > +
> > +/**
> > + * device_graph_get_next_endpoint - Get next endpoint firmware node
> > + * @fwnode: Pointer to the parent firmware node
> > + * @prev: Previous endpoint node or %NULL to get the first
> > + *
> > + * Returns an endpoint firmware node pointer or %NULL if no more endpoints
> > + * are available.
> > + */
> > +struct fwnode_handle *
> > +fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
> > +                              struct fwnode_handle *prev)
> > +{
> > +       struct fwnode_handle *endpoint = NULL;
> > +
> > +       if (is_of_node(fwnode)) {
> > +               struct device_node *node;
> > +
> > +               node = of_graph_get_next_endpoint(to_of_node(fwnode),
> > +                                                 to_of_node(prev));
> > +
> > +               if (node)
> > +                       endpoint = &node->fwnode;
> > +       } else if (is_acpi_node(fwnode)) {
> > +               endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
> > +               if (IS_ERR(endpoint))
> > +                       endpoint = NULL;
> > +       }
> 
> This is an ugly pattern IMO. Why not define an ops struct and set it
> to OF or ACPI rather than check on every function call with
> is_{of,acpi}_node()?

That appears to be an established practice in the implementation of the
device / fwnode property API.

One option could be to choose the relevant ops struct based on fwnode type
in each function operating on the fwnode.

Alternatively it could be set at the time when the fwnode field is set. A
large number of drivers are manipulating their OF nodes, some do that for
fwnodes as well. Manually setting the ops struct pointer in those cases
might not be robust enough: sometimes one could simply forget. Also, adding
a pointer to struct fwnode_handle would increase the size of the struct
significantly without much gain.

The number of functions operating on fwnode_handle is rather limited. I
wonder if it'd be simply better to keep it as-is.

> 
> The of_graph_* functions need some better helpers too, so duplicating
> them 2 more times is not ideal. Basically, drivers are left to do too
> much of the walking of nodes themselves.

I have to admit my experience in using them is limited to V4L2, but I have
to say they've been working pretty well for what they're used for. Actually
the graph functionality was originally specific for V4L2, that could be the
reason why the current API is a good fit for V4L2. :-)

The current use ACPI use case is related to V4L2 as well (I'll post a new
version in the near future):

<URL:http://www.spinics.net/lists/linux-media/msg106160.html>

Are there any particular pain points that should be addressed?

I noticed Kunimori Morimoto's patchset adding of_graph_get_remote_endpoint()
which is just a new convenience function to the current API.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
