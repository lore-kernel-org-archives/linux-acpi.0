From: Len Brown <lenb@kernel.org>
Subject: Re: [REGRESSION] 9a884ab64a4d092b4c3bf24fd9a30f7fbd4591e7 causes boot
 hang
Date: Tue, 15 Dec 2009 22:41:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912152240320.6885@localhost.localdomain>
References: <20091215181538.GA28707@srcf.ucam.org>
 <1260925040.3834.69.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:45989 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZLPDlf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2009 22:41:35 -0500
In-reply-to: <1260925040.3834.69.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Matthew,

Alternatively, you can pick up the latest ACPICA code from
the acpica or release branches of the acpi tree.

Please let me know as soon as you can check if it helps.

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 16 Dec 2009, Lin Ming wrote:

> On Wed, 2009-12-16 at 02:15 +0800, Matthew Garrett wrote:
> > Commit 9a884ab64a4d092b4c3bf24fd9a30f7fbd4591e7 (ACPICA: Add additional 
> > module-level code support) results in one of my test machines hanging at 
> > boot. The last line output is:
> > 
> > bio: create slab <bio-0> at 0
> > 
> > which would normally be followed by
> > 
> > ACPI: EC: Look up EC in DSDT
> > 
> > but instead the machine hangs without printing this line. Reverting the 
> > commit results in the machine booting. acpidump output attached.
> > 
> 
> Hi, Matthew
> 
> Could you try the attached ACPICA latest release (20091214) patch
> series? There are module level code and _REG method fixes included in
> it.
> 
> Checkout Linus' tree.
> git am acpica-v20091214.patch
> 
> Thanks,
> Lin Ming
> 
> 
