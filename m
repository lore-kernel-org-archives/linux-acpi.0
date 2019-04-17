From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
Date: Wed, 17 Apr 2019 09:39:18 +0300
Message-ID: <20190417063918.GI1747@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 16, 2019 at 11:35:36PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 12-04-19 15:41, Heikki Krogerus wrote:
> > Now that the software nodes support references, and the
> > device connection API support parsing fwnode references,
> > replacing the old connection descriptions with software node
> > references. Relying on device names when matching the
> > connection would not have been possible to link the USB
> > Type-C connector and the DisplayPort connector together, but
> > with real references it's not problem.
> > 
> > The DisplayPort ACPI node is dag up, and the drivers own
> > software node for the DisplayPort is set as the secondary
> > node for it. The USB Type-C connector refers the software
> > node, but it is now tied to the ACPI node, and therefore any
> > device entry (struct drm_connector in practice) that the
> > node combo is assigned to.
> > 
> > The USB role switch device does not have ACPI node, so we
> > have to wait for the device to appear. Then we can simply
> > assign our software node for the to the device.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> So as promised I've been testing this series and this commit
> breaks type-c functionality on devices using this driver.
> 
> The problem is that typec_switch_get() and  typec_mux_get()
> after this both return the same pointer, which is pointing
> to the switch, so typec_mux_get() is returning the wrong
> pointer.
> 
> This is not surprising since the references for both are
> both pointing to the fwnode attached to the piusb30532 devices:
> 
> 	args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];
> 
> So the class_find_device here:
> 
> static void *typec_switch_match(struct device_connection *con, int ep,
>                                 void *data)
> {
>         struct device *dev;
> 
>         if (con->fwnode) {
>                 if (con->id && !fwnode_property_present(con->fwnode, con->id))
>                         return NULL;
> 
>                 dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
>                                         fwnode_match);
>         } else {
>                 dev = class_find_device(&typec_mux_class, NULL,
>                                         con->endpoint[ep], name_match);
>         }
> 
>         return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> }
> 
> Simply returns the first typec_mux_class device registered.
> 
> I see 2 possible solutions to this problem:
> 
> 1) Use separate typec_mux_class and typec_orientation_switch_class-es
> 
> 2) Merge struct typec_switch and struct typec_mux into a single struct,
> so that all typec_mux_class devices have the same memory layout, add
> a subclass enum to this new merged struct and use that to identify
> which of the typec_mux_class devices with the same fwnode pointer we
> want.
> 
> Any other suggestions?

I think the correct fix is that we supply separate nodes for both
device entries.


thanks,

-- 
heikki
