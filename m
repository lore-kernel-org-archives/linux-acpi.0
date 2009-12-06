From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 13:57:11 -0800
Message-ID: <20091206135711.34338809@infradead.org>
References: <20091206131702.7d6cdc57@infradead.org>
	<Pine.LNX.4.44L0.0912061636170.9457-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35453 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260AbZLFVzC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2009 16:55:02 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912061636170.9457-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, 6 Dec 2009 16:46:16 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:
h won't help.  Their delays can't be reduced.
> 
> > I do not know how much I'm asking for, but would it be sensible to
> > do a similar thing for hub resume as we did for boot? eg start
> > resuming them all at the same time, so that the mandatory delays of
> > these hubs will overlap ?
> 
> For one thing, there shouldn't be any mandatory delays for non-root
> hubs during resume-from-RAM (although this depends to some extent on
> your system firmware -- and it probably helps to have USB-2.0 hubs
> rather than USB-1.1).
> 
> More importantly, what you're asking is impossible given the way the
> PM core is structured.  The hub-resume routine can't return early
> because then it wouldn't be possible to resume devices plugged into
> that hub.

having spent 30 minutes trying to grok this code, I think there may be
a trick in using the async function call infrastructure.

if each USB hub's resume (hub_resume()) would be done as an async
function call, that would start allowing the hub resumes to go async,
but this is not enough.

usb_resume_both() would also then need to be an async call itself, and
do its "resume the parent" recursion as a async function call, and then
it needs to do a synchronization before actually resuming the device
itself (provided it is not a hub or hub like device I suppose).

the later synchronization guarantees that no device will be resumed
before it's parent tree structure is resumed, while allowing parallel
parts of the tree to be resumed in parallel.

The hard part in this is the locking.... that is getting non-trivial
once you have multiple asynchronous functions executing.

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
