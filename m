From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Tue, 26 Mar 2019 16:50:20 +0100
Message-ID: <20190326155020.awlvbnm5qqn4wu6t@pathway.suse.cz>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
 <20190326140633.GE7049@kuha.fi.intel.com>
 <20190326141243.g2x44v65npw4yhw5@paasikivi.fi.intel.com>
 <20190326143021.GE9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326143021.GE9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue 2019-03-26 16:30:21, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 04:12:43PM +0200, Sakari Ailus wrote:
> > On Tue, Mar 26, 2019 at 04:06:33PM +0200, Heikki Krogerus wrote:
> > > On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> 
> > > > > > Do we support swnode here?
> > > > > 
> > > > > Good question. The swnodes have no hierarchy at the moment (they're only
> > > > > created for a struct device as a parent) and they do not have human-readable
> > > > > names. So I'd say it's not relevant right now. Should these two change,
> > > > > support for swnode could (and should) be added later on.
> > > > 
> > > > Heikki, what do you think about this?
> > > 
> > > Well, the swnodes do have hierarchy. That was kind of the whole point
> > > of introducing them. They now can also be named using "name" property.
> > > See commit 344798206f171c5abea7ab1f9762fa526d7f539d.
> > 
> > Right; I saw the function after initially replying to Andy but I missed
> > where the node name came from. :-) Now I know...
> > 
> > I can add support for swnode, too, if you like.
> 
> Definitely!

It might really make sense to obsolete %pOF and handle all three
(OF, ACPI, Software) nodes using the same %pfw modifiers.

If I get it correctly, we could distinguish them by
fwnode->ops, see is_of_node(), is_acpi_static_node(),
is_software_node().

Best Regards,
Petr
