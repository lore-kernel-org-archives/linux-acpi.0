From: Len Brown <lenb@kernel.org>
Subject: Re: [Patch] ACPI: Notify the _PPC evaluation status to the platform
Date: Fri, 06 Nov 2009 01:57:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911060155020.19209@localhost.localdomain>
References: <1255656041.3563.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:42287 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZKFG5t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2009 01:57:49 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSO00M1NDZRF8UH@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 06 Nov 2009 00:57:28 -0600 (CST)
In-reply-to: <1255656041.3563.61.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Looking at the ACPI 4.0 spec, it appears that we need to
set bit 1 of the platform-wide _OSC capabilities DWORD2
to indicate to the firmware that we will evaluate _OST
on _PPC changes, yes?

thanks,
Len Brown, Intel Open Source Technology Center
