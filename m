From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Fri, 15 Feb 2008 16:52:18 +0800
Message-ID: <b6a2187b0802150052jcfd9c96k2a6abcd1c7fea399@mail.gmail.com>
References: <200802111623.38478.elendil@planet.nl>
	 <200802131239.14305.elendil@planet.nl>
	 <20080213165837.GA10129@suse.de> <200802131955.53821.rjw@sisk.pl>
	 <20080215065952.GB8916@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:26473 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbYBOIwT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Feb 2008 03:52:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1060025wah.23
        for <linux-acpi@vger.kernel.org>; Fri, 15 Feb 2008 00:52:18 -0800 (PST)
In-Reply-To: <20080215065952.GB8916@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 2:59 PM, Greg KH <gregkh@suse.de> wrote:
>  I swear someone else sent this in, but my archives don't show it at all.
>  I think the patch below should solve this, but I need someone to test it.

I tested but it doesn't fix the problem for me. May be my problem is
different ... as my X60s just doesn't power-off on suspend-to-disk.

My .config says ...
     # CONFIG_CPU_FREQ is not set
     # CONFIG_CPU_IDLE is not set


On Wed, Feb 13, 2008 at 3:54 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>  due to softlockup changes, and setting CONFIG_DETECT_SOFTLOCKUP=n ...

Also, I've tried CONFIG_DETECT_SOFTLOCKUP=n, but this doesn't fix it either.


Here's the last dmesg after suspend-to-disk and hang there...

CPU 1 is now offline
SMP alternatives: switching to UP code
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Shrinking memory...  ^H-^Hdone (0 pages freed)
PM: Freed 0 kbytes in 0.10 seconds (0.00 MB/s)
ACPI: Preparing to enter system sleep state S4
Suspending console(s)

[ ... it just hangs here ... press power-switch does the job, and
system is able to resume upon powering on ]


Thanks,
Jeff.
