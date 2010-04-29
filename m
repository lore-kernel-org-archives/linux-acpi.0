From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Thu, 29 Apr 2010 15:12:38 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D53B91F9656@orsmsx505.amr.corp.intel.com>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
 <201004290956.26922.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2297 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933090Ab0D3RVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2010 13:21:23 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

>There is not clue in the commit that added this to ia64 as to why
>dmi_scan_machine() was added as an initcall.  I just tried to move
>it into setup_arch() - immediately after the efi_init() call as in
>x86 - and my system hung without printing anything in boot.
>
>Agreed this would be a better fix.  I'll see if I can figure out
>what this call depends on, and so whether I can move is a bit later,
>but still early enough to be available for Ming's code to work.

At a random mid-point in setup_arch() I got a lot of errors from
slub about not being able to allocate memory.  At the very end of
setup_arch() (after paging_init()) it still failed - with a deref
NULL inside kmem_alloc().

So it seems to be non-trivial to just move dmi_scan_machine()
earlier on ia64 :-(

-Tony
