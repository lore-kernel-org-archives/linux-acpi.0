From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9747] New: Oops on boot from laptop mode
 writing to /proc/acpi/processor/CPU0/throttling
Date: Mon, 14 Jan 2008 13:25:20 -0800
Message-ID: <20080114132520.e2e62337.akpm@linux-foundation.org>
References: <bug-9747-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44422 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896AbYANV0O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2008 16:26:14 -0500
In-Reply-To: <bug-9747-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, huggie@earth.li, Zhao Yakui <yakui.zhao@intel.com>
Cc: bugme-daemon@bugzilla.kernel.org

On Mon, 14 Jan 2008 11:19:42 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9747
> 
>            Summary: Oops on boot from laptop mode writing to
>                     /proc/acpi/processor/CPU0/throttling
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.24-rc7
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Config-Processors
>         AssignedTo: acpi_config-processors@kernel-bugs.osdl.org
>         ReportedBy: huggie@earth.li
> 
> 
> Latest working kernel version: Unsure.  Later than 2.6.24-rc2
> Earliest failing kernel version: 2.6.24-rc6 (possibly earlier)
> Distribution: Debian
> Hardware Environment: Toshiba Portege r500
> Software Environment:
> Problem Description:
> 
> When I boot laptop-mode fires up and tries to write to
> /proc/acpi/processor/CPU0/throttling which contains <not supported>
> 
> I don't quite know what I've done to get it to contain <not supported> but
> anyway that'll be more fun to track down I'm sure.
> 
> In any case, in this configuration I get this oops even if all I do is
> echo stuff >/proc/acpi/processor/CPU0/throttling
> 
> [   32.378673] Unable to handle kernel NULL pointer dereference at
> 0000000000000
> 000 RIP: 

Guys, this is a serious post-2.6.23 regression.
