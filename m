From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch update 2 fix] PM: Introduce core framework for  run-time PM of I/O devices
Date: Mon, 22 Jun 2009 17:39:34 +0200
Message-ID: <200906221739.34920.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org> <aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com> <20090622064915.741154a7@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58784 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbZFVPjY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2009 11:39:24 -0400
In-Reply-To: <20090622064915.741154a7@infradead.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Monday 22 June 2009, Arjan van de Ven wrote:
> On Mon, 22 Jun 2009 16:27:29 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > On Mon, Jun 22, 2009 at 3:43 PM, Arjan van de
> > Ven<arjan@infradead.org> wrote:
> > > On Mon, 22 Jun 2009 15:20:43 +0900
> > > Magnus Damm <magnus.damm@gmail.com> wrote:
> > >
> > >> On Sat, Jun 20, 2009 at 11:30 PM, Alan
> > >> Stern<stern@rowland.harvard.edu> wrote:
> > >> > Some more thoughts...
> > >> >
> > >> > Magnus, you might have some insights here.  It occurred to me
> > >> > that some devices can switch power levels very quickly, and the
> > >> > drivers might therefore want the runtime suspend and resume
> > >> > methods to be called as soon as possible, even in interrupt
> > >> > context.
> > >>
> > >> I'd like to call pm_request_suspend() from interrupt context. I
> > >> don't
> > >
> > > there are some really strong reasons to at least be able to call the
> > > resume function from an interrupt handler.... shared interrupts are
> > > one of them.
> > 
> > I suppose you mean that you need to resume the hardware device before
> > you can check if it has a pending interrupt source? If so then you
> > also mean that suspended hardware devices may generate interrupts, no?
> 
> yes and no. For the shared interrupt case.. no.
> but yes for the hw I have in mind (and on my desk ;-) that can happen
> as well from the device itself.

If that's PCI hardware (I guess it is ;-)), I'm not really sure if this
behavior is compliant with the specification.

Anyway, if the interrupt is not shared and the device can wake up fast enough,
we should be able to handle it.

Best,
Rafael
