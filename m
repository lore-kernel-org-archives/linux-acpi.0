From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 10072] New: WARNING: at arch/x86/mm/ioremap.c:137 __ioremap+0x1d5/0x1f0() during bootup
Date: Tue, 26 Feb 2008 01:19:29 +0100
Message-ID: <200802260119.30112.rjw@sisk.pl>
References: <bug-10072-10286@http.bugzilla.kernel.org/> <20080225160047.6e4dd6bc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33231 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758480AbYBZAUp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 19:20:45 -0500
In-Reply-To: <20080225160047.6e4dd6bc.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: plamen.petrov@tk.ru.acad.bg, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, 26 of February 2008, Andrew Morton wrote:
> On Sat, 23 Feb 2008 09:09:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=10072
> > 
> >            Summary: WARNING: at arch/x86/mm/ioremap.c:137
> >                     __ioremap+0x1d5/0x1f0() during bootup
> >            Product: Memory Management
> >            Version: 2.5
> >      KernelVersion: 2.6.25-rc2-00496-g39273b5
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: low
> >           Priority: P1
> >          Component: Other
> >         AssignedTo: akpm@osdl.org
> >         ReportedBy: plamen.petrov@tk.ru.acad.bg
> > 
> > 
> > Latest working kernel version:
> > Earliest failing kernel version:
> > Distribution: Slackware 12
> > Hardware Environment: AMD Duron 850MHz CPU, 512 MB RAM
> > Software Environment:
> > Problem Description: WARNING section in bootup log (attached)
> > 
> 
> This is an acpi regression, I believe.  And it was reported a week or two
> ago.

It's the same thing as http://bugzilla.kernel.org/show_bug.cgi?id=10104 ,
already on the regressions list.

Thanks,
Rafael
