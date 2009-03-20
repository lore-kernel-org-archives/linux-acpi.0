From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12904] New: hard lockup on Sony Vaio SR when
 connecting some external monitors
Date: Fri, 20 Mar 2009 14:09:45 -0700
Message-ID: <20090320140945.1e00aad1.akpm@linux-foundation.org>
References: <bug-12904-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50742 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520AbZCTVQS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Mar 2009 17:16:18 -0400
In-Reply-To: <bug-12904-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rui.zhang@intel.com
Cc: bugme-daemon@bugzilla.kernel.org, melchior+kernel@cmu.edu

On Fri, 20 Mar 2009 11:43:19 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12904
> 
>            Summary: hard lockup on Sony Vaio SR when connecting some
>                     external monitors
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.29-rc6
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: x86-64
>         AssignedTo: platform_x86_64@kernel-bugs.osdl.org
>         ReportedBy: melchior+kernel@cmu.edu
> 
> 
> Latest working kernel version: none
> Earliest failing kernel version: 2.6.26
> Distribution: Debian (unstable)
> Hardware Environment: Sony Vaio SR290 with Mobile 4 Series Chipset Integrated
> Graphics (PCI ids: 8086:2a42 and 8086:2a43)
> Software Environment: 64-bit Debian unstable
> Problem Description:
> 
> This laptop locks up when certain external display devices are attached after
> boot.  Only overhead projectors seem to cause the lockup.  I can attach
> external LCD monitors at any time and use (e.g.) xrandr without problem. 
> Likewise, if the projector is attached before turning the laptop on, the
> display will be mirrored and it will work fine.  In this case, unplugging the
> projector will cause the lockup.
> 
> Steps to reproduce:
> 
> This problem occurs in X or at the console, with or without the i915 module
> loaded.  It occurs at the console with the framebuffer enabled or with
> vga=normal.  In the latter case, the cursor continues to blink, but the system
> doesn't respond to keystrokes.  Alt+SysRq doesn't work in any of these cases.
> 

Gee, I'm struggling to work out which kernel subsystem might be involved
here.  If anything I suppose it is ACPI.

Help?
