From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: wake-on-lan
Date: Fri, 20 Jan 2006 07:50:45 +0100
Message-ID: <20060120065045.GC30662@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CECE@hdsmsx401.amr.corp.intel.com> <20060120051635.GA30662@hell.org.pl> <20060120063637.GC27435@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:13572 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1161253AbWATGus (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 01:50:48 -0500
Content-Disposition: inline
In-Reply-To: <20060120063637.GC27435@neo.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: "Brown, Len" <len.brown@intel.com>, Joseph Dunn <jdunn14@hotpop.com>, linux-acpi@vger.kernel.org

Thus wrote Adam Belay:
> > Note also that there are very few explicit calls to pci_enable_wake() in
> > the whole tree. Linux doesn't set the PME-Enable bit properly, which
> > apparently results in WOL either working or not working. My understanding
> > is that the final outcome depends on what BIOS does to the card during
> > POST. Please see http://bugme.osdl.org/show_bug.cgi?id=3801 for a weird 
> > example.
> I'm in the process of overhauling the PCI layer's power management event
> support.  Basically, I'd like to catch ACPI GPE events and then walk the
> device tree in thier corresponding location to see if PME is set.  If so

Ouch. Registering a notify handler against the device's node is not enough?
AFAIR, the spec requires devices that triggered wake-up to be notified and
most DSDTs I've seen do it in one way or another (usually through _WAK).

> a function like ->wake() will be called for the device driver that owns
> the triggered device.  This should allow for even runtime PME usage.  I'm
> expecting to have a patch available for the PCI end of these changes soon.

What point is calling this when we're already up?

Obviously, I haven't seen the whole picture, but from what I know we
already have a .enable_wake callback that is ignored by both the core code
and the drivers. Perhaps extending this callback with platform hooks to
enable the corresponding GPE (die, /proc/acpi/wakeup, die!) and making sure
it actually is called would suffice?

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
