From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 9 May 2007 22:53:49 +0200
Message-ID: <200705092253.49896.rjw@sisk.pl>
References: <20070430102837.748238000@linutronix.de> <200705092036.20953.rjw@sisk.pl> <1178743550.3042.541.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51127 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755081AbXEIUtQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 16:49:16 -0400
In-Reply-To: <1178743550.3042.541.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wednesday, 9 May 2007 22:45, Thomas Gleixner wrote:
> On Wed, 2007-05-09 at 20:36 +0200, Rafael J. Wysocki wrote:
> > Well, apparently, not in -mm2:
> > 
> > rafael@albercik:~/src/mm/linux-2.6.21-mm2> grep -r -I -l 'timekeeping_resume' *
> > kernel/time/timekeeping.c
> > rafael@albercik:~/src/mm/linux-2.6.21-mm2> grep clocksource_resume kernel/time/timekeeping.c
> > rafael@albercik:~/src/mm/linux-2.6.21-mm2>
> 
> Andrew dropped the patch because it did not work on his jinxed VAIO, but
> he debugged with the patch applied.

I see.

In that case, since timekeeping_resume() is called via sysdev_resume, then it's
executed before acpi_leave_sleep_state() and may very well interfere with the
ACPI methods executed from there, depending on what's happening in the
cs->resume() callbacks in clocksource_resume().

Greetings,
Rafael
