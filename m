From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Thu, 23 Mar 2006 12:59:42 +0900
Message-ID: <20060323125942.2facb79b.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060321222332.1a037c8e.akpm@osdl.org>
	<20060322192804.E490.Y-GOTO@jp.fujitsu.com>
	<20060322030208.30e3581e.akpm@osdl.org>
	<20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
	<20060322192134.GA44212@muc.de>
	<20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com>
	<20060323000759.GB71469@muc.de>
	<20060323093609.8eb03249.kamezawa.hiroyu@jp.fujitsu.com>
	<20060323024306.GA90581@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9670 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965169AbWCWEAG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 23:00:06 -0500
In-Reply-To: <20060323024306.GA90581@muc.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

On 23 Mar 2006 03:43:06 +0100
Andi Kleen <ak@muc.de> wrote:

> > For example, our server (ia64/Fujitsu PrimeQuest) can equip memory from
> > 4G to 1T(maybe 2T in future), and SRAT will *always* say  we have possible 1T memory.
> > (Microsoft requires "write all possible memory in SRAT") 
> > When we reserve memmap for possible 1T memory, Linux will not work well in minimum 4G
> 
> Don't do that.
> The x86-64 kernel will preallocate memmaps when everything is enabled soon.
> Ok that won't concern your IA64 machine immediately.
> 

Okay... I took several cups of coffee and understood what you say.and what x86_64 does.

If X86_64=y and CONFIG_MEMORY_HOTPLUG=n, system works like this..

1. preallocate all memmap, for memory range in SRAT. initialize all.
   just don't free pages (page struct) at boot time.

2. pre-initialize all pgdat/zone. even if ther are empty.(but have huge amount of
   reserved pages(memmap))

3. When add_memory() is called, just call free_page(page) and make pages populated. 

4. 

5. Only problem is firmware configurated as "small memory + huge SRAT entry".

Correct ?

Note: "enabled" in SRAT just means "you can read this entry". not means "memory is present".

--Kame

