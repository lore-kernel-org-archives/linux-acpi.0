From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] trival: fix acpi_hest_firmware_first_pci() caused oops
Date: Thu, 06 May 2010 02:33:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005060221270.28850@localhost.localdomain>
References: <1270696575-3385-1-git-send-email-shaohua.li@intel.com>
 <alpine.LFD.2.00.1004201100220.2402@sony>
 <20100505013923.GA30454@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:44568 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab0EFGdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 02:33:36 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00F5IJJ9YE80@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 01:33:10 -0500 (CDT)
In-reply-to: <20100505013923.GA30454@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


> > wouldn't it be better for acpi_get_table()
> > to return failure for acpi=off?

> but acpi_disabled is a linux variable while acpi_get_table is ACPICA code.

For the acpi_disabled case, acpi_get_table() will return AE_NOT_FOUND
because acpi_gbl_root_table_list.count == 0,
and leave the table pointer unchanged at NULL, yes?

Looking at the other callers of acpi_get_table(),
they all seem to be called when acpi is enabled
and they know the table in question is going to be there.
So I guess it is consistent for hest.c to know this too.
But it looks like acpi_get_table() should fail gracefully,
so why do we take a fault?

-Len

