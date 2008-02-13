From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9957] New: Battery gives me now two batterys,
 but only one is present
Date: Wed, 13 Feb 2008 12:31:12 -0800
Message-ID: <20080213123112.5df7fea3.akpm@linux-foundation.org>
References: <bug-9957-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44886 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756714AbYBMUb0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 15:31:26 -0500
In-Reply-To: <bug-9957-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: patrick.matthaei@web.de
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 13 Feb 2008 12:00:11 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9957
>
>            Summary: Battery gives me now two batterys, but only one is
>                     present

yeah, I'm seeing this on the t61p as well, but have thus far ignored it
amongst the storm of other problems.


>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.24.2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Power-Battery
>         AssignedTo: acpi_power-battery@kernel-bugs.osdl.org
>         ReportedBy: patrick.matthaei@web.de
> 
> 
> Latest working kernel version: 2.6.23.14
> Earliest failing kernel version: 2.6.24

And it's a regression.
