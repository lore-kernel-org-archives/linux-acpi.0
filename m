From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 11:17:23 +0800
Message-ID: <20090730031723.GB24959@sli10-desk.sh.intel.com>
References: <20090730020623.GB26389@srcf.ucam.org> <20090730023313.GA27493@sli10-desk.sh.intel.com> <20090730025657.GE26389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40040 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbZG3DR0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 23:17:26 -0400
Content-Disposition: inline
In-Reply-To: <20090730025657.GE26389@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 10:56:57AM +0800, Matthew Garrett wrote:
> On Thu, Jul 30, 2009 at 10:33:13AM +0800, Shaohua Li wrote:
> 
> > There are patches to support both ACPI based wakeup event and PCIe native
> > wakeup event in below bugzilla, but it never gets into upstream. One problem
> > is how to check which device under a bridge generates a wakeup event, because
> > pci devices can share a wakeup event.
> > There are discussion in pm list about the patches too, please search.
> 
> Yes, that would basically work for me. I'm still slightly curious as to 
> why my hardware's not giving me the correct ACPI notification, though - 
> I guess this may be entirely untested under Windows.
IIRC, you don't need to know which GPE for wakeup. The GPE is already enabled.
And all required are just to register a notifier handler (register_acpi_bus_notifier), and check the ACPI_NOTIFY_DEVICE_WAKE event.
