From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI suspend/hibernate tests (was: ACPI power off regression in 2.6.23-rc8)
Date: Wed, 26 Sep 2007 00:18:00 +0200
Message-ID: <200709260018.01441.rjw@sisk.pl>
References: <20070925065109.GA3080@localhost.localdomain> <200709251800.13272.rjw@sisk.pl> <200709252344.02894.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36530 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbXIYWEC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2007 18:04:02 -0400
In-Reply-To: <200709252344.02894.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Damien Wyart <damien.wyart@free.fr>, Len Brown <len.brown@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org

On Tuesday, 25 September 2007 23:44, Frans Pop wrote:
> On Tuesday 25 September 2007, Rafael J. Wysocki wrote:
> > On Tuesday, 25 September 2007 17:40, Linus Torvalds wrote:
> > > Len - why are you guys moving stuff into CONFIG_PM_SLEEP? I know you
> > > seem to think that absolutely *everybody* should always support suspend
> > > and hibernation, but the fact is, not everybody does. And it's a
> > > totally separate thing for normal ACPI CPU runstate support that people
> > > have used to manage a *running* CPU (and shutting it down).
> >
> > This was a mistake and fixes have already been posted:
> >
> > http://marc.info/?l=linux-acpi&m=119052970904643&w=4
> > http://marc.info/?l=linux-acpi&m=119073173625910&w=4
> 
> As this whole "separate suspend and hibernate" change seems to have been 
> trickier than expected, I have done some additional testing using 
> 2.6.23-rc8 plus both patches referred to above.
> 
> I compiled kernels (i386) for my laptop (Toshiba Satellite A40) with:
> A) PM + SUSPEND + HIBERNATION + ACPI
> B) PM + SUSPEND + ACPI
> C) PM + HIBERNATION + ACPI
> D) PM + ACPI
> E) PM + SUSPEND + HIBERNATION but _without_ ACPI
> F) without PM

Thanks a lot for testing this!
 
> In all cases CONFIG_APM was not set; all compiled without errors.
> 
> With all I have have booted, tried to suspend (close lid, which runs sleep 
> script, which does 'echo mem >/sys/power/state'), tried to hibernate ('echo 
> disk >/sys/power/state') and powered off (all from KDE sessions).
> 
> RESULTS
> 	boot	s2ram	s2disk	off
> A)	OK	OK	OK	OK
> B)	OK	OK	N/A	OK
> C)	OK	OK 1)	OK	OK
> D)	OK 2)	OK 1)	N/A	OK
> E)	OK 3)	N/A 4)	??? 5)	Only halted 6)
> F)	OK	N/A	N/A	Only halted 6)
> 
> Comments:
> 1) sleep script ran, but laptop stayed on
> 2) dmesg lists S0,S5 supported
>    /proc/acpi/{sleep,wakeup} do not exist (is that correct?)
> 3) /proc/acpi/{sleep,wakeup} do not exist; /sys/power/state only has 'mem'

Hm, this should be 'disk' ...

>    so SUSPEND seems missing even though compiled in

... but it so follows from this comment.  Can you clarify, please?

> 4) sleep script did not even run (as expected)
> 5) System did suspend, but power stayed on with on console:
>      Shutdown: hda \ Power down. \ Shutdown: hda \ hda: lost interrupt (2x)
>      \ psmouse.c: Failed to deactivate mouse on isa0060/serio1
>    System powered off manually and resumed correctly after that
> 6) System halted correctly, but did not power off automatically
> 
> The results for E and F are possibly correct as basically the config 
> (without ACPI) was broken for this laptop. In fact, I was somewhat 
> surprised how well it behaved without ACPI.
> 
> I suspect that whether a system powers off without ACPI or not can depend on 
> the system?
> 
> I have dmesg after boot and some other info available for all kernels if 
> anybody is interested. If any additional tests are wanted, please ask.

I think that your results reflect the code pretty well, ie. no big surprises.

On ACPI machines suspend doesn't actually work without ACPI and that's why
'mem' is missing from kernel/power/state with E).  Hibernation theoretically
works without ACPI, but the box cannot be powered off due to the lack of
support for that.

For the same reason, the system doesn't power off with E), F).

The errors from device drivers in the last phase of hibernation with E) may be
related to some confusion cause by the lack of ACPI methods expected to be
present.

Greetings,
Rafael
