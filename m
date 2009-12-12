From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Fri, 11 Dec 2009 19:43:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912111938310.32493-100000@netrider.rowland.org>
References: <200912120048.46180.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36467 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762361AbZLLAmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 19:42:54 -0500
In-Reply-To: <200912120048.46180.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:

> Below is a patch I've just tested, but there's a lockdep problem in it I don't
> know how to solve.  Namely, lockdep is apparently unhappy with us not releasing
> the lock taken in device_suspend() and it complains we take it twice in a row
> (which we do, but for another device).  I need to use down_read_non_owner()
> to make it shut up and then I also need to use up_read_non_owner() in
> __device_suspend(), although there's the comment in include/linux/rwsem.h
> saying exatly this about that:
> 
> /*
>  * Take/release a lock when not the owner will release it.
>  *
>  * [ This API should be avoided as much as possible - the
>  *   proper abstraction for this case is completions. ]
>  */
> 
> (I'd like to know your opinion about that).  Yet, that's not all, because next
> it complains during resume that __device_resume() releases a lock it didn't
> acquire, which it clearly does, but that is intentional.  Unfortunately,
> there's no up_write_non_owner() ...

Hah!  I knew it!

How come lockdep didn't complain earlier?  What's different about this 
patch?  Only the nesting annotations?  Why should adding annotations 
make lockdep less happy?

Alan Stern

