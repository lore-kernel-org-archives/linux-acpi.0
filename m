From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
	R50p
Date: Tue, 12 Aug 2008 16:20:17 +0800
Message-ID: <1218529217.3209.9.camel@rzhang-dt>
References: <200807301556.01815.trenn@suse.de>
	 <200808111433.25275.trenn@suse.de> <20080811125519.GA26308@srcf.ucam.org>
	 <200808111614.17161.trenn@suse.de> <20080811141552.GA28294@srcf.ucam.org>
	 <48A1431A.8090300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41379 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbYHLIU2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Aug 2008 04:20:28 -0400
In-Reply-To: <48A1431A.8090300@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Tue, 2008-08-12 at 16:00 +0800, Andi Kleen wrote:
> Matthew Garrett wrote:
> > On Mon, Aug 11, 2008 at 04:14:14PM +0200, Thomas Renninger wrote:
> >
> >> So what is the status here, how should we proceed?
> >> This isn't applied to any tree yet?
> >> IMO you should send those two with below fixed and Andi could queue
> them on
> >> the test branch and keep it a while there.
> >
> > I posted them, got a small amount of feedback and no further acks. I
> can
> > push them again.
> 
> The problem seems to be that some people report this as a regression.

No, the problem we discussed here is not a regression.
http://bugzilla.kernel.org/show_bug.cgi?id=10658
And the patch just works for the laptops that:
1. without passive trip point
2. with a passive trip point that doesn't help because it is too close
to the critical trip point.

And it's true that there is a thermal regression reported recently,
http://bugzilla.kernel.org/show_bug.cgi?id=11281
but IMO, that's another problem and we have not root caused yet.

thanks,
rui

