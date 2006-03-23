From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Thu, 23 Mar 2006 12:22:50 +0900
Message-ID: <20060323122250.c22003d0.kamezawa.hiroyu@jp.fujitsu.com>
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
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14531 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932183AbWCWDXE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 22:23:04 -0500
In-Reply-To: <20060323024306.GA90581@muc.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com, yo-goto@ml.soft.fujitsu.com

On 23 Mar 2006 03:43:06 +0100
Andi Kleen <ak@muc.de> wrote:

>
> Don't do that.
> The x86-64 kernel will preallocate memmaps when everything is enabled soon.
> Ok that won't concern your IA64 machine immediately.
> 
> 

I read hotadd-reserve patches again.. Okay, please preallocate if you want.

Problem I found is:
1) Goto's rebuild_zonelist patch will not work if CONFIG_MEMORY_HOTPLUG=n.
   rebuild zonelist is necessary when the system has just memory < 4G at boot,   
   and hot add memory > 4G. because x86_64 has DMA32, ZONE_NORAML is not included into
   zonelist at boot time if system doesn't have memory >4G at boot.

2) zone and node's spanned_pages and present_pages are not incremented. you should do.

Bye.
-- Kame

