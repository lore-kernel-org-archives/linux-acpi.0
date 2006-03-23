From: Andi Kleen <ak@muc.de>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: 23 Mar 2006 01:07:59 +0100
Message-ID: <20060323000759.GB71469@muc.de>
References: <20060321222332.1a037c8e.akpm@osdl.org> <20060322192804.E490.Y-GOTO@jp.fujitsu.com> <20060322030208.30e3581e.akpm@osdl.org> <20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com> <20060322192134.GA44212@muc.de> <20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:23049 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932543AbWCWAIF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 19:08:05 -0500
Date: Thu, 23 Mar 2006 01:07:59 +0100
Content-Disposition: inline
In-Reply-To: <20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

On Thu, Mar 23, 2006 at 08:27:32AM +0900, KAMEZAWA Hiroyuki wrote:
> On 22 Mar 2006 20:21:34 +0100
> Andi Kleen <ak@muc.de> wrote:
> 
> > > It includes add-new-zone/rebuild-zonelist...etc patches, which will be necessary
> > > also for x86_64, even if it's not NUMA. 
> > 
> > Hmm? x86_64 supports NUMA systems.
> > 
> Ah, I know.
> I wrote "even if.." just because we cannot reserve mem_map for not exisiting node.

Hmm actually I haven't tested it but in theory the reserve hotplug
code should just work if you list the new nodes already in SRAT as empty
hotplug PXMs.

Ok there is no code yet to add hotplug cpus to specific nodes later
but that would be easy to add.

The only problem is that mem_map has to be in another node so it will be 
slightly slower.

-Andi

