From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Wed, 22 Apr 2015 12:57:18 +0300
Message-ID: <20150422095718.GM1677@lahna.fi.intel.com>
References: <3444888.xxxTREorHY@vostro.rjw.lan>
 <4530573.vsU6fqTbSL@vostro.rjw.lan>
 <1915841.HSgUQOmSYM@vostro.rjw.lan>
 <1816071.3jMa2RA6JD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53607 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934366AbbDVJ5Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2015 05:57:24 -0400
Content-Disposition: inline
In-Reply-To: <1816071.3jMa2RA6JD@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Darren Hart <dvhart@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 22, 2015 at 03:54:16AM +0200, Rafael J. Wysocki wrote:
> Any comments?
> 
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: ACPI / property: Refine consistency check for PRP0001
> > 
> > Refine the check for the presence of the "compatible" property
> > if the PRP0001 device ID is present in the device's list of
> > ACPI/PNP IDs to also print the message if _DSD is missing
> > entirely or the format of it is incorrect.
> > 
> > While at it, reduce the log level of the message to "info"
> > and reduce the log level of the "broken _DSD" message to
> > "debug" (noise reduction).
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good,

Reviewed-by: Mika Westerberg <mika.westerberb@linux.intel.com>
