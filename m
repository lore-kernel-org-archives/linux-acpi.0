From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Fri, 11 Dec 2009 15:53:14 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912111552330.3526@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912112311.08548.rjw@sisk.pl> <alpine.LFD.2.00.0912111415160.3922@localhost.localdomain> <200912120048.46180.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37389 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934014AbZLKXxo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2009 18:53:44 -0500
In-Reply-To: <200912120048.46180.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:
> 
> Below is a patch I've just tested, but there's a lockdep problem in it I don't
> know how to solve.  Namely, lockdep is apparently unhappy with us not releasing
> the lock taken in device_suspend() and it complains we take it twice in a row
> (which we do, but for another device).  I need to use down_read_non_owner()
> to make it shut up and then I also need to use up_read_non_owner() in
> __device_suspend(),

Ok, that I admit is actually a problem.

Ok, ok, I'll accept that completion() version, even though I think it's 
inferior.

		Linus
