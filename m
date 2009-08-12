From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Wed, 12 Aug 2009 16:34:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908121633220.23954-100000@iolanthe.rowland.org>
References: <200908122210.35591.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:32770 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754160AbZHLUeg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2009 16:34:36 -0400
In-Reply-To: <200908122210.35591.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "dtor@mail.ru" <dtor@mail.ru>

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> > The one thing I'm not sure of is the pm_runtime_put_noidle calls in 
> > driver_probe_device and __device_release_driver.  It seems that we 
> > should always call pm_runtime_put regardless of whether the probe 
> > succeeds or not.
> 
> Did you mean pm_runtime_put_sync()?

Yes.  I haven't used the new code yet so the names don't stick in my 
mind.

> > For example, the USB stack is set up to suspend devices that don't have
> > a driver (this is handled at the bus subsystem level).  But if probing
> > failed, there wouldn't be any idle callback and so the suspend wouldn't
> > take place.
> 
> OK, I'll make this change.

Thanks.  Now I just have to figure out the best way to convert USB over 
to the new framework...

Alan Stern

