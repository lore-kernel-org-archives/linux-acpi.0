From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8919] New: Broken hotkeys on ASUS A6Km
 notebook with 2.6.23-rc3.
Date: Wed, 22 Aug 2007 02:04:04 -0700
Message-ID: <20070822020404.5a0d5102.akpm@linux-foundation.org>
References: <bug-8919-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45012 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762914AbXHVJEM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Aug 2007 05:04:12 -0400
In-Reply-To: <bug-8919-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, szczekut@wit.edu.pl

On Wed, 22 Aug 2007 01:33:48 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8919
> 
>            Summary: Broken hotkeys on ASUS A6Km notebook with 2.6.23-rc3.
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.23-rc3
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Platform-Drivers
>         AssignedTo: acpi_platform-drivers@kernel-bugs.osdl.org
>         ReportedBy: szczekut@wit.edu.pl
> 
> 
> Most recent kernel where this bug did not occur: 2.6.23-rc2
> Distribution: Gentoo
> Hardware Environment: ASUS A6Km-Q017
> Problem Description:
> 
>   Hotkeys like: mute, voluem up, volume down, monitor brightness up, monitor
> brightness down, monitor switch on/off, wireless on/off, sleep button are
> broken work with new drivers/acpi/ec.c. There is no acpi event from any of
> those. Also i can't switch monitor off using Fn+F7. Power button, battery, fan,
> processor and thermal works fine.
> 
> Steps to reproduce: always
> 
> 

Michal, please track this as a post-2.6.22 regression, thanks.
