From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Fri, 28 Aug 2009 11:43:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908281137110.4116-100000@iolanthe.rowland.org>
References: <200908262221.09224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200908262221.09224.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 26 Aug 2009, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Theoretically, the total time of system sleep transitions (suspend
> to RAM, hibernation) can be reduced by running suspend and resume
> callbacks of device drivers in parallel with each other.  However,
> there are dependencies between devices such that, for example, we may
> not be allowed to put one device into a low power state before
> anohter one has been suspended (e.g. we cannot suspend a bridge
> before suspending all devices behind it).  In particular, we're not
> allowed to suspend the parent of a device before suspending the
> device itself.  Analogously, we're not allowed to resume a device
> before resuming its parent.

> In this version of the patch the async threads started to execute
> the resume callbacks of specific device don't exit immediately having
> done that, but search dpm_list for devices whose PM dependencies have
> already been satisfied and execute their callbacks without waiting.

Given this design, why bother to invoke device_resume() for the async 
devices?  Why not just start up a bunch of async threads, each of which 
calls async_resume() repeatedly until everything is finished?  (And 
rearrange async_resume() to scan the list first and do the actual 
resume second.)

The same goes for the noirq versions.

Alan Stern
