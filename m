From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/15] device property: Add support for remote endpoints
Date: Thu, 2 Feb 2017 11:19:08 -0600
Message-ID: <CAL_JsqJar8AtP__Vyfdra3_Q-6jkcJ_MH3DL55P4t4GzaNOLJA@mail.gmail.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
 <1485532990-8431-7-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqL+avBhLD9jwk-yfCsxYWTBPZo5OrNB0JBLs8Ri6xtOgw@mail.gmail.com> <20170131095827.GS7139@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170131095827.GS7139-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 31, 2017 at 3:58 AM, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
> Hi Rob,
>
> Thank you for the review.
>
> On Fri, Jan 27, 2017 at 03:45:04PM -0600, Rob Herring wrote:
>> On Fri, Jan 27, 2017 at 10:03 AM, Sakari Ailus
>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> > From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> >
>> > This follows DT implementation of of_graph_* APIs but we call them
>> > fwnode_graph_* instead. For DT nodes the existing of_graph_* implementation
>> > will be used. For ACPI we use the new ACPI graph implementation instead.
>> >
>> > This commit includes code from Sakari Ailus.
>>
>> Then it should have your S-o-b. Actually, either way it should have it.
>
> I'll add that.
>
>>
>> Whether or not copying DT graphs is a good idea or not, I'll let
>> someone else chime in on that...
>>
>> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> > ---
>> >  drivers/base/property.c  | 122 +++++++++++++++++++++++++++++++++++++++++++++++
>> >  include/linux/property.h |   9 ++++
>> >  2 files changed, 131 insertions(+)
>> >
>> > diff --git a/drivers/base/property.c b/drivers/base/property.c
>> > index c0011cf..cf602c3 100644
>> > --- a/drivers/base/property.c
>> > +++ b/drivers/base/property.c
>> > @@ -15,6 +15,7 @@
>> >  #include <linux/kernel.h>
>> >  #include <linux/of.h>
>> >  #include <linux/of_address.h>
>> > +#include <linux/of_graph.h>
>> >  #include <linux/property.h>
>> >  #include <linux/etherdevice.h>
>> >  #include <linux/phy.h>
>> > @@ -1111,3 +1112,124 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
>> >         return device_get_mac_addr(dev, "address", addr, alen);
>> >  }
>> >  EXPORT_SYMBOL(device_get_mac_address);
>> > +
>> > +/**
>> > + * device_graph_get_next_endpoint - Get next endpoint firmware node
>> > + * @fwnode: Pointer to the parent firmware node
>> > + * @prev: Previous endpoint node or %NULL to get the first
>> > + *
>> > + * Returns an endpoint firmware node pointer or %NULL if no more endpoints
>> > + * are available.
>> > + */
>> > +struct fwnode_handle *
>> > +fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
>> > +                              struct fwnode_handle *prev)
>> > +{
>> > +       struct fwnode_handle *endpoint = NULL;
>> > +
>> > +       if (is_of_node(fwnode)) {
>> > +               struct device_node *node;
>> > +
>> > +               node = of_graph_get_next_endpoint(to_of_node(fwnode),
>> > +                                                 to_of_node(prev));
>> > +
>> > +               if (node)
>> > +                       endpoint = &node->fwnode;
>> > +       } else if (is_acpi_node(fwnode)) {
>> > +               endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
>> > +               if (IS_ERR(endpoint))
>> > +                       endpoint = NULL;
>> > +       }
>>
>> This is an ugly pattern IMO. Why not define an ops struct and set it
>> to OF or ACPI rather than check on every function call with
>> is_{of,acpi}_node()?
>
> That appears to be an established practice in the implementation of the
> device / fwnode property API.

I know. That doesn't mean it is good practice or not in need of
refactoring as fwnode API expands.

> One option could be to choose the relevant ops struct based on fwnode type
> in each function operating on the fwnode.

That helps absolutely nothing.

> Alternatively it could be set at the time when the fwnode field is set. A
> large number of drivers are manipulating their OF nodes, some do that for
> fwnodes as well.

What do you mean by manipulating? A fwnode should be statically
pointing to a DT node and the DT node is static.

> Manually setting the ops struct pointer in those cases
> might not be robust enough: sometimes one could simply forget. Also, adding
> a pointer to struct fwnode_handle would increase the size of the struct
> significantly without much gain.

4 or 8 bytes, really?

>
> The number of functions operating on fwnode_handle is rather limited. I
> wonder if it'd be simply better to keep it as-is.

It was, but you're adding a lot.

>> The of_graph_* functions need some better helpers too, so duplicating
>> them 2 more times is not ideal. Basically, drivers are left to do too
>> much of the walking of nodes themselves.
>
> I have to admit my experience in using them is limited to V4L2, but I have
> to say they've been working pretty well for what they're used for. Actually
> the graph functionality was originally specific for V4L2, that could be the
> reason why the current API is a good fit for V4L2. :-)

I'd guess the problem is V4L2 has common graph code and DRM does not.
I'd also guess we can find common patterns in both that could be
abstracted. And as you noticed, ALSA folks are working on using OF
graph.

> The current use ACPI use case is related to V4L2 as well (I'll post a new
> version in the near future):
>
> <URL:http://www.spinics.net/lists/linux-media/msg106160.html>
>
> Are there any particular pain points that should be addressed?

I think generally we want drivers to avoid walking the port and
endpoint nodes themselves. Rather, have functions like "For my device
node, give me the device node connected via port N, endpoint M."
Essentially, that is of_graph_get_endpoint_by_regs and
of_graph_get_remote_port_parent. The only time drivers really should
have port or endpoint node ptrs is to read properties, so maybe we add
property retrieval functions that take the device node and port and
endpoint numbers.

Really it may be an exercise in just removing some of the functions
which are too low level.

Take of_cal_create_instance() as an example. Here's what it does:

- Find port with reg == inst
- Get port's first endpoint
- Get remote port parent and save sensor_node
- Get the remote endpoint node
- Parse the remote endpoint properties (v4l2_of_parse_endpoint)

The first 3 steps are 40 lines of code and could be just 1 function
call returning node ptr for sensor_node.

v4l2_of_parse_link also open codes stuff that should be in the core.

> I noticed Kunimori Morimoto's patchset adding of_graph_get_remote_endpoint()
> which is just a new convenience function to the current API.

Right, I had similar comments there.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
