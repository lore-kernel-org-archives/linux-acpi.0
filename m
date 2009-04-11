From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH] ACPI: EC: Merge poll and interrupt modes
Date: Fri, 10 Apr 2009 23:30:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904102328210.8559@localhost.localdomain>
References: <49D7EEBA.40203@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:41559 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbZDKDaH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2009 23:30:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHX001M6322DNF6@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Apr 2009 22:30:03 -0500 (CDT)
In-reply-to: <49D7EEBA.40203@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

weird, when i save or export this patch from alpine,
it wraps the long lines, causing the patch to get corrupted.

eg.
     pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
becomes:
     pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 
0x%lx\n",

i've never run into this before...

Len Brown, Intel Open Source Technology Center

