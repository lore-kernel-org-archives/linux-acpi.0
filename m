From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: Use ACPI companion to match only the first
 physical device
Date: Fri, 24 Oct 2014 17:10:51 +0300
Message-ID: <20141024141051.GT1484@lahna.fi.intel.com>
References: <1414141950-228930-1-git-send-email-mika.westerberg@linux.intel.com>
 <2356721.6lgfg38MC8@vostro.rjw.lan>
 <1442328.iYt6Cj5IOV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57502 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaJXOLQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2014 10:11:16 -0400
Content-Disposition: inline
In-Reply-To: <1442328.iYt6Cj5IOV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 24, 2014 at 04:20:41PM +0200, Rafael J. Wysocki wrote:
> > +static bool acpi_companion_match(const struct device *dev)
> > +{
> > +	struct acpi_device *adev;
> > +	bool ret;
> > +
> > +	adev = ACPI_COMPANION(dev);
> > +	if (!adev)
> > +		return false;
> > +
> > +	if (list_empty(&adev->pnp.ids))
> > +		return false;
> > +
> > +	ret = true;
> 
> On a second thought, should we return true if the list of physical devices is
> empty?  That surely means ACPI_COMPANION(dev) lied to us?

I didn't consider that it is even possible but yes, in that case we
should not return true here.

> 
> > +	mutex_lock(&adev->physical_node_lock);
> > +	if (!list_empty(&adev->physical_node_list)) {
> > +		const struct acpi_device_physical_node *node;
> > +
> > +		node = list_first_entry(&adev->physical_node_list,
> > +					struct acpi_device_physical_node, node);
> > +		if (node->dev != dev)
> > +			ret = false;
> 
> And that may be simply
> 
> 		ret = node->dev == dev;

OK.

> > +	}
> > +	mutex_unlock(&adev->physical_node_lock);
> > +
> > +	return ret;
> > +}
> > +
