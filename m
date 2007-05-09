From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 9 May 2007 13:45:54 +0200
Message-ID: <200705091345.55207.rjw@sisk.pl>
References: <20070430102837.748238000@linutronix.de> <20070509013119.dbea7233.akpm@linux-foundation.org> <1178701183.3042.469.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48980 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbXEILlN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 07:41:13 -0400
In-Reply-To: <1178701183.3042.469.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wednesday, 9 May 2007 10:59, Thomas Gleixner wrote:
> On Wed, 2007-05-09 at 01:31 -0700, Andrew Morton wrote:
> > > I suspect I just tested the wrong thing yesterday.  Let me recheck just
> > > these patches against 2.6.21.
> > 
> > yup, same hang with just these three:
> > 
> > origin
> > clocksource-fix-resume-logic
> > clockevents-fix-resume-logic-updated-version
> 
> I have no idea, how this affects acpi_evaluate_object()

I think the problem is that the ACPI code ordering here is broken in a
difficult to fix way.

Definitely, we shouldn't execute the _BFS method after creating the image
and most probably _WAK shouldn't be executed here either.  Moreover,
acpi_leave_sleep_state() enables the runtime GPEs, which AFAICS
is equivalent to allowing ACPI to generate SCIs.  I'm not sure if this is a
good idea to do such a thing in this particular place.

Andrew, could you please apply the appended patch and see if that
helps (should apply to -mm2)?

Rafael

---
NOTE: This is not a complete solution, because it removes the enabling of GPEs
from the resume-during-hibernation code path entirely, which probbably is not a
good idea in general.
---
 kernel/power/disk.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.21/kernel/power/disk.c
===================================================================
--- linux-2.6.21.orig/kernel/power/disk.c
+++ linux-2.6.21/kernel/power/disk.c
@@ -131,7 +131,9 @@ int hibernation_snapshot(int platform_mo
 	}
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish(platform_mode);
+	if (!in_suspend || error)
+		platform_finish(platform_mode);
+
 	device_resume();
 	resume_console();
  Finish:
