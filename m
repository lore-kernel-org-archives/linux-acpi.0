From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Wed, 21 May 2008 13:06:17 +0200
Message-ID: <20080521110616.GB9330@homac>
References: <20080521104547.GA8097@homac> <20080521105944.GA30728@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:60164 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756675AbYEULDi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2008 07:03:38 -0400
Content-Disposition: inline
In-Reply-To: <20080521105944.GA30728@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com, Len Brown <lenb@kernel.org>

On Wed 21. May - 11:59:44, Matthew Garrett wrote:
> On Wed, May 21, 2008 at 12:45:47PM +0200, Holger Macht wrote:
> > If acpi_install_notify_handler() for a bay device fails, the bay driver is
> > superfluous. Most likely, another driver (like libata) is already caring
> > about this device anyway. Furthermore,
> > register_hotplug_dock_device(acpi_handle) from the dock driver must not be
> > called twice with the same handler. This would result in an endless loop
> > consuming 100% of CPU. So clean up and exit.
> 
> The bay driver still provides the only mechanism for calling the eject 
> methods.

Yes, I'll send a patch on top of the libata hotplug fixes as soon as it's
in for that. But this patch has nothing to do with this. Without it, you
get an unusable system.

Regards,
	Holger

