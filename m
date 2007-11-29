From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Suspend-to-ram/disk signal
Date: Thu, 29 Nov 2007 13:16:29 -0200
Message-ID: <20071129151629.GD22587@khazad-dum.debian.net>
References: <474B4B35.6030800@tipisoft.dk> <200711270036.21884.rjw@sisk.pl> <20071128041014.GA18131@khazad-dum.debian.net> <200711290128.22467.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60503 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755414AbXK2PQe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Nov 2007 10:16:34 -0500
Content-Disposition: inline
In-Reply-To: <200711290128.22467.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pascal d'Hermilly <pascal@tipisoft.dk>, linux-acpi@vger.kernel.org

On Thu, 29 Nov 2007, Rafael J. Wysocki wrote:
> > A deskptop suite trying to emulate the ThinkVantage suite in a ThinkPad
> > might want to check that the user woke up the laptop just to eject the bay,
> > and ask him if he wants the box to go back to sleep, and maybe even offer to
> > do so automatically from now on.
> > 
> > The possibilities are endless...
> 
> OTOH, there are applications that need not be notified in any way, so I don't
> think we should uncondtionally send signals to all of them, for example.

IMO, "need not be notified" != "must not be notified".  *If* it doesn't
cause trouble for the vast majority of applications, notifying them all is
better.

> > But it would still be nice if we kicked userspace in the arse to let it know
> > it was sleeping for a while and needs to resync, when we wake up each
> > userspace task.   The kernel makes that information available to kthreads
> > for a damn good reason.  Sounds like a job for a SIGCONT, but I don't know
> > how well would that work.
> 
> It wouldn't work very well, IMHO, unless the tasks in question are prepared to
> get an "out of order" SIGCONT.

It is a actually a bug if anything can't take multiple SIGCONT's in a row,
AFAIK.  Most applications don't pay attention to SIGSTOP and SIGCONT at all
anyway, and let the default handlers take care of it (and those do the right
thing if they receive multiple signals).

> However, sending SIGSTOP to selected tasks before the suspend and then SIGCONT
> after the resume might do the trick.

Or to all userspace tasks that are not part of the "suspend process
interface" (for suspend2 UI) come to think of it, since we ARE going to
freeze them anyway.  I.e. "send SIGSTOP to all but some selected tasks..."
:-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
