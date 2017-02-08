From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 15/16] device property: Add fwnode_get_next_parent()
Date: Wed, 08 Feb 2017 13:19:57 +0100
Message-ID: <7605668.5ZxNsBFnEG@aspire.rjw.lan>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com> <9a481aec-92e6-ac01-b825-167bf73dfb11@redhat.com> <6293579.fEEljmGD4Z@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6293579.fEEljmGD4Z-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 08, 2017 12:50:25 PM Rafael J. Wysocki wrote:
> On Tuesday, February 07, 2017 11:57:55 AM Al Stone wrote:
> > On 02/02/2017 09:22 AM, Sakari Ailus wrote:
> > > In order to differentiate the functionality between dropping a reference
> > > to the node (or not) for the benefit of OF, introduce
> > > fwnode_get_next_parent().
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > ---
> > >  drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
> > >  include/linux/property.h |  1 +
> > >  2 files changed, 30 insertions(+)
> > > 
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index 28125a5..8e4398f 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -868,6 +868,35 @@ int device_add_properties(struct device *dev, struct property_entry *properties)
> > >  EXPORT_SYMBOL_GPL(device_add_properties);
> > >  
> > >  /**
> > > + * fwnode_get_next_parent - Iterate to the node's parent
> > > + * @fwnode: Firmware whose parent is retrieved
> > > + *
> > > + * This is like fwnode_get_parent() except that it drops the refcount
> > > + * on the passed node, making it suitable for iterating through a
> > > + * node's parents.
> > > + *
> > > + * Returns a node pointer with refcount incremented, use
> > > + * fwnode_handle_node() on it when done.
> > > + */
> > > +struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> > > +{
> > > +	struct fwnode_handle *parent = NULL;
> > > +
> > > +	if (is_of_node(fwnode)) {
> > > +		struct device_node *node;
> > > +
> > > +		node = of_get_next_parent(to_of_node(fwnode));
> > > +		if (node)
> > > +			parent = &node->fwnode;
> > > +	} else if (is_acpi_node(fwnode)) {
> > > +		parent = acpi_node_get_parent(fwnode);
> > > +	}
> > > +
> > > +	return parent;
> > > +}
> > > +EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> > 
> > I think I agree with Rob's prior comments about making an ops struct for DT
> > vs ACPI.  Out of the 16 patches, 2/16, 3/16, 5/16 (multiple times), and this
> > patch all end up using the same construct.  Maybe it needs to be a separate
> > refactoring effort, but if it's happening this often just in this patch set,
> > it seems like it's getting time to clean things up.
> 
> As long as there are two cases only (ACPI vs DT), an ops struct wouldn't
> really make things simpler and it would make the code more difficult to
> follow.
> 
> But we do have a third case (static or built-in properties) and it doesn't
> seem to be covered at all.

That said the ops struct could be introduced on top of this series just fine.
It even might be cleaner to do it this way, so I'm not asking for a redesign
here.

I'd like the built-in properties to be covered too, however.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
