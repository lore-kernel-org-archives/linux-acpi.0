From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Wed, 06 Jan 2010 14:38:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001061433260.4086@localhost.localdomain>
References: <4B42B3FD.7000608@zytor.com>
 <1262694629-7068-1-git-send-email-ch@zeha.at> <4B437127.1000605@zytor.com>
 <201001051926.30580.ch@zeha.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:48813 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453Ab0AFTix (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 14:38:53 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVU00237BWCVWRJ@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 06 Jan 2010 13:38:41 -0600 (CST)
In-reply-to: <201001051926.30580.ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

> Also, I think we could push the year even more up, say, to 2009. On the 
> assumption that such new hardware which can't do BOOT_KBD is only being 
> produced now (late 2009). Better err on the safe side?

I'd prefer sticking with 2006 so we don't need a white-list for
brand-new machines.

Indeed, I think that 2006 is already conservative,
and I'd be willing to debug failures on machines back as far as 2003.

thanks,
-Len Brown, Intel Open Source Technology Center


