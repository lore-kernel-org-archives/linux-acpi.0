From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8886] New: No more battery info with 2.6.23
 kernels
Date: Mon, 13 Aug 2007 20:17:53 -0700
Message-ID: <20070813201753.90481089.akpm@linux-foundation.org>
References: <bug-8886-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38031 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754645AbXHNDSd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 23:18:33 -0400
In-Reply-To: <bug-8886-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-acpi@vger.kernel.org, casteyde.christian@free.fr

On Mon, 13 Aug 2007 09:14:11 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8886
> 
>            Summary: No more battery info with 2.6.23 kernels
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.23-rc3
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Power-Battery
>         AssignedTo: acpi_power-battery@kernel-bugs.osdl.org
>         ReportedBy: casteyde.christian@free.fr
> 
> 
> Most recent kernel where this bug did not occur: 2.6.22.x
> Distribution: Slackware 12
> Hardware Environment: Athlon64 3000 + nForce3 150 on Aspire 1511 LMi
> Software Environment: none
> Problem Description:
> With recent kernels (2.6.23-rc3, maybe 2.6.23-rc2 but I'm not sure), the
> battery information is not available anymore on some laptops.
> Dmesg info for different kernel versions appended.
> 
> Steps to reproduce:
> Maybe specific to my hardware. It used to have a DSDT replacement for old
> kernels (2.6.16 for instance), but since 2.6.19 up to 2.6.22 it was not
> necessary. Now, it does work with neither original nor fixed DSDT.
> 

Michal, please track this as a post-2.6.22 regression, thanks.
