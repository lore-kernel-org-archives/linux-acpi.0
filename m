From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Thu, 06 May 2010 09:58:39 +0800
Message-ID: <1273111119.9950.41.camel@minggr.sh.intel.com>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
	 <201004290956.26922.bjorn.helgaas@hp.com>
	 <987664A83D2D224EAE907B061CE93D53B91F9656@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8496 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab0EFB6I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 May 2010 21:58:08 -0400
In-Reply-To: <987664A83D2D224EAE907B061CE93D53B91F9656@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 2010-04-30 at 06:12 +0800, Luck, Tony wrote:
> >There is not clue in the commit that added this to ia64 as to why
> >dmi_scan_machine() was added as an initcall.  I just tried to move
> >it into setup_arch() - immediately after the efi_init() call as in
> >x86 - and my system hung without printing anything in boot.
> >
> >Agreed this would be a better fix.  I'll see if I can figure out
> >what this call depends on, and so whether I can move is a bit later,
> >but still early enough to be available for Ming's code to work.
> 
> At a random mid-point in setup_arch() I got a lot of errors from
> slub about not being able to allocate memory.  At the very end of
> setup_arch() (after paging_init()) it still failed - with a deref
> NULL inside kmem_alloc().
> 
> So it seems to be non-trivial to just move dmi_scan_machine()
> earlier on ia64 :-(

Sorry for late response, I'm just back from holiday.

Len, 
Can you apply the patch since dmi_available check is needed for ia64?

Thanks,
Lin Ming

