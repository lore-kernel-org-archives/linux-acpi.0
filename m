From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sat, 18 Apr 2009 15:59:18 +0200
Message-ID: <200904181559.19485.rjw@sisk.pl>
References: <20090417231009.GB6900@flint.arm.linux.org.uk> <200904181523.36010.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44845 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbZDRN7s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Apr 2009 09:59:48 -0400
In-Reply-To: <200904181523.36010.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday 18 April 2009, Rafael J. Wysocki wrote:
> On Saturday 18 April 2009, Russell King wrote:
> > Some platforms need to talk via I2C to power control devices during
> > the suspend method.  Currently, they do this via the platform PM ops
> > prepare callback, relying on the I2C driver being hooked into the
> > 'late' suspend method, and hence being shut down _after_ the prepare
> > callback.
> 
> Well, I was not aware of this dependency and it seems quite unusual for a
> platform to depend on a driver like this.
> 
> > However, as of the above commit, the ordering is changed such that
> > platforms don't get notified of suspends until after all devices are
> > well and truely shut down.
> > 
> > This can't work, and actively breaks some platforms.
> 
> Sorry for that.
> 
> The patchset in question had been discussed quite extensively before it was
> merged and it's a pity none of the people caring for the affected platforms
> took part in those discussions.  That would allow us to avoid the breakage.
>  
> > Please come up with another solution for your PCI problems,
> 
> I don't think this is possible, sorry.
> 
> > or provide alternative equivalent functionality where the platform code is
> > notified of the PM event prior to the late suspend callback being issued.
> 
> There is the .begin() callback that could be used, but if you need the
> platform to be notified _just_ prior to the late suspend callback, then the
> only thing I can think of at the moment is the appended patch.
> 
> It shouldn't break anything in theory, because the majority of drivers put
> their devices into low power states in the "regular" suspend callbacks anyway.

Still, if it turns out to break anything, we'll have to think of an alternative
approach.

Which platforms exactly are affected?

Rafael
