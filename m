From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 10:55:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912151047410.3566-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912150722310.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37068 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754393AbZLOPzy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2009 10:55:54 -0500
In-Reply-To: <alpine.LFD.2.00.0912150722310.14385@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 15 Dec 2009, Linus Torvalds wrote:

> My whole point was that by doing the whole "wait for children" in generic 
> code, you also made devices - such as PCI bridges - have to wait for 
> children, even though they don't need to, and don't want to.
> 
> So I suggested an admittedly ugly hack to take care of it - rather than 
> some complex infrastructure.

It doesn't feel like an ugly hack to me.  It seems like exactly the 
Right Thing To Do: Make as many devices as possible use async 
suspend/resume.

The only reason we don't make every device async is because we don't
know whether it's safe.  In the case of PCI bridges we _do_ know --
because they don't have any work to do outside of
late_suspend/early_resume -- and so they _should_ be async.

The same goes for devices that don't have suspend or resume methods.

There remains a separate question: Should async devices also be forced
to wait for their children?  I don't see why not.  For PCI bridges it
won't make any significant difference.  As long as the async code
doesn't have to do anything, who cares when it runs?

Alan Stern

