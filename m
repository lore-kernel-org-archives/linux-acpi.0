From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Wed, 12 Aug 2009 10:03:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908120958200.2955-100000@iolanthe.rowland.org>
References: <200908120117.27961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35116 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752627AbZHLODU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2009 10:03:20 -0400
In-Reply-To: <200908120117.27961.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "dtor@mail.ru" <dtor@mail.ru>

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> That looks quite complicated at first sight, but asynchronous resume with
> completions can be done in a relatively simple patch.  I've got one, so
> tomorow I'll post it for further discussion.

Okay.  I would think that managing the threads would account for most 
of the complexity in either implementation, but I'll wait to see how 
your approach works out.

> Thanks,
> Rafael
> 
> 
> PS
> Did you have a chance to look at rev. 15 of the runtime PM patch
> (http://patchwork.kernel.org/patch/40306/)?

Yes, sorry for not getting back to you.  It looks okay.

The one thing I'm not sure of is the pm_runtime_put_noidle calls in 
driver_probe_device and __device_release_driver.  It seems that we 
should always call pm_runtime_put regardless of whether the probe 
succeeds or not.

For example, the USB stack is set up to suspend devices that don't have
a driver (this is handled at the bus subsystem level).  But if probing
failed, there wouldn't be any idle callback and so the suspend wouldn't
take place.

Alan Stern

