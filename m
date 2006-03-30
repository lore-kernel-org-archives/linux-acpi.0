From: Andi Kleen <ak@muc.de>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree II
Date: 30 Mar 2006 15:41:33 +0200
Message-ID: <20060330134133.GB80060@muc.de>
References: <20060321222332.1a037c8e.akpm@osdl.org> <20060322192804.E490.Y-GOTO@jp.fujitsu.com> <20060322030208.30e3581e.akpm@osdl.org> <20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com> <20060322192134.GA44212@muc.de> <20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com> <20060323000759.GB71469@muc.de> <20060323093609.8eb03249.kamezawa.hiroyu@jp.fujitsu.com> <20060323024306.GA90581@muc.de> <20060323125942.2facb79b.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:47882 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932167AbWC3Nlm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 08:41:42 -0500
Date: Thu, 30 Mar 2006 15:41:33 +0200
Content-Disposition: inline
In-Reply-To: <20060323125942.2facb79b.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com


Hi,

I started to implement your suggestion now.

But one problem I noticed and I don't see how the current sparsemem code
handles correctly is that it makes no attempt to handle hotadd
areas that cross zone boundaries. Is there code somewhere that rejects
them?

-Andi
