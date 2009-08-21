From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Fri, 21 Aug 2009 10:33:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908211032330.2912-100000@iolanthe.rowland.org>
References: <20090821064630.GB16694@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34437 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932214AbZHUOdt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2009 10:33:49 -0400
In-Reply-To: <20090821064630.GB16694@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Fri, 21 Aug 2009, Shaohua Li wrote:

> > > I'm still not clear on this.  Does the non-standard wakeup register
> > > have to be set and cleared by the suspend and resume routines in
> > > uhci-hcd, or will it be handled by other code?
> > 
> > I'm not sure if anyone can answer this 100% accurately without doing any
> > testing.
> As far as I know, when the pci trys to enable pme, we will call corresponding
> ACPI methods. In that methods, the non-starndard wakeup registers will be
> set/clear. The issue is we must relay on correct BIOS.

If the BIOS doesn't know about the non-standard register then it won't 
set the wakeup bits.  Therefore the fact that it won't clear them 
doesn't matter.

Alan Stern

