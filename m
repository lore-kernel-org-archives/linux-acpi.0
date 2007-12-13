From: Akkana Peck <akkana@shallowsky.com>
Subject: Re: [Bugme-new] [Bug 9555] New: Suspend to RAM horks keyboard autorepeat, system bell, trackpad
Date: Wed, 12 Dec 2007 22:45:32 -0800
Message-ID: <20071213064532.GA7618@shallowsky.com>
References: <bug-9555-10286@http.bugzilla.kernel.org/> <20071212183349.f81464bf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adsl-69-105-235-1.dsl.pltn13.pacbell.net ([69.105.235.1]:55813
	"EHLO moon.timocharis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764132AbXLMHPc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Dec 2007 02:15:32 -0500
Content-Disposition: inline
In-Reply-To: <20071212183349.f81464bf.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@kernel.org, bugme-daemon@bugzilla.kernel.org, Dmitry Torokhov <dtor@mail.ru>, linux-acpi@vger.kernel.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>

[Replying again with all CCs]

Andrew Morton writes:
> > http://bugzilla.kernel.org/show_bug.cgi?id=9555
> > 
> >            Summary: Suspend to RAM horks keyboard autorepeat, system bell,
> >                     trackpad
[ ... ]
> > With 2.6.23.8, when I suspend to RAM (using /usr/sbin/hibernate -F
> > /etc/hibernate/ram.conf) from within X, when I resume I see the
> > following odd behavior:
> > 
> > 1. The system bell is now half a second long.
> > 2. Keyboard autorepeat has a very long delay -- like 7 seconds before the first
> > repeated character shows up.
> > 3. If I configure X to use the (Alps) trackpad via the synaptics  driver, after
> > resuming, clicks from the trackpad don't work at all -- not only are taps
> > ignored (which is how I've configured xorg.conf) but the physical buttons don't
> > generate click events either. If I configure X to use the trackpad just as a
> > PS/2 mouse, though, it still works normally after resuming.
[ ... ]
> 
> A regression in the -stable series.
> 
> IT'd be interesting to see if this has gone into 2.6.24-rc5 too.

The problem seems fixed in 2.6.24-rc5 (and I'd like to apologize for
wasting everyone's time by not checking for a new version first).
So the bug appeared in the patches that took 2.6.23.1 to 2.6.23.8, and
was fixed by something between .23.8 and .24-rc5.

I'm fine with closing the bug since it's working fine in .24-rc5,
but if anyone is curious what the problem was, I'm happy to help
with tracking it down. It's very easily reproducible on this machine.
