From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
	suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 18:45:04 -0800
Message-ID: <20091220024503.GD4073@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912200040.18944.rjw@sisk.pl> <alpine.LFD.2.00.0912191542570.3712@localhost.localdomain> <200912200053.45988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:51674 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931AbZLTCpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Dec 2009 21:45:09 -0500
Content-Disposition: inline
In-Reply-To: <200912200053.45988.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, Dec 20, 2009 at 12:53:45AM +0100, Rafael J. Wysocki wrote:
> On Sunday 20 December 2009, Linus Torvalds wrote:
> > 
> > If it isn't, don't do that then. But we actually have no real 
> > reason to believe that it would be problematic, at least on a PC where the 
> > actual logic is on the SB (presumably behind the LPC controller).
> > 
> > Why would it be?
> 
> The embedded controller may depend on it.
>

No, not really depend but rather wierd things may happen if you
accessing both. Witness regressions where touching embedded controller
makes us lose data from touchpad, I think you are CCed on that bug.

-- 
Dmitry
