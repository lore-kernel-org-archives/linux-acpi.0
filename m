From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/6] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Fri, 09 Jan 2009 16:34:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091631200.20020@localhost.localdomain>
References: <200901092017.n09KH9OP014905@imap1.linux-foundation.org>
 <alpine.LFD.2.00.0901091559120.16697@localhost.localdomain>
 <20090109132355.b3a3c4dc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:52017 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340AbZAIVfK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:35:10 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD800B1J3Y9TM10@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:34:58 -0600 (CST)
In-reply-to: <20090109132355.b3a3c4dc.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com


> On Fri, 09 Jan 2009 16:01:47 -0500 (EST)
> Len Brown <lenb@kernel.org> wrote:
> 
> > I recall nacking this one some time ago.
> 
> Well please treat it as a bug report then.  "the kernel will boot 
> crash when load cpufreq govenors".  Bad!

I agree 100%
I recall asking what machine has this BIOS bug, and it was something
like a prototype, so I didn't lose much sleep over it --
and it was a non-default configuration of that prototype...

I'm all for hardening Linux against BIOS bugs.
Checking 1 bad bit and not checking other bad
bits simply isn't the path to success.

thanks,
-Len
Intel Open Source Technology Center
