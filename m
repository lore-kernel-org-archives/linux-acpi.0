From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Force acpi_new_pts_ordering for ASUS A6VC laptop
Date: Tue, 25 Mar 2008 14:10:12 +0100
Message-ID: <200803251410.12816.rjw@sisk.pl>
References: <1206434857.23794.8.camel@sli10-desk.sh.intel.com> <9985.194.201.210.214.1206437077.squirrel@phoenix.slamd64.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60796 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbYCYNKR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 09:10:17 -0400
In-Reply-To: <9985.194.201.210.214.1206437077.squirrel@phoenix.slamd64.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tuesday, 25 of March 2008, Carlos Corbacho wrote:
> > +static int __init asus_suspend_order(const struct dmi_system_id *d)
> > +{
> > +	printk(KERN_WARNING PREFIX "%s detected, "
> > +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> > +	new_pts_ordering = true;
> > +	return 0;
> 
> Given all you're doing here is just changing the ordering,
> 'asus_suspend_order' doesn't strike me as the right name for this function
> since:
> 
> 1) This clearly isn't the case for all Asus boards.
> 
> 2) Perhaps something like 'new_suspend_order' would be a better name for
> this function (e.g. if others want to use DMI to do this for non-Asus
> boards).

Agreed.

Thanks,
Rafael
