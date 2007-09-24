From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/7] ACPI: thinkpad-acpi: dequeue all pending hot key events at once
Date: Sun, 23 Sep 2007 22:33:09 -0400
Message-ID: <200709232233.10049.lenb@kernel.org>
References: <11902962603691-git-send-email-hmh@hmh.eng.br> <200709202042.22724.lenb@kernel.org> <20070921135340.GA11125@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60133 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755061AbXIXCoH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 22:44:07 -0400
In-Reply-To: <20070921135340.GA11125@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Friday 21 September 2007 09:53, Henrique de Moraes Holschuh wrote:
> On Thu, 20 Sep 2007, Len Brown wrote:
> > On Thursday 20 September 2007 09:50, Henrique de Moraes Holschuh wrote:
> > > Receive all pending hot key events at once from a single notification, and
> > > don't complain if the queue is empty.
> 
> Maybe I should have s/hot.?key/HKEY/ throughout this patch.
> 
> The HKEY handler is the thinkpad-specific handler to message-pass
> interesting events to the O.S. This include hot key pressing, but also
> inclures: LID open/close, radio switch toggling, what looks like thermal
> alarms, reason for wakeup (bay eject, whatever), notification of impending
> undock (to show a helper to the user explaining how to undock a x40/x60,
> etc)... and only IBM and Lenovo knows what else.  Hot key presses are just
> one of the many things reported through thinkpad HKEY events.
> 
> > If this is really an event due to an hotkey (emphasis on the word KEY:-),
> > why is it being sent via netlink instead of via input?
> 
> Like I said, if it hit that branch, it is some other notification than a hot
> key press :-)  Yeah, it is non-obvious.
> 
> I will rework the patch to use the word HKEY event instead of hotkey event
> where applicable.

Thanks for the clarification, Henrique.
