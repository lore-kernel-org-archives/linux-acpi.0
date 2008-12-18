From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12248] New: i386 Linux requires acpi=off at
 boot time on Gigabyte GA-MA69VM-S2
Date: Thu, 18 Dec 2008 12:21:50 -0800
Message-ID: <20081218122150.1f022d5c.akpm@linux-foundation.org>
References: <bug-12248-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52052 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbYLRUWV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Dec 2008 15:22:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIKLoBi022259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2008 12:21:51 -0800
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id mBIKLoUS021435
	for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2008 12:21:50 -0800
In-Reply-To: <bug-12248-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Thu, 18 Dec 2008 12:00:55 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12248
> 
>            Summary: i386 Linux requires acpi=off at boot time on Gigabyte
>                     GA-MA69VM-S2
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.24 or later, possibly earlier
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: i386
>         AssignedTo: platform_i386@kernel-bugs.osdl.org
>         ReportedBy: dandart@googlemail.com
> 
> 
> Latest working kernel version: Not known
> Earliest failing kernel version: 2,6,26 (possibly earlier)
> Distribution: openSUSE (11.0+, possibly earlier), Ubuntu (8.04+, possibly
> earlier)
> Hardware Environment: Gigabyte GA-MA69VM-S2 motherboard, AMD Athlon 64 X2 4800+
> 2.5GHz,
> virtualisation AMD-V On
> Software Environment: openSUSE 
> Problem Description: System freezes after boot on i386 versions of Ubuntu or
> openSUSE on GA-MA69VM-S2 if "acpi=off" append option not used.
> 
> Steps to reproduce: Boot i386 version of openSUSE or Ubuntu (custom kernel
> 2.6.27.9 too) without the acpi=off switch on Gigabyte GA-MA69VM-S2. System

Should this be reassigned to ACPI?
