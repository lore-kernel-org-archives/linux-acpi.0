From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Wed, 12 Aug 2009 23:18:12 +0200
Message-ID: <200908122318.12145.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908121633220.23954-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751256AbZHLVRV@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0908121633220.23954-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "dtor@mail.ru" <dtor@mail.ru>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 12 August 2009, Alan Stern wrote:
> On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > The one thing I'm not sure of is the pm_runtime_put_noidle calls in 
> > > driver_probe_device and __device_release_driver.  It seems that we 
> > > should always call pm_runtime_put regardless of whether the probe 
> > > succeeds or not.
> > 
> > Did you mean pm_runtime_put_sync()?
> 
> Yes.  I haven't used the new code yet so the names don't stick in my 
> mind.
> 
> > > For example, the USB stack is set up to suspend devices that don't have
> > > a driver (this is handled at the bus subsystem level).  But if probing
> > > failed, there wouldn't be any idle callback and so the suspend wouldn't
> > > take place.
> > 
> > OK, I'll make this change.
> 
> Thanks.  Now I just have to figure out the best way to convert USB over 
> to the new framework...

:-)

On a second thought, though, would it be a good idea to add
pm_runtime_get_noresume() / pm_runtime_put_sync() around the bus_for_each_drv()
in device_attach()?  That would prevent us from resuming-suspending the device
on each failing probe.

Rafael
