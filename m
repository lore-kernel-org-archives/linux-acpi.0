From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Why ACPI is in the kernel, notes from 2001
Date: Fri, 29 Oct 2004 00:06:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <4181C1AA.7050004@pobox.com>
References: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263082AbUJ2EGX@vger.kernel.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>, "Brown, Len" <len.brown@intel.com>, "Grover, Andrew" <andrew.grover@intel.com>, "Therien, Guy" <guy.therien@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Alex Williamson <alex.williamson@hp.com>, linux-kernel <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Moore, Robert wrote:
> Here's some notes from 2001:
> 
> Why ACPI is in the kernel
> 
> ACPI and the AML interpreter are required very early during kernel
> initialization, before the device drivers are loaded.  Control methods
> are executed by the interpreter at this time (such as all device _INI
> methods).
> 
> ACPI owns the ACPI hardware and ACPI interrupt (SCI), and therefore this
> part of the ACPI subsystem is similar to a device driver.
> 
> Control methods that are executed via the AML interpreter are allowed
> direct access to all of physical memory, all I/O space, and all PCI
> configuration space (via Operation Regions.)
> 
> Device drivers such as the Embedded Controller, Battery, and Thermal use
> ACPI services and execute AML control methods during their operation.
> 
> Device driver callback routines are invoked directly from the AML
> interpreter when the ASL Notify operation is executed.
> 
> ACPI and the AML interpreter cannot be paged out.  How do you wake up
> the disk used for paging?  Not a good idea for other device drivers to
> depend on code that may be paged out.
> 
> Also,
> 
> As of May 2000, the AML interpreter was in acpid! Shortly after that, we
> made a conscious decision to move it into the driver for the reasons
> above.  The code may be large (for Linux), but it is necessary and must
> remain resident (it is non-pageable).


None of this implies that the interpreter cannot be in initramfs-like 
userspace, which neither requires a device driver nor will ever be paged 
out.

	Jeff
