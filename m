From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] acpi : acpi_bus_trim() stops removing devices when
 failing to remove the device
Date: Fri, 19 Oct 2012 10:59:41 -0700
Message-ID: <20121019175941.GB3375@kroah.com>
References: <50769B8C.2060901@jp.fujitsu.com>
 <1846185.MSykHDcMmb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1846185.MSykHDcMmb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, toshi.kani@hp.com, lenb@kernel.org, wency@cn.fujitsu.com, vasilis.liaskovitis@profitbricks.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 19, 2012 at 06:29:52AM +0200, Rafael J. Wysocki wrote:
> On Thursday 11 of October 2012 19:12:28 Yasuaki Ishimatsu wrote:
> > acpi_bus_trim() stops removing devices, when acpi_bus_remove() return error
> > number. But acpi_bus_remove() cannot return error number correctly.
> > acpi_bus_remove() only return -EINVAL, when dev argument is NULL. Thus even if
> > device cannot be removed correctly, acpi_bus_trim() ignores and continues to
> > remove devices. acpi_bus_hot_remove_device() uses acpi_bus_trim() for removing
> > devices. Therefore acpi_bus_hot_remove_device() can send "_EJ0" to firmware,
> > even if the device is running on the system. In this case, the system cannot
> > work well.
> > 
> > Vasilis hit the bug at memory hotplug and reported it as follow:
> > https://lkml.org/lkml/2012/9/26/318
> > 
> > So acpi_bus_trim() should check whether device was removed or not correctly.
> > The patch adds error check into some functions to remove the device.
> > 
> > Applying the patch, acpi_bus_trim() stops removing devices when failing
> > to remove the device. But I think there is no impact with the
> > exceptionof CPU and Memory hotplug path. Because other device also fails
> > but the fail is an irregular case like device is NULL.
> > 
> > v1->v2
> > - add a rollback for reinstalling a notify handler.
> > 
> > Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> Greg, do you think there may be any problems with the changes in dd.c?

Yes, I don't like it.

remove should always work, just like the exit call in a module.  It
means that the core wants to remove the driver, so it is going to
happen, a driver can't refuse it.

Which brings me to the larger question, why would this solve anything?
If the kernel wants to unbind a device, why would we ever not want that
to happen?

So, NAK on this patch, sorry.  Fix up the ACPI core to handle this
properly, don't mess with the driver core here.

greg k-h
