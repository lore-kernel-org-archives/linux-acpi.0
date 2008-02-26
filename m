From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10072] New: WARNING: at
 arch/x86/mm/ioremap.c:137 __ioremap+0x1d5/0x1f0() during bootup
Date: Mon, 25 Feb 2008 16:00:47 -0800
Message-ID: <20080225160047.6e4dd6bc.akpm@linux-foundation.org>
References: <bug-10072-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:42199 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753686AbYBZACM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 19:02:12 -0500
In-Reply-To: <bug-10072-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: plamen.petrov@tk.ru.acad.bg
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org

On Sat, 23 Feb 2008 09:09:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10072
> 
>            Summary: WARNING: at arch/x86/mm/ioremap.c:137
>                     __ioremap+0x1d5/0x1f0() during bootup
>            Product: Memory Management
>            Version: 2.5
>      KernelVersion: 2.6.25-rc2-00496-g39273b5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: Other
>         AssignedTo: akpm@osdl.org
>         ReportedBy: plamen.petrov@tk.ru.acad.bg
> 
> 
> Latest working kernel version:
> Earliest failing kernel version:
> Distribution: Slackware 12
> Hardware Environment: AMD Duron 850MHz CPU, 512 MB RAM
> Software Environment:
> Problem Description: WARNING section in bootup log (attached)
> 

This is an acpi regression, I believe.  And it was reported a week or two
ago.
