From: Len Brown <lenb@kernel.org>
Subject: git mv (was Re: [git pull] ACPI & Suspend patches for 2.6.29-rc0)
Date: Fri, 09 Jan 2009 15:56:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091537530.16697@localhost.localdomain>
References: <alpine.LFD.2.00.0901090550590.4091@localhost.localdomain>
 <alpine.LFD.2.00.0901091200150.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37375 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757373AbZAIU5E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 15:57:04 -0500
In-reply-to: <alpine.LFD.2.00.0901091200150.6528@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>


> As usual, git is actually smarter and get things more correct than people 
> realize. What you found "surprising" is actually a "profound truth". 
> 
> Git is like a great indian mystic. It sees past the veil of the trivial, 
> to find the true connections in life.
> 
> Or at least in source code.

Thanks for confirming that the unexpected diff
is a fature of git rather than a bug.

Since I had used "git mv", I had expected everything
to show up as a move.  However, I understand that
comparing file contents over that move and other code moves
told a different 'big picture' story.

I guess using 'git mv' gave me the false expectation
that git actually tracks moves like other SCMs
and it would show up that way in the diff -- though
now that I think about it, I like the comparison
of the two endpoints that git did even better.

I guess you can make an argument either way about
how to handle moves.  One problem that both have to
deal with is that a history on the old (now missing)
file location doesn't work, and that by default
the history on the new location stops unless 
log --follow is used.  gitk doesn't use --follow
by default, and when it is added, the history
looks pretty strange.

thanks,
-Len Brown
Intel Open Source Technology Center


