From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 8)
Date: Sun, 13 Apr 2008 21:47:02 -0700
Message-ID: <200804132147.03579.david-b@pacbell.net>
References: <200804040111.15255.rjw@sisk.pl> <200804140027.12161.rjw@sisk.pl> <1208126822.6958.63.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:34606 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751218AbYDNErH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 00:47:07 -0400
In-Reply-To: <1208126822.6958.63.camel@pasglop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: benh@kernel.crashing.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

On Sunday 13 April 2008, Benjamin Herrenschmidt wrote:
> I think we should get it right now. There's no hurry in pushing things
> especially if they aren't quite right.

There is Rafael's patience to remember... (rev 8?)


> The ability for prepare() callbacks to sync with userland,
> request_firmware, etc... is an important feature that's been needed for
> some time imho.

I sort of agree.  Looking at it from a whole-system perspective,
suspending needs to be able to chitchat with userspace ... and I
don't think that can be done *before* writing to /sys/power/state
in an acceptably generic/portable way.  (Briefly, applications
need to have clean stopping points and be able to arrange system
wakeup.  They may well have more work to do than most drivers.)

But also, not all of that chitchat would naturally be associated
with any particular device(s).  So it's not clear to me that a
prepare() is what should oversee that... or that we've had real
discussion (yet) about the requirements there.


Rafael wrote:

> It looks like you'd like to have a third callback executed before the
> freezer, but OTOH I don't see the reason not to use a notifier for such
> things.

Neither of those is actually a userspace notification/handshake.

- Dave
