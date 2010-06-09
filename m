From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Wakeup races, PCI, and ACPI
Date: Thu, 10 Jun 2010 01:30:48 +0200
Message-ID: <201006100130.48861.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1006091148320.1728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1006091148320.1728-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 09, 2010, Alan Stern wrote:
> Rafael:
> 
> I see that the kacpi_notify_wq thread isn't freezable.  This means we
> are subject to a race during system sleep transitions.  If a PCI device
> is already runtime-suspended, then a PME# wakeup request could cause
> kacpi_notify_wq to attempt a runtime resume at the same time as the
> regular suspend or freeze method is running.  (The same is true for 
> non-PCI devices and ACPI-platform-specific wakeup requests.)

That, among other things, is why PCI devices are runtime resumed automatically
by the PCI subsystem in its pm->prepare() callback.

Thanks,
Rafael
