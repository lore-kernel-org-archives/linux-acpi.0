From: Alan Stern <stern@rowland.harvard.edu>
Subject: Wakeup races, PCI, and ACPI
Date: Wed, 9 Jun 2010 12:04:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006091148320.1728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38245 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751029Ab0FIQES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2010 12:04:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-acpi@vger.kernel.org

Rafael:

I see that the kacpi_notify_wq thread isn't freezable.  This means we
are subject to a race during system sleep transitions.  If a PCI device
is already runtime-suspended, then a PME# wakeup request could cause
kacpi_notify_wq to attempt a runtime resume at the same time as the
regular suspend or freeze method is running.  (The same is true for 
non-PCI devices and ACPI-platform-specific wakeup requests.)

Can kacpi_notify_wq be made freezable?  (Are ACPI wakeup notifications 
handled by any other workqueues?)  If not, should it call 
pm_request_resume() instead of pm_runtime_resume()?

Also, can this be handled in a way that doesn't end up losing wakeup 
events?  For quite some time, I've been thinking that any attempt to 
add a resume action to the pm workqueue should abort an ongoing system 
sleep, if device_may_wakeup() is true for the device in question.

Alan Stern

