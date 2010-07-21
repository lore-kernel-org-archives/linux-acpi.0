From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 16387] New: system freezes when dvd starts to
 spin for playback
Date: Wed, 21 Jul 2010 14:04:08 -0700
Message-ID: <20100721140408.44f97af4.akpm@linux-foundation.org>
References: <bug-16387-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36290 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753719Ab0GUVEo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jul 2010 17:04:44 -0400
In-Reply-To: <bug-16387-10286@https.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, stable@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 14 Jul 2010 12:18:31 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=16387
> 
>            Summary: system freezes when dvd starts to spin for playback
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 2.6.35-rc5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: io_other@kernel-bugs.osdl.org
>         ReportedBy: mehmet@giritli.eu
>         Regression: No
> 
> 
> In 2.6.35 rcs, I get frequent freezes of my computer when I put a DVD (its a DL
> DVD-Video, if matters) in for playback. I do not know how to get any data out
> of the computer in this situation, nothing works (not even the caps lock). So I
> turn it off and restart to use it again.
> 
> 2.6.33 kernels do not have this problem and I have not tried .34 yet as those
> kernels have a nasty acpi bug on my computer
> (https://bugzilla.kernel.org/show_bug.cgi?id=16040).
> 
> Could someone instruct me how to debug this please?

Len, the patches in https://bugzilla.kernel.org/show_bug.cgi?id=16040
don't appear to have made it into 2.6.34.1, even though they were
written a month earlier.  This 2.6.34 regression is preventing at least
one tester from testing 2.6.34.x kernels for a different regression.

Did we forget to backport those fixes into -stable?

Thanks.
