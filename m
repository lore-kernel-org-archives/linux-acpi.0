From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: EC: Don't parse DSDT for EC early init on Compal
Date: Sat, 03 Oct 2009 01:23:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910030122050.25240@localhost.localdomain>
References: <20091002162133.14126.81642.stgit@thinkpad>
 <20091002162140.14126.5393.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:43279 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZJCFXK (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 3 Oct 2009 01:23:10 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQX003A4AYOOOKC@vms173001.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Sat, 03 Oct 2009 00:23:13 -0500 (CDT)
In-reply-to: <20091002162140.14126.5393.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

i'm not really excited about a DMI workaround,
but I'm applying it b/c it addresses the problem at hand.

Hopefully a more permanent fix will emerge over time.

thanks,
Len Brown, Intel Open Source Technology Center

