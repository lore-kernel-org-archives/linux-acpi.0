From: Len Brown <lenb@kernel.org>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Thu, 19 Jun 2008 15:02:12 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:44899 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYFSTCS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jun 2008 15:02:18 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2Q00E4K4VR0QM0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 19 Jun 2008 14:02:16 -0500 (CDT)
In-reply-to: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Trull <linmodemstudent@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>



On Sat, 31 May 2008, Jeff Trull wrote:

> I made a breakthrough in my s2r debugging last night when I realized
> that the sooner I pressed the power button after suspend, the more
> life the system exhibited post-resume.  In fact when I attempted to
> resume immediately after entering suspend, my system had a successful
> resume from memory for the first time ever.  Therefore, I have a new
> hypothesis: DRAM self-refresh mode is not being properly entered.
> 
> I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
> and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
> recompiling the kernel.  Any suggestions as to how to proceed,
> experiments to run, etc.?

Start by running the upstrteam kernel -- now 2.6.26, just out of 
principle.

Then, see Documentation/power/basic-pm-debugging.txt

and try the options in /sys/power/pm_test

If the cause is as you suspect, they should all work.
If any of them fail, then there is a problem elsewhere.

eg. the deepest test is core:

# echo core > /sys/power/pm_test
# echo mem > /sys/power/state

should work, because it does everything except actually leap into
the BIOS to enter self-refresh.

# echo none > /sys/power/pm_test

then disalbes this test mode.

-Len



