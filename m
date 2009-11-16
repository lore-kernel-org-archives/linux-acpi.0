From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable of generating run-time wake-up events
Date: Mon, 16 Nov 2009 21:52:38 +0100
Message-ID: <200911162152.38333.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911161436560.2971-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0911161436560.2971-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

On Monday 16 November 2009, Alan Stern wrote:
> On Mon, 16 Nov 2009, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Apparently, there are devices that can wake up the system from sleep
> > states and yet are incapable of generating wake-up events at run
> > time.  Thus, introduce a flag indicating if given device is capable
> > of generating run-time wake-up events.
> 
> This raises the question: Who is responsible for setting the new 
> flag?  The code that registers the device?

Yes, in general.  The platform.

Actually, I needed it for PCI, but I thought it would be better to put it at
the core level.

> What if the kernel can't tell whether or not the device can generate 
> runtime wake-up events?

Do you have any specific examples in mind?

> What if the user wants to override the kernel's setting?  Should there 
> be a sysfs attribute controlling the flag?

I have no plans for adding anything like that.

Rafael
