From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9995] New: 2.6.25-rc1 regression - IBM ACPI
 backlight controlls do not work
Date: Fri, 15 Feb 2008 12:21:37 -0800
Message-ID: <20080215122137.629c612d.akpm@linux-foundation.org>
References: <bug-9995-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35459 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755705AbYBOUWE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 15:22:04 -0500
In-Reply-To: <bug-9995-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: xhejtman@fi.muni.cz
Cc: bugme-daemon@bugzilla.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Fri, 15 Feb 2008 04:51:15 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9995
> 
>            Summary: 2.6.25-rc1 regression - IBM ACPI backlight controlls do
>                     not work
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.25-rc1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: BIOS
>         AssignedTo: acpi_bios@kernel-bugs.osdl.org
>         ReportedBy: xhejtman@fi.muni.cz
> 
> 
> Latest working kernel version: 2.6.24
> Earliest failing kernel version: 2.6.25-rc1
> Distribution: Ubuntu/Hardy
> Hardware Environment: ThinkPad T61
> Software Environment: n/a
> Problem Description: /sys/class/backlight/acpi_video0 does not control
> backlight, nothing happens if I change brightness.
> 
> Steps to reproduce: echo {15,5,0} > /sys/class/backlight/acpi_video0/brightness 
> nothing happens.
> 

I've lost the plot on what's happening with backlight.  I think you're
about to find that this is not-a-bug, even though it stopped working.

