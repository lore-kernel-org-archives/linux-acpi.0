From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] ACPI / enumeration: Document the rules regarding the
 PRP0001 device ID
Date: Thu, 18 Jun 2015 14:27:16 -0700
Message-ID: <20150618212716.GB121898@vmdeb7>
References: <2849248.1anC4YaKJn@vostro.rjw.lan>
 <20150611094129.GT1478@lahna.fi.intel.com>
 <2448906.OPRrQsay8x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41810 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbFRV1R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2015 17:27:17 -0400
Content-Disposition: inline
In-Reply-To: <2448906.OPRrQsay8x@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jun 12, 2015 at 02:28:45AM +0200, Rafael Wysocki wrote:
> On Thursday, June 11, 2015 12:41:29 PM Mika Westerberg wrote:
> > On Thu, Jun 11, 2015 at 03:24:02AM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Document how the ACPI device enumeration code uses the special
> > > PRP0001 device ID.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > At last the long needed documentation regarding PRP0001 :-) Thank you
> > for doing this,
> > 
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > One typo found, see below.
> 
> Thanks!
> 
> I've fixed this one and added a clarification about enumerating I2C and SPI
> clients with PRP0001 and "compatible".
> 
> Updated patch is below.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI / enumeration: Document the rules regarding the PRP0001 device ID
> 
> Document how the ACPI device enumeration code uses the special
> PRP0001 device ID.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
