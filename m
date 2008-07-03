From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] ACPI: compal-laptop: use rfkill switch subsystem
Date: Thu, 3 Jul 2008 09:52:06 -0300
Message-ID: <20080703125206.GD17823@khazad-dum.debian.net>
References: <20080702214524.2ba4a001@debian> <20080703021433.GC20410@khazad-dum.debian.net> <20080703064818.35ee2532@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47768 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752790AbYGCMwL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 08:52:11 -0400
Content-Disposition: inline
In-Reply-To: <20080703064818.35ee2532@debian>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Cc: ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, 03 Jul 2008, Cezary Jackiewicz wrote:
> Dnia 2008-07-02, o godz. 23:14:33
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> napisa?(a):
> 
> [...]
> > That doesn't look like a new-style (i.e. what is in net-next-2.6) rfkill
> > support.  Could you take a look on the new (and I sure hope, vastly
> > improved) Documentation/rfkill.txt in net-next-2.6, and switch the driver to
> > RFKILL_STATE_UNBLOCKED, RFKILL_STATE_SOFT_BLOCKED, etc?  After a quick look,
> > it looks like Compal won't need RFKILL_STATE_HARD_BLOCKED  (thinkpad-acpi
> > does, because some thinkpads have a master wireless kill switch), but
> > still...
> 
> Compal has hardware wireless kill switch (without software it kill all radios
> rf and disconnecting bluetooth from usb bus). Does he should generate
> SW_RFKILL_ALL or something like this?

Look at the thinkpad-acpi code.  I don't know for sure if Compal's
firmware/hardware acts like the thinkpad one, but if it does, you will find
your answer on thinkpad-acpi since what you describe is pretty much what a
thinkpad does.

So, yes, usually master wireless switches like what you describe for Compal
are input devices (see the new rfkill docs), and issue SW_RFKILL_ALL events.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
