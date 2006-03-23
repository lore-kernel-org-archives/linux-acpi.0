From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Thu, 23 Mar 2006 09:36:09 +0900
Message-ID: <20060323093609.8eb03249.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060321222332.1a037c8e.akpm@osdl.org>
	<20060322192804.E490.Y-GOTO@jp.fujitsu.com>
	<20060322030208.30e3581e.akpm@osdl.org>
	<20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
	<20060322192134.GA44212@muc.de>
	<20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com>
	<20060323000759.GB71469@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:28379 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751446AbWCWAgm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 19:36:42 -0500
In-Reply-To: <20060323000759.GB71469@muc.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

On 23 Mar 2006 01:07:59 +0100
Andi Kleen <ak@muc.de> wrote:

> On Thu, Mar 23, 2006 at 08:27:32AM +0900, KAMEZAWA Hiroyuki wrote:
> > On 22 Mar 2006 20:21:34 +0100
> > Andi Kleen <ak@muc.de> wrote:
> > 
> > > > It includes add-new-zone/rebuild-zonelist...etc patches, which will be necessary
> > > > also for x86_64, even if it's not NUMA. 
> > > 
> > > Hmm? x86_64 supports NUMA systems.
> > > 
> > Ah, I know.
> > I wrote "even if.." just because we cannot reserve mem_map for not exisiting node.
> 
> Hmm actually I haven't tested it but in theory the reserve hotplug
> code should just work if you list the new nodes already in SRAT as empty
> hotplug PXMs.
> 
SRAT is required by Microsoft, then most of servers will equip it, I think.
And SRAT just tells each cpu's/memory range's  a pxm.

But allocating memmap for SRAT entry has some problem in big system.

For example, our server (ia64/Fujitsu PrimeQuest) can equip memory from
4G to 1T(maybe 2T in future), and SRAT will *always* say  we have possible 1T memory.
(Microsoft requires "write all possible memory in SRAT") 
When we reserve memmap for possible 1T memory, Linux will not work well in minimum 4G
configuraion ;) 
So, I recommend allocate memmap dynamically.

> Ok there is no code yet to add hotplug cpus to specific nodes later
> but that would be easy to add.
> 
We found hot-add-memory-less-node problem now. So, "cpu hot add to a new node"  
will be supported later.

-- Kame

