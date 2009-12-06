From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 17:04:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912061700420.9883-100000@netrider.rowland.org>
References: <20091206135711.34338809@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:37029 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934295AbZLFWEl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2009 17:04:41 -0500
In-Reply-To: <20091206135711.34338809@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, 6 Dec 2009, Arjan van de Ven wrote:

> having spent 30 minutes trying to grok this code, I think there may be
> a trick in using the async function call infrastructure.
> 
> if each USB hub's resume (hub_resume()) would be done as an async
> function call, that would start allowing the hub resumes to go async,
> but this is not enough.
> 
> usb_resume_both() would also then need to be an async call itself, and
> do its "resume the parent" recursion as a async function call, and then
> it needs to do a synchronization before actually resuming the device
> itself (provided it is not a hub or hub like device I suppose).
> 
> the later synchronization guarantees that no device will be resumed
> before it's parent tree structure is resumed, while allowing parallel
> parts of the tree to be resumed in parallel.
> 
> The hard part in this is the locking.... that is getting non-trivial
> once you have multiple asynchronous functions executing.

That's the whole point of Rafael's async suspend/resume framework.  He 
has done the hard work already.

Alan Stern

