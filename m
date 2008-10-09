From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] ACPICA: Add hard limit to while loop
Date: Thu, 09 Oct 2008 12:32:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810091230001.3007@localhost.localdomain>
References: <20081009103539.1238.81357.stgit@thinkpad>
 <4911F71203A09E4D9981D27F9D83085803123152@orsmsx503.amr.corp.intel.com>
 <4911F71203A09E4D9981D27F9D83085803123249@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:38390 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYJIRcQ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 13:32:16 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8H00IFCCLGWSH0@vms172071.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Thu, 09 Oct 2008 11:32:05 -0500 (CDT)
In-reply-to: <4911F71203A09E4D9981D27F9D83085803123249@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>


Are AML while loops our only exposure to getting stuck interpreting AML 
forever?

Maybe there is a more general solution that would cover everything, such 
as counting opcodes or setting a watchdog timer?

thanks,
-Len

