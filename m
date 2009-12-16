From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5 -v2] acpi, apei, Document for APEI
Date: Tue, 15 Dec 2009 23:32:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912152322110.6885@localhost.localdomain>
References: <1260429424.15264.397.camel@yhuang-dev.sh.intel.com>
 <200912110958.29319.bjorn.helgaas@hp.com>
 <1260780295.12561.118.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46861 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447AbZLPEdJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2009 23:33:09 -0500
In-reply-to: <1260780295.12561.118.camel@yhuang-dev.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 14 Dec 2009, Huang Ying wrote:

> On Sat, 2009-12-12 at 00:58 +0800, Bjorn Helgaas wrote: 
> > On Thursday 10 December 2009 12:17:04 am Huang Ying wrote:
> > > Add document for APEI, including kernel parameters and EINJ debug file
> > > sytem interface.
> > 
> > From a stylistic point of view, I think it's better if the
> > documentation is added by the same patch that adds the functionality.
> > Having them in separate patches means there's a point in time where
> > the tree contains the functionality but not the documentation, or
> > vice versa.
> 
> Sounds reasonable, I will change this.

I don't mind if the documentation preceeds or follows the code
in a patch series.  Personally, I'd probably put it in its own
patch like you did just as a lazy way to keep the patches small.
Anybody looking at this code will be looking at the whole series
and it isn't as if documentation is going to break bisect...

What I do mind from a patch submitting style point of view
is to start a series with [PATCH 2/5 -v2].

Please start with 0/5 explaining the difference between v1 and v2;
and then number staring with 1, not 2; else at first glance,
everybody thinks that the most important patch is missing...

That said, all this code is under its own config option,
making it relatively low risk.  The question is if there
would be a significant benefit to merging this code upstream
while we know there is still going to be some significant
movement in this area before it is fully baked...

(that would be another thing to describe in 0/5...)

thanks,
-Len Brown, Intel Open Source Technology Center
