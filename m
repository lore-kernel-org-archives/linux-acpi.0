From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 9 May 2007 15:12:12 +0200
Message-ID: <200705091512.13171.rjw@sisk.pl>
References: <20070430102837.748238000@linutronix.de> <200705091345.55207.rjw@sisk.pl> <1178713442.3042.480.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49411 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939AbXEINHa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 09:07:30 -0400
In-Reply-To: <1178713442.3042.480.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wednesday, 9 May 2007 14:24, Thomas Gleixner wrote:
> On Wed, 2007-05-09 at 13:45 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, 9 May 2007 10:59, Thomas Gleixner wrote:
> > > On Wed, 2007-05-09 at 01:31 -0700, Andrew Morton wrote:
> > > > > I suspect I just tested the wrong thing yesterday.  Let me recheck just
> > > > > these patches against 2.6.21.
> > > > 
> > > > yup, same hang with just these three:
> > > > 
> > > > origin
> > > > clocksource-fix-resume-logic
> > > > clockevents-fix-resume-logic-updated-version
> > > 
> > > I have no idea, how this affects acpi_evaluate_object()
> > 
> > I think the problem is that the ACPI code ordering here is broken in a
> > difficult to fix way.
> 
> Any explanation aside of witchcraft why this is affected by the clock
> event resume changes ?

Well, where is unregister_time_interpolator() called from?

Rafael
