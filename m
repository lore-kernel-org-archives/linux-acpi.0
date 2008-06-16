From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list
 to force rsdt - also add R51e
Date: Mon, 16 Jun 2008 19:08:57 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806161902440.12628@localhost.localdomain>
References: <1210259416.6710.13.camel@hammer1.suse.de>
 <200805081609.08810.lenb@kernel.org>
 <1213581031.30416.11.camel@yakui_zhao.sh.intel.com>
 <200806161719.06184.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:52299 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870AbYFPXJK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jun 2008 19:09:10 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2K00BCDWB0O2B4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Jun 2008 18:09:01 -0500 (CDT)
In-reply-to: <200806161719.06184.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn <trenn@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, me@markdoughty.co.uk



> > In fact we have another similar bug:
> >    http://bugzilla.kernel.org/show_bug.cgi?id=8246
> >
> >    The 32/64X address mismatch also exists on the laptop of IBM R51e.
> ...
> Thanks.
> Below is a version with the R51e included.

Appropriate workaround for a distro release?  Yes.
Appropriate patch for upstream?  No.

Upstream should fix the root cause, which is to figure out when the RSDT 
and XSDT disagree, which Windows is using, and use that one.  Littering 
upstream with DMI entries simply hides the test cases that we know about
and delays the correct fix.

-Len


