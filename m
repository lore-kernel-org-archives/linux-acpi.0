From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 14365] New: resume from suspend to ram broken
 after suspend to disk
Date: Sat, 10 Oct 2009 10:39:05 -0700
Message-ID: <20091010103905.7bc562c3.akpm@linux-foundation.org>
References: <bug-14365-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50524 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932139AbZJJRlf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Oct 2009 13:41:35 -0400
In-Reply-To: <bug-14365-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>

On Sat, 10 Oct 2009 13:40:45 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=14365
> 
>            Summary: resume from suspend to ram broken after suspend to
>                     disk
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 2.6.31
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: corsac@debian.org
>         Regression: No

It worries me that we have both "Power management, Hibernation/Suspend"
and acpi-power-sleep-wake.

Are these duplicative?

Should we kill one off?

Do the acpi developers monitor the "Power Management" category?

Thanks.
