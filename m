From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9835] New: After Hibernation the battery
 charging information is not working any more.
Date: Mon, 28 Jan 2008 04:50:53 -0800
Message-ID: <20080128045053.a07f6539.akpm@linux-foundation.org>
References: <bug-9835-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60074 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755301AbYA1Mug (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 07:50:36 -0500
In-Reply-To: <bug-9835-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, rk@vzsze.de

On Mon, 28 Jan 2008 04:43:49 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9835
> 
>            Summary: After Hibernation the battery charging information is
>                     not working any more.
>            Product: Power Management
>            Version: 2.5
>      KernelVersion: 2.6.24
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: rk@vzsze.de
> 
> 
> Latest working kernel version: 2.6.24-rc7
> Earliest failing kernel version: 2.6.24-rc8
> Distribution: Kubuntu 7.10
> Hardware Environment: Lenovo Thinkpad T60
> Software Environment: Kubuntu with KDE
> Problem Description: After hibernating the system and resuming, the charging
> information is not shown any more in guidance-power-manager.
> 
> Steps to reproduce: Hibernate laptop and resume.
> 

This regression apparently occurred very late in 2.6.24 development.  It
should be easy to pinpoint?

