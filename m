From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RESEND PATCH 2/2] device property: fix for a case of
 use-after-free
Date: Thu, 10 Mar 2016 10:44:45 +0200
Message-ID: <20160310084445.GA29882@kuha.fi.intel.com>
References: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1457444677-25645-3-git-send-email-heikki.krogerus@linux.intel.com>
 <38356299.uTpVNISVVC@vostro.rjw.lan>
 <20160309144112.GA31334@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64734 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522AbcCJIot (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Mar 2016 03:44:49 -0500
Content-Disposition: inline
In-Reply-To: <20160309144112.GA31334@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

On Wed, Mar 09, 2016 at 04:41:12PM +0200, Heikki Krogerus wrote:
> Hi Rafael,
> 
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index a163f2c..a9df21a9 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -820,11 +820,13 @@ void device_remove_property_set(struct device *dev)
> > >  	 * the pset. If there is no real firmware node (ACPI/DT) primary
> > >  	 * will hold the pset.
> > >  	 */
> > > -	if (!is_pset_node(fwnode))
> > > +	if (is_pset_node(fwnode))
> > > +		dev->fwnode = NULL;
> > 
> > I don't really like the way you clear dev->fwnode directly here.
> > set_primary_fwnode(dev, NULL) would be more appropriate IMO.
> > 
> > Also set_secondary_fwnode(dev, NULL) need not be done in that case, because it
> > doesn't change anything.
> > 
> > Moreover, if the primary node is not pset, the secondary one should only be
> > cleared if it is pset.
> > 
> > So that would mean
> > 
> > 	if (is_pset_node(fwnode)) {
> > 		set_primary_fwnode(dev, NULL);

So this does create an other problem. We may now end up having ERR_PTR
in the primary fwnode which of course is not considered in the
property handling code, and would need to be fixed similarly as I
fixed the secondary fwnode checking in 1/2 of this series.

But instead of doing that, the whole logic of handing the
primary/secondary fwnodes is probable a little bit broken and should
really be replaced with something better. We can fix these issues one
by one with the code we have now, but it really looks like one fix
will always result into two new problems. Andy promised to look at it.

In the meantime, would it make sense to go ahead with my proposal to
fix the original problem? As a temporary hack?


Thanks,

-- 
heikki
