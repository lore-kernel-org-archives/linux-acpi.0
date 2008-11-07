From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory region at startup
 (rev. 2)
Date: Thu, 06 Nov 2008 21:24:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811062123100.3106@localhost.localdomain>
References: <200810262048.23468.rjw@sisk.pl> <200810262054.24929.rjw@sisk.pl>
 <200810310102.42041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:57100 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYKGCYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 21:24:14 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9X006ZNYOE8CK0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 20:24:14 -0600 (CST)
In-reply-to: <200810310102.42041.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>


> Please replace this patch with the appended one.
> 
> I have verified that we are supposed to save/restore the NVS area in the EFI
> case too.

done.
i've also rebased the suspend branch on top of latest linus.

thanks,
-Len
