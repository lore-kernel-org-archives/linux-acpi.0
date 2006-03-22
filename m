From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Wed, 22 Mar 2006 20:32:20 +0900
Message-ID: <20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060321222332.1a037c8e.akpm@osdl.org>
	<20060322192804.E490.Y-GOTO@jp.fujitsu.com>
	<20060322030208.30e3581e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36245 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750745AbWCVLch (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 06:32:37 -0500
In-Reply-To: <20060322030208.30e3581e.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: y-goto@jp.fujitsu.com, ak@muc.de, linux-acpi@vger.kernel.org, tony.luck@intel.com

On Wed, 22 Mar 2006 03:02:08 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> I think the problem was introduced by one of the newly-queued patches in
> Andi's tree, possibly
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/hotadd-reserve
> 
I didn't notice this patch and am shocked now....

First, e820 doesn't holds information of memory which doesn't exist at boot
time, I think. This patch can work only with emulated environ. 

Next, Goto-san is now working on new patches , node-hot-add.
It includes add-new-zone/rebuild-zonelist...etc patches, which will be necessary
also for x86_64, even if it's not NUMA. 
I doesn't think this patch should be merged *now*.

-- Kame

