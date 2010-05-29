From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI patches for 2.6.35-merge
Date: Fri, 28 May 2010 23:40:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005282337210.3942@localhost.localdomain>
References: <alpine.LFD.2.00.1005281641080.4045@localhost.localdomain>
 <201005290036.34495.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:35765 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0E2Dky (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 May 2010 23:40:54 -0400
In-reply-to: <201005290036.34495.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org


> Hmm, it looks like you omitted these two:
> 
> https://patchwork.kernel.org/patch/91560/
> https://patchwork.kernel.org/patch/91558/
> 
> Was that intentional or were they simply forgotten?

I missed those two.
Strange --  I recall discussing them in April,
so don't know why they were not in my test tree since then.

Anyway, they're in acpi-test now, and as it is a bug fix,
with just a small re-name, should be fine for the next push.

thanks,
-Len Brown, Intel Open Source Technology Center


