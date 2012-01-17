From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/3] ACPI processor: Remove unneeded variable passed by
 acpi_processor_hotadd_init
Date: Tue, 17 Jan 2012 11:52:37 -0500
Message-ID: <20120117165237.GB5111@phenom.dumpdata.com>
References: <1326817230-79711-1-git-send-email-trenn@suse.de>
 <1326817230-79711-3-git-send-email-trenn@suse.de>
 <20120117162951.GB21545@phenom.dumpdata.com>
 <201201171747.53966.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:52159 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab2AQQyw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 11:54:52 -0500
Content-Disposition: inline
In-Reply-To: <201201171747.53966.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, deepthi@linux.vnet.ibm.com, Bjorn Helgaas <bhelgaas@google.com>, "Jiang, Yunhong" <yunhong.jiang@intel.com>

On Tue, Jan 17, 2012 at 05:47:53PM +0100, Thomas Renninger wrote:
> On Tuesday, January 17, 2012 05:29:51 PM Konrad Rzeszutek Wilk wrote:
> > On Tue, Jan 17, 2012 at 05:20:29PM +0100, Thomas Renninger wrote:
> > > This is a very small part taken from patches which afaik
> > > are coming from Yunhong Jiang for Xen.
> > > Xen CPU hotplug things not existing in Linus kernel yet were
> > > removed.
> > 
> > Could you point out the git commit please?
> > I did this:
> >  git log --grep=Yunhong drivers/acpi/processor_driver.c
> > 
> > And could not find it?
> Jiang may know in which Xen Linux kernel repo this went in.
> I grepped the commit from our distri where Jiang was
> mentioned as author.
> 
> Anyway, it's an improvement (one param less)
> and makes things easier when dealing with ACPI CPU hotplug.

Then please provide that description in the git commit.

How does it make it "easier" ?
