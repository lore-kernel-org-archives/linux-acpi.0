From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Mon, 25 Oct 2010 20:34:52 +0200
Message-ID: <20101025183452.GA3527@gargoyle.fritz.box>
References: <20101021201916.9220.5711.stgit@bob.kio>
 <alpine.LFD.2.00.1010242336390.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48112 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab0JYScq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 14:32:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010242336390.3343@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Myron Stowe <myron.stowe@hp.com>, linux-acpi@vger.kernel.org, ying.huang@intel.com

On Sun, Oct 24, 2010 at 11:38:22PM -0400, Len Brown wrote:
> applied to acpi-test
> 
> My comfort-level with these changes is not high.
> 
> I'm open to your recommendations on if they are
> too late/risky for this merge window -- or too
> important to miss this merge window.

The NMI handling is fairly important  by itself,
on the other hand it has been broken for a long time.

But yes the patches were late unfortunately.

I still think it would be better to push them out
earlier than later simply to get more testing
on more systems.  That's essentially what they need
and unfortunately the only really good way to get
that is being part of a release.

-Andi
