From: Len Brown <lenb@kernel.org>
Subject: Re: [Bugme-new] [Bug 12994] New: Thinkpad R51e is overheating even
 when idle
Date: Wed, 01 Apr 2009 23:48:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904012346170.4657@localhost.localdomain>
References: <bug-12994-10286@http.bugzilla.kernel.org/>
 <20090401124744.951c9443.akpm@linux-foundation.org>
 <1238620590.21668.1308498203@webmail.messagingengine.com>
 <20090401234340.GA5234@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:32250 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZDBDs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 23:48:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHG00E8SFW5S1XC@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 01 Apr 2009 22:48:06 -0500 (CDT)
In-reply-to: <20090401234340.GA5234@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

> > Executive summary: AFAIK, that thinkpad might be having hardware problems.
> 
> BUT, if we are doing worse in recent kernels and the submitter verifies this
> testing an older kernel, it is a bug and we need to find and fix it.

Agreed.

If we find that older Linux or some version of Windows works better
than the latest Linux, then we have something we need to fix.

If they all fail, then this laptop's hardware issues do not justify
the existence of the p4-clockmod driver in the kernel...

Len Brown, Intel Open Source Technology Center
