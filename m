From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Thu, 23 Mar 2006 08:27:32 +0900
Message-ID: <20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060321222332.1a037c8e.akpm@osdl.org>
	<20060322192804.E490.Y-GOTO@jp.fujitsu.com>
	<20060322030208.30e3581e.akpm@osdl.org>
	<20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
	<20060322192134.GA44212@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:12470 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932523AbWCVX13 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 18:27:29 -0500
In-Reply-To: <20060322192134.GA44212@muc.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

On 22 Mar 2006 20:21:34 +0100
Andi Kleen <ak@muc.de> wrote:

> > It includes add-new-zone/rebuild-zonelist...etc patches, which will be necessary
> > also for x86_64, even if it's not NUMA. 
> 
> Hmm? x86_64 supports NUMA systems.
> 
Ah, I know.
I wrote "even if.." just because we cannot reserve mem_map for not exisiting node.

-- Kame

