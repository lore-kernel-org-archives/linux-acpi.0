From: Len Brown <lenb@kernel.org>
Subject: RE: [patch 2/6] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Fri, 09 Jan 2009 16:52:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091649400.20020@localhost.localdomain>
References: <200901092017.n09KH9OP014905@imap1.linux-foundation.org>
 <alpine.LFD.2.00.0901091559120.16697@localhost.localdomain>
 <20090109132355.b3a3c4dc.akpm@linux-foundation.org>
 <7E82351C108FA840AB1866AC776AEC4643B5888C@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:59322 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758230AbZAIVwS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:52:18 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD8005XF4R4DCE1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:52:17 -0600 (CST)
In-reply-to: <7E82351C108FA840AB1866AC776AEC4643B5888C@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Song, Youquan" <youquan.song@intel.com>

> >> I recall nacking this one some time ago.
> >
> >Well please treat it as a bug report then.  "the kernel will boot
> >crash when load cpufreq govenors".  Bad!
> >
> 
> I think this should be a special case even when it is not defined in spec.
> 
> There is BIOS code out there that is giving 0x80000000 and Linux fails to
> boot on these systems, where as the other OS does not. Existence of even one
> such system means that the code will surely be copied onto other BIOSes and
> I don't think we can persuade BIOS guys to change this.

Let me be clear.
I agree that this needs to be fixed.
My point is that this patch is the wrong way to do it.

We need to become hardened to total garbage in this field,
or we need to do a better job of sanity checking it rather
than checking one particular bit (of many) that may be bogus.

thanks,
-Len
Intel Open Source Technology Center
