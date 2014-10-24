From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: Use ACPI companion to match only the first
 physical device
Date: Fri, 24 Oct 2014 21:16:56 +0300
Message-ID: <20141024181656.GU1484@lahna.fi.intel.com>
References: <1414141950-228930-1-git-send-email-mika.westerberg@linux.intel.com>
 <1442328.iYt6Cj5IOV@vostro.rjw.lan>
 <20141024141051.GT1484@lahna.fi.intel.com>
 <6871118.LYO2moLKYB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6871118.LYO2moLKYB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 24, 2014 at 04:57:17PM +0200, Rafael J. Wysocki wrote:
> > I didn't consider that it is even possible but yes, in that case we
> > should not return true here.
> 
> Well, that why did you check if the list is not empty at all? :-)
> 
> It is possible if someone sets the ACPI companion before calling acpi_bind_one()
> (some pieces of code do that).  It may not be relevant here, but it won't hurt
> to be on the safe side.

Agreed.

> > > 
> > > > +	mutex_lock(&adev->physical_node_lock);
> > > > +	if (!list_empty(&adev->physical_node_list)) {
> > > > +		const struct acpi_device_physical_node *node;
> > > > +
> > > > +		node = list_first_entry(&adev->physical_node_list,
> > > > +					struct acpi_device_physical_node, node);
> > > > +		if (node->dev != dev)
> > > > +			ret = false;
> > > 
> > > And that may be simply
> > > 
> > > 		ret = node->dev == dev;
> > 
> > OK.
> 
> So what about the following modified version?

Looks good to me, thanks :-)
