From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9334] New: Kernel 2.6.22   computer turn off
Date: Fri, 9 Nov 2007 00:41:45 -0800
Message-ID: <20071109004145.81fa3a20.akpm@linux-foundation.org>
References: <bug-9334-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52988 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbXKIImU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 03:42:20 -0500
In-Reply-To: <bug-9334-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, novak-j@seznam.cz

On Thu,  8 Nov 2007 23:12:18 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9334
> 
>            Summary: Kernel 2.6.22   computer turn off
>            Product: Other
>            Version: 2.5
>      KernelVersion: 2.6.22
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: other_other@kernel-bugs.osdl.org
>         ReportedBy: novak-j@seznam.cz
> 
> 
> Most recent kernel where this bug did not occur:
> Distribution: Debian 4.0 Lenny
> Hardware Environment:   Celeron 2,8 GHz. Mainboard Asrock  with  socket 478 
> and Via  chipset. It is model P4VM890. Quite new.   I have case from 
>  one of  Fujitsu Siemens models and it has not restart button. So it is not 
>  connected.  Hard Disk WD 120 GB SATA.
> Software Environment: Debian 4.0 Lenny
> Problem Description:  I tried to use kernel 2.6.22. It is  the last  version
> from testing 
>  Lenny. When I stop my computer, it  looks like some restart. It stops and 
>  after 1 second it begins to start again. After 1 second it stops definitely.  
>  It is unpleasant.  I have tried 2.6.23 kernel from trunk and it does the same
> error.
>  By 2.6.18 kernel from ETch it is all right.
> 
> Steps to reproduce: I sent info to kernel packager  and he wrote, it is a
> kernel bug and not package problem.

fwiw, a Nocona machine whcih Intel sent me started doing this about 1.5 years
ago.  It used to shut down OK, but now it turns on again five seconds later.

Suspicions have been raised about wake-on-LAN hardware remaining
permanently asserted or something like that, but it is unknown why it used
to work then stopped.
