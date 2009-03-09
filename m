From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12831] New: Hot/Fn Keys do not work EEEPC
 1000HE (eeepc_laptop)
Date: Mon, 9 Mar 2009 12:51:42 -0700
Message-ID: <20090309125142.54f707dd.akpm@linux-foundation.org>
References: <bug-12831-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55150 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbZCITwa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 15:52:30 -0400
In-Reply-To: <bug-12831-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: bugme-daemon@bugzilla.kernel.org, pyther@pyther.net, patrick.bregman@gmail.com, linux-acpi@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).


On Sat,  7 Mar 2009 10:05:56 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12831
> 
>            Summary: Hot/Fn Keys do not work EEEPC 1000HE (eeepc_laptop)
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.29-rc7
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: drivers_other@kernel-bugs.osdl.org
>         ReportedBy: pyther@pyther.net
> 
> 
> Latest working kernel version: 2.6.28.7
> Earliest failing kernel version: 2.6.29-rc7 (may have been eailier, I haven't
> tested older rcs)
> Distribution: Archlinux
> Hardware Environment: EEEPC 1000HE
> 
> Problem Description: 
> 
> The function keys on the Asus EEEPC 1000HE do not register any keycodes / acpi
> code. However, Fn+F1 (Sleep) and the Power Button register keycodes and work as
> expected. Another note is that the Fn+F5 and Fn+F6 keys work as expected
> (brighten and dims the display), but do not give any acpi codes.
> 
> Here is a copy of my kernel config: http://rafb.net/p/GTQiS467.html
> 
> If you need any extra information, I'll be more than happy to provide it. I do
> not have a good grasp on how acpi works, so please forgive me if I used the
> wrong terminology.
> 
> 
> Steps to reproduce:
> 1. Compile 2.6.29-rc7
> 2. Run acpi_listen
> 3. Press Fn+F2-F10 or anyother special key
> 
> Expected results output of acpi keycode. Actual results no output.
> 

Two people (Patrick and Matthew) are reporting this post-2.6.28
regression.

Could someone please recategorise the report to something more
appropriate than drivers_other?

Thanks.

