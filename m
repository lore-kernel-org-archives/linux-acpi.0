From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RESEND PATCH 2/2] device property: fix for a case of
 use-after-free
Date: Wed, 9 Mar 2016 16:41:12 +0200
Message-ID: <20160309144112.GA31334@kuha.fi.intel.com>
References: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1457444677-25645-3-git-send-email-heikki.krogerus@linux.intel.com>
 <38356299.uTpVNISVVC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16288 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766AbcCIOlS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Mar 2016 09:41:18 -0500
Content-Disposition: inline
In-Reply-To: <38356299.uTpVNISVVC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

Hi Rafael,

> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index a163f2c..a9df21a9 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -820,11 +820,13 @@ void device_remove_property_set(struct device *dev)
> >  	 * the pset. If there is no real firmware node (ACPI/DT) primary
> >  	 * will hold the pset.
> >  	 */
> > -	if (!is_pset_node(fwnode))
> > +	if (is_pset_node(fwnode))
> > +		dev->fwnode = NULL;
> 
> I don't really like the way you clear dev->fwnode directly here.
> set_primary_fwnode(dev, NULL) would be more appropriate IMO.
> 
> Also set_secondary_fwnode(dev, NULL) need not be done in that case, because it
> doesn't change anything.
> 
> Moreover, if the primary node is not pset, the secondary one should only be
> cleared if it is pset.
> 
> So that would mean
> 
> 	if (is_pset_node(fwnode)) {
> 		set_primary_fwnode(dev, NULL);
> 		pset_free_set(to_pset_node(fwnode));
> 	} else {
> 		fwnode = fwnode->secondary;
> 		if (!IS_ERR(fwnode) && is_pset_node(fwnode)) {
> 			set_secondary_fwnode(dev, NULL);
> 			pset_free_set(to_pset_node(fwnode));
> 		}
> 	}

I have been testing that today, but I'll continue tomorrow. No
problems so far.


Thanks,

-- 
heikki
