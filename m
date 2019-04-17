From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
Date: Wed, 17 Apr 2019 13:44:54 +0300
Message-ID: <20190417104454.GQ1747@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <20190417093252.GO1747@kuha.fi.intel.com>
 <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 17, 2019 at 12:15:18PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-04-19 11:32, Heikki Krogerus wrote:
> > On Wed, Apr 17, 2019 at 11:19:28AM +0200, Hans de Goede wrote:
> 
> <snip>
> 
> > > That is not going to work since the (virtual) mux / orientation-switch
> > > devices are only registered once the driver binds to the piusb30532 i2c
> > > device, so when creating the nodes we only have the piusb30532 i2c device.
> > 
> > It's not a problem, that's why we have the software nodes. The nodes
> > can be created before the device entires. The node for pi3usb30532
> > will just be the parent node for the new nodes we add for the mux and
> > switch.
> > 
> > > I've been thinking some more about this and an easy fix is to have separate
> > > fwnode_match functions for typec_switch_match and typec_mux_match and have
> > > them check that the dev_name ends in "-mux" resp. "-switch" that requires
> > > only a very minimal change to "usb: typec: Registering real device entries for the muxes"
> > > and then everything should be fine.
> > 
> > I don't want to do anymore device name matching unless we have to, and
> > here we don't have to. We can name the nodes for those virtual mux and
> > switch, and then just do fwnode_find_named_child_node() in
> > pi3usb30532.c for both of them.
> 
> Thinking more about this, I have a feeling that this makes things needlessly
> complicated, checking the dev_name *ends* in "-mux" resp. "-switch" should be
> 100% reliable since we call:
> 
>         dev_set_name(&sw->dev, "%s-switch", dev_name(parent));
>         dev_set_name(&mux->dev, "%s-mux", dev_name(parent));
> 
> When registering the switch / mux, so I believe doing name (suffix) comparison
> here is fine and much simpler. Anyways this is just my 2 cents on this, I'm
> happy with either solution, your choice.

You do have a point. I'll take a look how the two options look like,
but maybe your way is better after all.

thanks,

-- 
heikki
