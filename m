From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Mon, 14 Dec 2009 14:43:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912141442180.26135@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912122334.08367.rjw@sisk.pl> <alpine.LFD.2.00.0912141015240.26135@localhost.localdomain> <200912142311.31658.rjw@sisk.pl>
 <alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46847 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757947AbZLNWnk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2009 17:43:40 -0500
In-Reply-To: <alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Mon, 14 Dec 2009, Linus Torvalds wrote:
> 
> Here's an untested one-liner that has a 10-line comment.

Btw, when I say "untested", in this case I mean that it isn't even 
compile-tested. I haven't merged your other patches yet, so in my tree 
that 'async_suspend' flag doesn't even exist, and the patch I sent out 
definitely doesn't compile.

But it _might_ compile (and perhaps even work) in your tree.

		Linus
