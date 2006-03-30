From: Andi Kleen <ak@muc.de>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree II
Date: 30 Mar 2006 16:31:22 +0200
Message-ID: <20060330143122.GB84501@muc.de>
References: <20060322192134.GA44212@muc.de> <20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com> <20060323000759.GB71469@muc.de> <20060323093609.8eb03249.kamezawa.hiroyu@jp.fujitsu.com> <20060323024306.GA90581@muc.de> <20060323125942.2facb79b.kamezawa.hiroyu@jp.fujitsu.com> <20060330134133.GB80060@muc.de> <20060330225459.c2c53dbe.kamezawa.hiroyu@jp.fujitsu.com> <20060330141811.GA84501@muc.de> <20060330232522.f9259d93.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:20751 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932236AbWC3ObY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 09:31:24 -0500
Date: Thu, 30 Mar 2006 16:31:22 +0200
Content-Disposition: inline
In-Reply-To: <20060330232522.f9259d93.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

> 2GB to 6GB pages are all added to NORMAL, not DMA32. (2.6.16)
> If this is not sane, x86_64's add_memory should have to check address of start/end.

Hmm thinking about it again it might not be that bad. It could
cause some additional bounces during IO, but shouldn't cause
any malfunction.

-Andi
