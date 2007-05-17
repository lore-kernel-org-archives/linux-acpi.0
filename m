From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Workaround for a PCI restoring bug
Date: Thu, 17 May 2007 23:25:05 +0200
Message-ID: <200705172325.06113.rjw@sisk.pl>
References: <200705161925.53410.rjw@sisk.pl> <CFF307C98FEABE47A452B27C06B85BB6031BCDF6@hdsmsx411.amr.corp.intel.com> <20070517205017.GA3593@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60604 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756323AbXEQVUH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 17:20:07 -0400
In-Reply-To: <20070517205017.GA3593@ics.muni.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org

On Thursday, 17 May 2007 22:50, Lukas Hejtmanek wrote:
> > Yep -- here's the quote from ACPI 3.0b:
> > 
> > OSPM will invoke _GTS, _PTS, _TTS, _WAK, and _BFS in the following
> > order:
> > 1.OSPM decides (through a policy scheme) to place the system into a
> > sleeping state.
> > 2._TTS(Sx) is run, where Sx is the desired sleep state to enter.
> > 3. OSPM notifies all native device drivers of the sleep state transition
> > 4._PTS is run
> > 5.OSPM readies system for the sleep state transition
> > 6._GTS is run
> > 7.OSPM writes the sleep vector and the system enters the specified Sx
> > sleep state.
> > 8.System Wakes up
> > 9._BFS is run
> > 10.OSPM readies system for the return from the sleep state transition
> > 11._WAK is run
> > 12. OSPM notifies all native device drivers of the return from the sleep
> > state transition
> > 13._TTS(0) is run to indicate the return to the S0 state.
> > 
> > Technically we write the sleep vector too early as well.
> > And we don't evaluate _TTS at all -- though _TTS was
> > added only as of ACPI 3.0 and I've not seen it implemented on
> > any of the systems I've got.
> 
> However, we still do something wrong with ACPI and suspend-to-ram because my
> system is unable to reboot after resume from ram. The only way to reboot is to
> disable the ACPI in the machine_emergency_restart(). (in particular, keyboard
> LEDs flash as the reset has been issued but the BIOS logo does not appear.)

Can you please send me your DSDT?

Rafael
