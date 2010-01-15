From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
 method
Date: Fri, 15 Jan 2010 17:03:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001151700210.10250@localhost.localdomain>
References: <20091015103122.3853.34760.stgit@thinkpad>
 <20091015103144.3853.9717.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:44468 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab0AOWDz (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 15 Jan 2010 17:03:55 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00C1P6MDL3N6@vms173017.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Fri, 15 Jan 2010 16:03:50 -0600 (CST)
In-reply-to: <20091015103144.3853.9717.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi-test with checkpatch error fixed:

ERROR: spaces required around that '?' (ctx:VxE)
#106: FILE: drivers/acpi/battery.c:390:
+	char *name = test_bit(ACPI_BATTERY_XINFO_PRESENT, 
&battery->flags)?
 	                                                                  
^

total: 1 errors, 0 warnings, 135 lines checked


thanks,
Len Brown, Intel Open Source Technology Center

