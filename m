From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Bugme-new] [Bug 10072] New: WARNING: at
 arch/x86/mm/ioremap.c:137 __ioremap+0x1d5/0x1f0() during bootup
Date: Tue, 26 Feb 2008 20:54:23 +0900
Message-ID: <20080226205423.480b628a.kamezawa.hiroyu@jp.fujitsu.com>
References: <bug-10072-10286@http.bugzilla.kernel.org/>
	<20080225160047.6e4dd6bc.akpm@linux-foundation.org>
	<200802260119.30112.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:44632 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbYBZLvi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Feb 2008 06:51:38 -0500
In-Reply-To: <200802260119.30112.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, plamen.petrov@tk.ru.acad.bg, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org

On Tue, 26 Feb 2008 01:19:29 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday, 26 of February 2008, Andrew Morton wrote:
> > On Sat, 23 Feb 2008 09:09:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=10072
> > > 
> > >            Summary: WARNING: at arch/x86/mm/ioremap.c:137
> > >                     __ioremap+0x1d5/0x1f0() during bootup
> > >            Product: Memory Management
> > >            Version: 2.5
> > >      KernelVersion: 2.6.25-rc2-00496-g39273b5
> > >           Platform: All
> > >         OS/Version: Linux
> > >               Tree: Mainline
> > >             Status: NEW
> > >           Severity: low
> > >           Priority: P1
> > >          Component: Other
> > >         AssignedTo: akpm@osdl.org
> > >         ReportedBy: plamen.petrov@tk.ru.acad.bg
> > > 
> > > 
> > > Latest working kernel version:
> > > Earliest failing kernel version:
> > > Distribution: Slackware 12
> > > Hardware Environment: AMD Duron 850MHz CPU, 512 MB RAM
> > > Software Environment:
> > > Problem Description: WARNING section in bootup log (attached)
> > > 
> > 
> > This is an acpi regression, I believe.  And it was reported a week or two
> > ago.
> 
> It's the same thing as http://bugzilla.kernel.org/show_bug.cgi?id=10104 ,
> already on the regressions list.
> 
my machine sees this. 

BTW, what this warning does on my console is

ACPI: EC: Look up EC in DSDT
------------[ cut here ]------------
WARNING: at arch/x86/mm/ioremap.c:137 __ioremap+0xb1/0x16b()
Modules linked in:
.......................... VERY VERY LONG STACK DUMP
=======================
---[ end trace ca143223eefdc828 ]---



Final console image was

....
 VERY VERY LONG STACK DUMP
=======================
---[ end trace ca143223eefdc828 ]---

...no information.

And nothing goes on (because the kernel is in very very slow path.)
(takes several minutes.)

I have to remove stack dump to find this is just a warning.
(I have no serial console.)

It seems show_stack() supports kstack=XX option.
Does it make sense to add same kind of option for limiting length of
dump_trace() ?

Thanks,
-Kame








