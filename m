From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Paravirtualizing bits of acpi access
Date: Sun, 22 Mar 2009 14:17:44 +0100
Message-ID: <200903221417.45418.rjw@sisk.pl>
References: <49C484B7.20100@goop.org> <200903221228.40181.rjw@sisk.pl> <20090322131436.GB22848@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53601 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbZCVNRw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Mar 2009 09:17:52 -0400
In-Reply-To: <20090322131436.GB22848@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>

On Sunday 22 March 2009, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Sunday 22 March 2009, Jeremy Fitzhardinge wrote:
> > > Rafael J. Wysocki wrote:
> > > > Well, why don't you implement the platform suspend operations for Xen?
> > > > I guess you don't want ACPI _PTS to be executed during suspend as well.
> > > >   
> > > 
> > > I don't know.  What's _PTS?
> > 
> > It's an ACPI method called to prepare the platform to enter the sleep state
> > (the name stands for "prepare to sleep").  Executing it may affect the
> > hardware.
> > 
> > > I think for the most part we want Linux to do most of the acpi 
> > > work of bringing the machine into an idle state.  Its just that 
> > > Xen is responsible for the very low level cpu context 
> > > save/restore, because the Linux kernel is still running on vcpus 
> > > rather than the physical cpus.
> > 
> > I think you really should not execute any global ACPI methods to 
> > suspend a guest, because that may affect the host.  That's why I 
> > think it's better to regard Xen as a platform and implement a 
> > separate set of suspend operations for it.
> 
> I'd agree with that. That also allows the reuse of existing 
> callbacks, right?

Yes, it does.

Rafael
