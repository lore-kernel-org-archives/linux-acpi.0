From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 15:05:09 +0200
Message-ID: <20090608130509.GA3272@elte.hu>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <200906072347.00580.rjw@sisk.pl> <20090608065419.GA13568@elte.hu> <200906081330.50045.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57697 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbZFHNFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 09:05:21 -0400
Content-Disposition: inline
In-Reply-To: <200906081330.50045.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Monday 08 June 2009, Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > +config PM_RUNTIME
> > > +	bool "Run-time PM core functionality"
> > > +	depends on PM
> > > +	---help---
> > > +	  Enable functionality allowing I/O devices to be put into energy-saving
> > > +	  (low power) states at run time (or autosuspended) after a specified
> > > +	  period of inactivity and woken up in response to a hardware-generated
> > > +	  wake-up event or a driver's request.
> > > +
> > > +	  Hardware support is generally required for this functionality to work
> > > +	  and the bus type drivers of the buses the devices are on are
> > > +	  responsibile for the actual handling of the autosuspend requests and
> > > +	  wake-up events.
> > 
> > Halleluya! :-)
> 
> I guess this means you like the general idea. ;-)
> 
> Well, we've been discussing it for quite a while and since more 
> and more people are interested, I'm giving it a high priority.

Cool. I think that if within a few years we could achieve that every 
default distro (both on desktops and on servers) triggers PM 
functionality runtime on common hardware, we'd both have lower power 
consumption in general, and we'd have more robust suspend-resume 
code as well.

It would also be far more debuggable if the various suspend/resume 
bits were triggered and used independently and runtime, allowing 
bugs to be 'spread out'. Right now if they fail they fail in a very 
hard to debug spot (in the s2ram/s2disk codepaths), which makes 
their hacking rather challenging. (which i'm sure you are well aware 
of ;-)

So yes, i like the idea, a lot.

	Ingo
