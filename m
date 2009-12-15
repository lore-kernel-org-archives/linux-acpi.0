From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 07:26:41 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912150722310.14385@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912150018.11837.rjw@sisk.pl> <alpine.LFD.2.00.0912141609020.14385@localhost.localdomain> <200912151203.22916.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58798 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757128AbZLOP1k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 10:27:40 -0500
In-Reply-To: <200912151203.22916.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > Give a real example that matters.
> 
> I'll try.  Let -> denote child-parent relationships and assume dpm_list looks
> like this:

No. 

I mean something real - something like

 - if you run on a non-PC with two USB buses behind non-PCI controllers.

 - device xyz.

> If this applies to _resume_ only, then I agree, but the Arjan's data clearly
> show that serio devices take much more time to suspend than USB.

I mean in general - something where you actually have hard data that some 
device really needs anythign more than my one-liner, and really _needs_ 
some complex infrastructure.

Not "let's imagine a case like xyz".

> But if we only talk about resume, the PCI bridges don't really matter,
> because they are resumed before all devices that depend on them, so they don't
> really need to wait for anyone anyway.

But that's my _point_. That's the whole point of the one-liner patch. Read 
the comment above that one-liner.

My whole point was that by doing the whole "wait for children" in generic 
code, you also made devices - such as PCI bridges - have to wait for 
children, even though they don't need to, and don't want to.

So I suggested an admittedly ugly hack to take care of it - rather than 
some complex infrastructure.

		Linus
