From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: git mv (was Re: [git pull] ACPI & Suspend patches for
 2.6.29-rc0)
Date: Fri, 09 Jan 2009 13:47:16 -0800
Message-ID: <1231537636.5726.4.camel@brick>
References: <alpine.LFD.2.00.0901090550590.4091@localhost.localdomain>
	 <alpine.LFD.2.00.0901091200150.6528@localhost.localdomain>
	 <alpine.LFD.2.00.0901091537530.16697@localhost.localdomain>
	 <alpine.LFD.2.00.0901091305160.6528@localhost.localdomain>
	 <20090109212757.GA25434@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:28078 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbZAIVrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:47:19 -0500
In-Reply-To: <20090109212757.GA25434@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>

On Fri, 2009-01-09 at 22:27 +0100, Sam Ravnborg wrote:
> What other ways exist so I can see what the heck davem did to
> arch/sparc64/kernel/irq.c then?
> 
> I know he added IRQ stacks - but how did the patch look like?
> I know no other way to find the old history than to do:
> 
>     git log --follow arch/sparc/kernel/irq_64.c
> 
> But this also give me what I want. I'm just curious if there is
> a better way - in the case where you know the old name.

In that specific case you could just do:

gitk -- name1 name2

And that might be closer to what you're looking for.

Harvey



