From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Fri, 19 Feb 2010 17:37:49 +0100
Message-ID: <201002191737.49957.trenn@suse.de>
References: <1266357351-20224-1-git-send-email-trenn@suse.de> <201002191220.56517.trenn@suse.de> <alpine.LFD.2.00.1002191108590.4030@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53211 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab0BSQhv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Feb 2010 11:37:51 -0500
In-Reply-To: <alpine.LFD.2.00.1002191108590.4030@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Friday 19 February 2010 17:20:51 Len Brown wrote:
> > > What good things happen after this patch that didn't happen before it?
> > 
> > The guy sees a valid temperature, in /proc-/sys and also in the
> > corresponding X-apps (which his original complaints were).
> >
> > The thermal zone has a valid passive trip point (95 C), which now is 
> > active again.
> 
> I understand the 1st patch to not disqualify a TZ if it has
> a bogus _CRT.  That would make a TZ show up rather than
> get discarded.  If that patch compiled cleanly, I'd apply it...
> 
> I don't understand this patch to scan a TZ for trip points
> and print out a kernel warning about a firmware bug
> for TZ's which have none, and disqualify those TZ's.
> That isn't going to make temperature available when it
> was not already available.  That is going to add an additional
> kernel message about a firmware bug we can't fix,
Hmm, Firmware bugs which we can't fix and can't even work around always
should at least end up in a firmware bug/warning message.

> and could actually delete a thermal zone with a working temperature
> that used to be present, no?
Not really. At least not worse than before.
Before my previous patch every thermal zone without a valid critical
trip point was discarded with an error message.
Now you need at least one.

My patch sticks to the spec and only discards the thermal zone if there
is no trip point at all. In this case you want to throw a (firmware bug)
message as something is obviously wrong.

     Thomas
