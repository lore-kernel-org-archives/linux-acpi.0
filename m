From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9944] New: suspend to ram doesn't work anymore
 on Thinkpad T61 with Intel X3100
Date: Tue, 12 Feb 2008 14:13:18 -0800
Message-ID: <20080212141318.7b83ee24.akpm@linux-foundation.org>
References: <bug-9944-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35302 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363AbYBLWOZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 17:14:25 -0500
In-Reply-To: <bug-9944-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: bugme-daemon@bugzilla.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, corsac@debian.org


(Please respond via emailed reply-to-all, not via the bugzilla web interface)

On Tue, 12 Feb 2008 14:02:31 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9944
> 
>            Summary: suspend to ram doesn't work anymore on Thinkpad T61 with
>                     Intel X3100
>            Product: Power Management
>            Version: 2.5
>      KernelVersion: 2.6.25-rc1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: corsac@debian.org
> 
> 
> Latest working kernel version: 2.6.24.2
> Earliest failing kernel version: 2.6.25-rc1

Rafael, is your list opened yet?

> Distribution: Debian Sid
> Hardware Environment: Thinkpad T61
> Software Environment: 
> Problem Description:
> 
> Suspend to ram doesn't work anymore on my thinkpad t61 with 2.6.25-rc1. On
> 2.6.24 I had to pass acpi_sleep=s3bios at boot time and suspend with s2ram -f
> -a 3.
> 
> On 2.6.25-rc1 doing (on console, with X not running) that leads to a blank
> screen and the ___sleep___ led (the moon) on the thinkpad blinks (like when it
> is currently suspending), but nothing happens then.
> 
> If I can make some more tests, or if you need more info, please ask. I hope
> this is no duplicate.
> 

I have a t61p and suspend/hibernate is bad and deteriorating.  So
many things go wrong that I'm afraid to test it any more.

