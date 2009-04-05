From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH] ACPI: EC: Merge poll and interrupt modes
Date: Sun, 05 Apr 2009 00:22:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904050020350.4821@localhost.localdomain>
References: <49D7EEBA.40203@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:57706 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbZDEEWm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Apr 2009 00:22:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHM004GM1H4SUL7@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 04 Apr 2009 23:22:17 -0500 (CDT)
In-reply-to: <49D7EEBA.40203@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

if you send me a checkpatch.pl clean version,
I'll put it in the acpi-test tree.

It is too late to test this broadly before the 2.6.30 merge window closes,
but who knows, maybe 2.6.31 and a .stable backport if it turns out to be 
wonderful...

thanks,
Len Brown, Intel Open Source Technology Center

