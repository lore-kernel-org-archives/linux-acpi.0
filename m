From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sun, 19 Apr 2009 00:44:57 +0200
Message-ID: <200904190044.58444.rjw@sisk.pl>
References: <20090417231009.GB6900@flint.arm.linux.org.uk> <20090418135323.GA7148@flint.arm.linux.org.uk> <alpine.LFD.2.00.0904181205010.4042@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45785 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733AbZDRWpa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Apr 2009 18:45:30 -0400
In-Reply-To: <alpine.LFD.2.00.0904181205010.4042@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday 18 April 2009, Linus Torvalds wrote:
> 
> On Sat, 18 Apr 2009, Russell King wrote:
> > 
> > What I need to be able to do is to suspend most devices on the host side
> > which may involve talking to a separate microcontroller via I2C to shut
> > down power to peripherals.
> 
> I suspect that for cases like this, the simplest thing to do is to just 
> add a marker for "don't mess with my power management, I'm doing 
> everything through sysdev" for the specified devices.

In this particular case, if sysdev was used, there would be no problem, but the
platform uses a platform device to suspend-resume the i2c controller.
In principle we could convert it to use a sysdev, but that would be more
difficult than the last patch I sent IMO (at least to me).

Also, apparently it is not the only platform doing it.

> Then those i2c controllers (and perhaps some PCI bridges etc) can just set 
> that bit, and the device would basically turn invisible as far as the PM 
> layer is concerned.
> 
> Not that different from the IRQF_TIMER bit for timer interrupts.

I generally agree and a patch to implemet such a flag has been submitted
recently.

Thanks,
Rafael
