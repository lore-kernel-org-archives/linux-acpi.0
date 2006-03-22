From: Andi Kleen <ak@muc.de>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: 22 Mar 2006 20:21:34 +0100
Message-ID: <20060322192134.GA44212@muc.de>
References: <20060321222332.1a037c8e.akpm@osdl.org> <20060322192804.E490.Y-GOTO@jp.fujitsu.com> <20060322030208.30e3581e.akpm@osdl.org> <20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:44305 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932387AbWCVTVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 14:21:39 -0500
Date: Wed, 22 Mar 2006 20:21:34 +0100
Content-Disposition: inline
In-Reply-To: <20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

> It includes add-new-zone/rebuild-zonelist...etc patches, which will be necessary
> also for x86_64, even if it's not NUMA. 

Hmm? x86_64 supports NUMA systems.

-Andi
