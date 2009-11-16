From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable of generating
 run-time wake-up events
Date: Mon, 16 Nov 2009 14:39:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911161436560.2971-100000@iolanthe.rowland.org>
References: <200911160049.22717.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59250 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752181AbZKPTi6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2009 14:38:58 -0500
In-Reply-To: <200911160049.22717.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Mon, 16 Nov 2009, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Apparently, there are devices that can wake up the system from sleep
> states and yet are incapable of generating wake-up events at run
> time.  Thus, introduce a flag indicating if given device is capable
> of generating run-time wake-up events.

This raises the question: Who is responsible for setting the new 
flag?  The code that registers the device?

What if the kernel can't tell whether or not the device can generate 
runtime wake-up events?

What if the user wants to override the kernel's setting?  Should there 
be a sysfs attribute controlling the flag?

Alan Stern

