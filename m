From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices on
 bus 0
Date: Fri, 19 Dec 2008 14:21:59 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812191417370.3745@localhost.localdomain>
References: <Pine.LNX.4.44L0.0812191005310.2453-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:34561 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYLSTWM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 14:22:12 -0500
In-reply-to: <Pine.LNX.4.44L0.0812191005310.2453-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, "Barnes, Jesse" <jesse.barnes@intel.com>


On Fri, 19 Dec 2008, Alan Stern wrote:

> On Fri, 19 Dec 2008, Zhang Rui wrote:
> 
> > device parallel resume support for PCI devices
> 
> There are some PCI devices which won't work right if they are resumed
> in parallel.  The example I have in mind is a USB host controller
> device with both a high-speed EHCI controller function and some
> companion low/full-speed UHCI or OHCI controller functions.  The EHCI
> driver relies on the fact that the EHCI controller has a higher
> function number and therefore is resumed _after_ the companion
> controllers.
> 
> We need a way to express dependencies like this between devices.  Or at 
> least, there has to be a way to prevent certain devices from resuming 
> in parallel.

Perhaps the most pragmatic approach would be to identify which devices
benefit the most from parallel resume, and use some hooks so that
those device drivers can be optimized to resume in parallel
while everything else takes the existing serialized path?

-- Len Brown, Intel Open Source Technology Center
