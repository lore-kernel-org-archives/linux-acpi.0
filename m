From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Tue, 24 Nov 2015 09:08:19 -0800
Message-ID: <20151124170819.GC30134@malice.jf.intel.com>
References: <cover.1448282995.git.lukas@wunner.de>
 <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de>
 <20151123190413.GU7413@malice.jf.intel.com>
 <1776557.hOTai0RnF7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43614 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbKXRI0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2015 12:08:26 -0500
Content-Disposition: inline
In-Reply-To: <1776557.hOTai0RnF7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org, devel@acpica.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

On Mon, Nov 23, 2015 at 11:35:55PM +0100, Rafael Wysocki wrote:
> On Monday, November 23, 2015 11:04:13 AM Darren Hart wrote:
> > On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> > > Use shiny new acpi_dev_present and remove all the boilerplate to search
> > > for a particular ACPI device. No functional change.
> > 
> > You did add a pr_warn, which is technically a functional change. Did you intend
> > to leave that in?
> > 
> > I have no objection for platform-drivers-x86, but please include all maintainers
> > listed by get_maintainer.pl for the fastest response.
> > 
> > +Rafael
> > 
> > Rafael, I assume you will pick this up along with the acpi_dev_present ACPI
> > change if you take that. Pleaes let me know if not.
> > 
> > Otherwise,
> > 
> > Acked-by: Darren Hart <dvhart@linux.intel.com>
> 
> In fact, patch [1/5] as is needs to go in through upstream ACPICA, so I'm not
> taking this series and please don't take it too.

Ah, thanks, my mistake.


-- 
Darren Hart
Intel Open Source Technology Center
