From: Darren Hart <dvhart@infradead.org>
Subject: Re: [Update][PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Fri, 24 Apr 2015 15:21:00 -0700
Message-ID: <20150424222100.GA2514@vmdeb7>
References: <3444888.xxxTREorHY@vostro.rjw.lan>
 <2014594.ptBLVGNNCY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56376 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946025AbbDXWVD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2015 18:21:03 -0400
Content-Disposition: inline
In-Reply-To: <2014594.ptBLVGNNCY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Apr 24, 2015 at 02:15:22AM +0200, Rafael Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the special PRP0001 device ID is present in the given device's list
> of ACPI/PNP IDs and the device has a valid "compatible" property in
> the _DSD, it should be enumerated using the default mechanism,
> unless some scan handlers match the IDs preceding PRP0001 in the
> device's list of ACPI/PNP IDs.  In addition to that, no scan handlers
> matching the IDs following PRP0001 in that list should be attached
> to the device.
> 
> To make that happen, define a scan handler that will match PRP0001
> and trigger the default enumeration for the matching devices if the
> "compatible" property is present for them.
> 
> Since that requires the check for platform_id and device->handler
> to be removed from acpi_default_enumeration(), move the fallback
> invocation of acpi_default_enumeration() to acpi_bus_attach()
> (after it's checked if there's a matching ACPI driver for the
> device), which is a better place to call it, and do the platform_id
> check in there too (device->handler is guaranteed to be unset at
> the point where the function is looking for a matching ACPI driver).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Darren Hart <dvhart@linux.intel.com>
> ---
> 
> The change from the original patch is to change the scan handler
> behavior to make it return 1 also if the "compatible" property is
> not present, in which case the additional scan handlers should not
> trigger too *and* the default enumeration should not trigger either
> (as there's no ID to match to), which will allow things like
> auxiliary nodes (think GPIO buttons/LEDs etc) to be easily represented.


This should probably be spelled out in the commit message itself as it's a fairly
unique condition.


> Darren, I've tentatively added your Acked-by tag to this one, please
> let me know if that's not appropriate.

Spent a bit more time on it this time, so:

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center
