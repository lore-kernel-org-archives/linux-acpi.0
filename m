From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI: Add acpi_gbl_osi_data to OS headers
Date: Fri, 04 Jun 2010 13:36:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006041333350.4073@localhost.localdomain>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com>
 <1274283791-3380-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:59580 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0FDRgP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 13:36:15 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I000D13K3BZO6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 12:36:06 -0500 (CDT)
In-reply-to: <1274283791-3380-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com


> Different operating systems may wish to enable different workaround quirks
> depending on the _OSI methods called by the firmware.

I think that if this compatibility puzzle is solved,
then there is no reason that, say, BSD, would want to do something
different than Linux.

So I think it makes more sent to implement this workaround
inside ACPICA, and not in the Linux-specific code.

thanks,
Len Brown, Intel Open Source Technology Center
