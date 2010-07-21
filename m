From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 16387] New: system freezes when dvd starts to spin for playback
Date: Wed, 21 Jul 2010 23:43:34 +0200
Message-ID: <201007212343.34643.rjw@sisk.pl>
References: <bug-16387-10286@https.bugzilla.kernel.org/> <20100721140408.44f97af4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45753 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756832Ab0GUVp3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jul 2010 17:45:29 -0400
In-Reply-To: <20100721140408.44f97af4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@kernel.org, Greg KH <gregkh@suse.de>

On Wednesday, July 21, 2010, Andrew Morton wrote:
> On Wed, 14 Jul 2010 12:18:31 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=16387
> > 
> >            Summary: system freezes when dvd starts to spin for playback
> >            Product: IO/Storage
> >            Version: 2.5
> >     Kernel Version: 2.6.35-rc5
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Other
> >         AssignedTo: io_other@kernel-bugs.osdl.org
> >         ReportedBy: mehmet@giritli.eu
> >         Regression: No
> > 
> > 
> > In 2.6.35 rcs, I get frequent freezes of my computer when I put a DVD (its a DL
> > DVD-Video, if matters) in for playback. I do not know how to get any data out
> > of the computer in this situation, nothing works (not even the caps lock). So I
> > turn it off and restart to use it again.
> > 
> > 2.6.33 kernels do not have this problem and I have not tried .34 yet as those
> > kernels have a nasty acpi bug on my computer
> > (https://bugzilla.kernel.org/show_bug.cgi?id=16040).
> > 
> > Could someone instruct me how to debug this please?
> 
> Len, the patches in https://bugzilla.kernel.org/show_bug.cgi?id=16040
> don't appear to have made it into 2.6.34.1, even though they were
> written a month earlier.  This 2.6.34 regression is preventing at least
> one tester from testing 2.6.34.x kernels for a different regression.
> 
> Did we forget to backport those fixes into -stable?

No, we didn't.  I sent -stable requests to stable & Greg several days ago.

Rafael
