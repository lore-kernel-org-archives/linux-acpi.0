From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup() policy
	inputs
Date: Mon, 28 Apr 2008 20:48:05 +0800
Message-ID: <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
References: <200803201408.33466.david-b@pacbell.net>
	 <200804182118.05228.david-b@pacbell.net>
	 <1208871017.14474.52.camel@yakui_zhao.sh.intel.com>
	 <200804261237.26499.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4221 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbYD1E4R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 00:56:17 -0400
In-Reply-To: <200804261237.26499.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Thomas Renninger <trenn@suse.de>

On Sat, 2008-04-26 at 12:37 -0700, David Brownell wrote:
> On Tuesday 22 April 2008, Zhao Yakui wrote:
> > Agree with what Rui said. The patch doesn't change the time when GPEs
> > are enabled/disabled.
> 
> So you also think my worries were unfounded?  OK, I'm happy
> to hear that.  It means the userspace model for wakeup events
> on PCs can become one that non-ACPI platforms can use too.
> 
> In which case ... I'll resend this patch with a more concise
> summary and a signed-off-by line.
> 
> 
> > But after the patch is applied, some PCI device(the ACPI device with the
> > _PRW object) can wake the sleeping system by default. And it is totally
> > opposite to the current flowchart. 
> 
> That's not true.  Behavior could only change for devices with
> drivers which already call pci_enable_wake()!
Yes. But in fact a lot of PCI device will call pci_enable_wake when the
system enters the suspend state. And the behaviour will be changed.
> What's different is that /proc/acpi/wakeup is being taken
> partially out of the decision loop ... in favor of (a) driver
> model flags, which work on platforms without ACPI, and also
> (b) device driver logic, which in any case really needs to
> be prepared to request and otherwise manage the wake events.
> 
Yes. What your said is right. If your patch is applied, whether the PCI
device can wake the sleeping system is controlled by device driver. In
such case the /proc/acpi/wakeup will be useless.

> If someone sets /proc/acpi/wakeup flags for a device, it
> could still be made to issue wake events for devices with
> drivers that don't expect (or handle) those events.
> 
> - Dave

