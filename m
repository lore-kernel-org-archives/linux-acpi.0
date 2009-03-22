From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Paravirtualizing bits of acpi access
Date: Sun, 22 Mar 2009 19:00:23 +0100
Message-ID: <200903221900.23762.rjw@sisk.pl>
References: <49C484B7.20100@goop.org> <200903221228.40181.rjw@sisk.pl> <49C67054.7020603@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54146 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbZCVSAJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Mar 2009 14:00:09 -0400
In-Reply-To: <49C67054.7020603@goop.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>

On Sunday 22 March 2009, Jeremy Fitzhardinge wrote:
> Rafael J. Wysocki wrote:
> > On Sunday 22 March 2009, Jeremy Fitzhardinge wrote:
> >   
> >> Rafael J. Wysocki wrote:
> >>     
> >>> Well, why don't you implement the platform suspend operations for Xen?
> >>> I guess you don't want ACPI _PTS to be executed during suspend as well.
> >>>   
> >>>       
> >> I don't know.  What's _PTS?
> >>     
> >
> > It's an ACPI method called to prepare the platform to enter the sleep state
> > (the name stands for "prepare to sleep").  Executing it may affect the
> > hardware.
> >   
> 
> OK, that's what we want.  Dom0 is the control domain which is 
> responsible for the bulk of the hardware; Xen itself has very little 
> hardware knowledge.
> 
> > I think you really should not execute any global ACPI methods to suspend a
> > guest, because that may affect the host.  That's why I think it's better to
> > regard Xen as a platform and implement a separate set of suspend operations for
> > it.
> >   
> 
> In this case we're talking about the special privileged domain which can 
> be considered to be on the "host" side of the line. 
> 
> That said, I'd be interested in looking at a suspend operations-based 
> approach if you think its the right way to go.  But I'm concerned that 
> we'd end up with a big set of very similar-looking parallel functions 
> just to deal with some difference in detail near the bottom.  Can you 
> give me a pointer to where this gets put together for acpi?

Please have a look at include/linux/suspend.h for the prototypes and
drivers/acpi/sleep.c contains the ACPI implementation.

Thanks,
Rafael
