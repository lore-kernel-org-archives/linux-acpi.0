From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ACPI / PM: Make acpi_pm_device_sleep_state() follow the
 specification
Date: Fri, 25 May 2012 21:54:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205252148190.20180-100000@netrider.rowland.org>
References: <201205260004.02778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:59596 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751378Ab2EZByF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 May 2012 21:54:05 -0400
In-Reply-To: <201205260004.02778.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>

On Sat, 26 May 2012, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The comparison between the system sleep state being entered
> and the lowest system sleep state the given device may wake up
> from in acpi_pm_device_sleep_state() is reversed, because the
> specification (ACPI 5.0) says that for wakeup to work:
> 
> "The sleeping state being entered must be less than or equal to the
>  power state declared in element 1 of the _PRW object."

What does "less than or equal to" mean here?  Is D0 <= D1 because 0 <=
1?  (Or because D1 is a "higher sleep state" than D0?)  Or is D1 <= D0
because the amount of power used in D1 is <= the amount of power used
in D0?

> Moreover, it also should check if the wakeup capability is supported
> through ACPI, because in principle it may be done via native PCIe
> PME, for example.

Can you outline the overall algorithm used to select a PCI device's
sleep state?  It's obvious that the inputs are the system's target
state and whether or not wakeup should be enabled.  Beyond that, I do
not have a clear idea of how the selection is made.

Alan Stern

