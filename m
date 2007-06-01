From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Sat, 2 Jun 2007 00:37:16 +0200
Message-ID: <200706020037.16615.rjw@sisk.pl>
References: <878xb35sje.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl> <87hcpr2ubl.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57922 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbXFAWbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jun 2007 18:31:35 -0400
In-Reply-To: <87hcpr2ubl.fsf@goat.bogus.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Saturday, 2 June 2007 00:17, Olaf Dietsche wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Friday, 1 June 2007 23:12, Olaf Dietsche wrote:
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >> > On Friday, 1 June 2007 22:27, Olaf Dietsche wrote:
> >> >> When I resume, everything seems to come up (fan becomes busy, disk and
> >> >> dvd spin up for a short time),
> >> >
> >> > Hmm, what about the screen?
> >> 
> >> When the laptop is dead, screen remains black.
> >> 
> >> When I skip acpi_enter_sleep_state(), the screen works like everything
> >> else.
> >
> > I think you should try s2ram (http://en.opensuse.org/s2ram) as the first step.
> 
> It doesn't work. I tried all options "s2ram -f (-s, -p, -m, -r, -a 1, -a 2,
> -a 3)" one after the other.
> 
> Since the screen (or any other device) works without problems, when I
> skip acpi_enter_sleep_state(), I don't think it's screen related.

No, it might be, actually.  If you skip acpi_enter_sleep_state(), your machine
doesn't really suspend, so in fact you only confirm that your drivers implement
.suspend() and .resume() hooks correctly.

First, you can check if the patch

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/20-ACPI-preserve-the-ebx-value-in-acpi_copy_wakeup_routine.patch

helps, by chance.

Second, you can use PM_TRACE (Documentation/power/s2ram.txt) to find the
place where it really fails.

Also, please read Documentation/power/basic-pm-debugging.txt .

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
