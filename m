From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/2] als: add unique device-ids to the als device class
Date: Thu, 26 Nov 2009 10:06:46 -0800
Message-ID: <20091126180646.GA9059@suse.de>
References: <1259237081-4403-1-git-send-email-amit.kucheria@verdurent.com> <1259237186-5459-1-git-send-email-amit.kucheria@verdurent.com> <20091126160713.5e19eb04@hyperion.delvare> <4B0EB891.4010309@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47371 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbZKZSKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2009 13:10:38 -0500
Content-Disposition: inline
In-Reply-To: <4B0EB891.4010309@cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Amit Kucheria <amit.kucheria@verdurent.com>, List Linux Kernel <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, alan@linux.intel.com, linux-acpi@vger.kernel.org

On Thu, Nov 26, 2009 at 05:19:13PM +0000, Jonathan Cameron wrote:
> > That being said... If we want user-space to know what device is there,
> > we may want to still let drivers pass a name string to
> > als_device_register() and let the ALS core create a "name" sysfs
> > attribute returning the string in question. This would be much lighter
> > (for individual drivers) than the previous situation, as the string in
> > question would be a constant (e.g. "TSL2550".) Opinions?
> > 
> Makes sense given we want all drivers to support some form of identification.
> We could do it by stating they will all have that attribute, but given it's constant
> will save repetition to put it in the driver. Conversely it might complicate the handling
> of subsequent attribute_groups so I'd probably favour adding relevant documentation lines
> and leaving it up to the drivers to implement this attribute.
> 
> Thus we'd require (within reason) all drivers to have illuminance0 and name.

Why have a name attribute when you can just use the name of the device
itself instead?  Isn't that what it is there for?

confused,

greg k-h
