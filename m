From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8958] New: regression: fan doesn't work
 anymore
Date: Wed, 29 Aug 2007 16:33:21 -0700
Message-ID: <20070829163321.25f5f32d.akpm@linux-foundation.org>
References: <bug-8958-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34526 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754198AbXH2Xd1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Aug 2007 19:33:27 -0400
In-Reply-To: <bug-8958-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

On Wed, 29 Aug 2007 13:47:36 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8958
> 
>            Summary: regression: fan doesn't work anymore
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.23-rc4
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: Other
>         AssignedTo: acpi_other@kernel-bugs.osdl.org
>         ReportedBy: daniel.ritz@gmx.ch
> 
> 
> Most recent kernel where this bug did not occur: 2.6.23-rc2 (maybe rc3)
> Distribution: ubuntu
> Hardware Environment: Toshiba Tecra 8000 Laptop (P3)
> Software Environment:
> Problem Description:
> the fan doesn't work any more...isected it to that one:
> 
> cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b is first bad commit
> commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
> Author: Alexey Starikovskiy <astarikovskiy@suse.de>
> Date:   Fri Aug 3 17:52:48 2007 -0400
> 
>     ACPI: EC: If ECDT is not found, look up EC in DSDT.
> 
>     Some ASUS laptops access EC space from device _INI methods, but do not
>     provide ECDT for early EC setup. In order to make them function properly,
>     there is a need to find EC is DSDT before any _INI is called.
> 
>     Similar functionality was turned on by acpi_fake_ecdt=1 command line
>     before. Now it is on all the time.
> 
>     http://bugzilla.kernel.org/show_bug.cgi?id=8598
> 
>     Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> Steps to reproduce: boot (or try to)
> 

I'm not sure that I understand this report ;)

Michal, pleas track it as a post-2.6.22 regression.

Daniel, if you have a patch which you think is needed for 2.6.23 can
you please send it?

