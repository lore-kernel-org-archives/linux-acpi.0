From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch update 2 fix] PM: Introduce core framework
 for run-time PM of I/O devices
Date: Sat, 20 Jun 2009 10:30:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39548 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752819AbZFTOap (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jun 2009 10:30:45 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <magnus.damm@gmail.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Some more thoughts...

Magnus, you might have some insights here.  It occurred to me that some 
devices can switch power levels very quickly, and the drivers might 
therefore want the runtime suspend and resume methods to be called as 
soon as possible, even in interrupt context.

In terms of the current framework, this probably means holding the
runtime PM lock (i.e., not releasing it) across the calls to
->runtime_suspend and ->runtime_resume.  It also means that
pm_request_suspend and pm_request_resume should carry out their jobs
immediately instead of queuing a work item.  (Unless the current status 
is RPM_SUSPENDING or RPM_RESUMING, which should never happen.)

Should there be a flag in dev_pm_info to select this behavior?


When a device structure is unregistered and deallocated, we have to
insure that there aren't any pending runtime PM workqueue items.  
Hence device_del should call a routine that changes the status to an
exceptional state (not RPM_ERROR but something else) to prevent new
requests from being queued, and then calls cancel_work_sync or
cancel_delayed_work_sync as required.

Similarly, we should insure that runtime PM calls made before the
device is registered don't do anything.  So when the device structure
is first created and the contents are all 0, this should also be
interpreted as an exceptional state.  We could call it RPM_UNREGISTERED
and use it for both purposes.

Alan Stern

