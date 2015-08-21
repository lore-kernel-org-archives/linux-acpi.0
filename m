From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Fri, 21 Aug 2015 17:46:21 +0530
Message-ID: <20150821121621.GB26813@intel-desktop>
References: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
 <20150820123805.GG30005@lahna.fi.intel.com>
 <20150820130447.GA1337@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15629 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbbHUEZL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2015 00:25:11 -0400
Content-Disposition: inline
In-Reply-To: <20150820130447.GA1337@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>

On Thu, Aug 20, 2015 at 04:04:47PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, Aug 20, 2015 at 03:38:05PM +0300, Mika Westerberg wrote:
> > +Heikki
> > 
> > On Thu, Aug 20, 2015 at 10:46:07PM +0530, Srinidhi Kasagar wrote:
> > > LPSS devices in Braswell and Baytrail does not need the default
> > > 10ms d3_delay imposed by PCI specification. Removing this
> > > unnecessary delay significantly reduces the resume time
> > > (~200ms on Braswell/Cherrytrail) on these platforms.
> > > 
> > > Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> > > Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> > 
> > Have you tested this on Asus T100? The delay was actually needed in
> > order to restore the context IIRC.
> 
> We need to make sure the write operation succeeded when restoring the
> register values. That was the problem we had with T100, which btw. is
> Baytrail.
> 
> Instead of using the delay conditionally, why not just read the value
> back in a loop (with timeout of course) until we see the write
> succeed? That should speedup the resume like you want, but still
> guarantee the ctx has really been restored.

I would love to do that. But these are PCI devices and the delay
is imposed by PCI spec and in many other places these conditional
delays have been used. I do not think there exist any mechanism to
verify write succeeds.

Srinidhi
