From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/4] ACPI / platform: provide default DMA mask
Date: Wed, 24 Sep 2014 09:30:16 +0300
Message-ID: <20140924063016.GA30585@xps8300>
References: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
 <2422219.EN0C5cKd3e@vostro.rjw.lan>
 <20140923152945.GE28592@saruman>
 <1430862.A6ximsuo3m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42497 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaIXGbn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2014 02:31:43 -0400
Content-Disposition: inline
In-Reply-To: <1430862.A6ximsuo3m@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: balbi@ti.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Sep 23, 2014 at 06:05:36PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 23, 2014 10:29:45 AM Felipe Balbi wrote:
> > On Tue, Sep 23, 2014 at 05:17:03PM +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, September 23, 2014 09:52:21 AM Felipe Balbi wrote:
> > > > On Tue, Sep 23, 2014 at 04:52:01PM +0200, Rafael J. Wysocki wrote:
> > > > > On Tuesday, September 23, 2014 03:17:12 PM Heikki Krogerus wrote:
> > > > > > On Wed, Aug 20, 2014 at 02:55:26PM +0300, Heikki Krogerus wrote:
> > > > > > > Most devices are configured for 32-bit DMA addresses.
> > > > > > > Setting the mask to 32-bit here removes the need for the
> > > > > > > drivers to do it separately.
> > > > > > 
> > > > > > Rafael, is this OK?
> > > > > 
> > > > > Fine by me, but it should go in via dwc3 I think.
> > > > 
> > > > huh ? Seems like there's no direct dependency.
> > > 
> > > Well, it's part of a series where all of the other patches touch dwc3.
> > > Doesn't anything in that series depend on this patch?
> > 
> > dunno, I haven't received anything.
> 
> Hmm.
> 
> Heikki, can you please resend the series and CC all of it to Felipe?

The series was send "To" Felipe...

I'll resend.


Thanks,

-- 
heikki
