From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Wed, 27 Oct 2010 21:53:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010272147110.7501@localhost.localdomain>
References: <20101021201916.9220.5711.stgit@bob.kio>
 <alpine.LFD.2.00.1010242336390.3343@localhost.localdomain>
 <20101025183452.GA3527@gargoyle.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:43486 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab0J1BxR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2010 21:53:17 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAZ00GPS98P2UI3@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 27 Oct 2010 20:53:15 -0500 (CDT)
In-reply-to: <20101025183452.GA3527@gargoyle.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Myron Stowe <myron.stowe@hp.com>, linux-acpi@vger.kernel.org, ying.huang@intel.com

> On Sun, Oct 24, 2010 at 11:38:22PM -0400, Len Brown wrote:
> > applied to acpi-test
> > 
> > My comfort-level with these changes is not high.
> > 
> > I'm open to your recommendations on if they are
> > too late/risky for this merge window -- or too
> > important to miss this merge window.
> 
> The NMI handling is fairly important  by itself,
> on the other hand it has been broken for a long time.
> 
> But yes the patches were late unfortunately.
> 
> I still think it would be better to push them out
> earlier than later simply to get more testing
> on more systems.  That's essentially what they need
> and unfortunately the only really good way to get
> that is being part of a release.

I agree with Andi.

This bit is upstream now.
if we have troubles with it, then we can
still revert/repair during 2.6.37 rc.

thanks,
Len Brown, Intel Open Source Technology Center

