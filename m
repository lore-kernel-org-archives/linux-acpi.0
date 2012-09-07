From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: bus: handle power manageable but no _PSC/_PRx case
Date: Fri, 7 Sep 2012 08:35:14 +0800
Message-ID: <20120907003513.GA1419@mint-spring.sh.intel.com>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com>
 <201209062345.09840.rjw@sisk.pl>
 <201209062353.34517.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42994 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab2IGAfR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Sep 2012 20:35:17 -0400
Content-Disposition: inline
In-Reply-To: <201209062353.34517.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Thu, Sep 06, 2012 at 11:53:34PM +0200, Rafael J. Wysocki wrote:
> On Thursday, September 06, 2012, Rafael J. Wysocki wrote:
> > On Monday, August 27, 2012, Aaron Lu wrote:
> > > Currently, when we are trying to get the power state of an acpi device,
> > > we will do the following:
> > > If device is not power manageable, init its power state as its parent or
> > > if it does not have a parent, init as D0;
> > > If device is power manageable, evaluate _PSC and then refine with
> > > acpi_power_get_inferred_state.
> > > 
> > > But there exist some devices with _PSx defined, but no _PSC or _PRx.
> > > It is power manageable, but the above method to get power state does
> > > not cover this case and its power state will be UNKNOWN(255).
> > > 
> > > So change the check of power manageable to whether _PSC and _PRx
> > > defined.
> > > 
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > 
> > Applied to the linux-next branch of the linux-pm.git tree.
> > 
> > I think it should go to -stable too and therefore it would be good to have
> > it in v3.6, so I'd like to push it to Linus for -rc5, if Len has no objections.
> 
> On a second thought, perhaps the initial power state of those devices
> _should_ be "unknown", hmm?
> 
> After all, we don't know what power state the device is in.

Agree here but I think this is a safe assumption that on initial system
boot, all devices should be at D0. We have already assumed this fact if
the device is not power manageable and has no parent.

And this patch just changed the condition to not judging if power
manageable but if it has _PSC or _PRx, since we will use that to know
the device's power state, so I think using _PSC or _PRx as the
condition check is more precise.

> 
> Is there any practical user-visible problem this causes to happen?

Yes, on a test system, when I try to put a device into D3 cold and ACPI
will complain that I can't due to its parent is in a even lower power
state UNKNOWN(255), this parent device is power manageable but has no
_PSC and _PRx defined.

Thanks,
Aaron
