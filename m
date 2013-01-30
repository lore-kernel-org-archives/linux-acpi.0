From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Add check preventing transitioning to non-D0 state from D3.
Date: Thu, 31 Jan 2013 00:27:25 +0100
Message-ID: <4852069.tOyaDAodDO@vostro.rjw.lan>
References: <e4ec829902580af84cddbba6e98ef54b33052b85.1352953283.git.lv.zheng@intel.com> <4595012.aPT9n2OZdk@al> <12389653.2bKflhlsko@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34663 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab3A3XVN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2013 18:21:13 -0500
In-Reply-To: <12389653.2bKflhlsko@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, January 30, 2013 10:55:17 PM Rafael J. Wysocki wrote:
> On Wednesday, January 30, 2013 06:53:46 PM Peter Wu wrote:
> > Hi Lv Zheng,
> > 
> > I encounter a regression with your patch (Linux 3.8-rc5). On my Nvidia Optimus 
> > laptop, I use the bbswitch[1] kernel module to trigger a _PS3 ACPI method call 
> > to turn the video card off.
> > 
> > After this patch, I got the following in my kernel log:
> > 
> >     pci 0000:01:00.0: Refused to change power state, currently in D0
> >     ACPI: Cannot transition to non-D0 state from D3
> >     bbswitch: Succesfully loaded. Discrete card 0000:01:00.0 is on
> > 
> > The expected output would be "Discrete card 0000:01:00.0 is  off". Printing the 
> > contents of (acpi_device) device->power.state shows FF (ACPI_STATE_UNKNOWN). 
> > Should this condition be excluded from your check or is my hacky module 
> > outdated?
> > 
> > I currently workaround this issue by checking for ACPI_STATE_UNKNOWN. If that 
> > is the value, I assume on (overwrite device->power.state with ACPI_STATE_D0). 
> > Then I call pci_set_power_state(pci_dev, PCI_D3cold).
> 
> You shouldn't ever be transitioning from an uknown state to D3cold directly.
> Please first transition to D0 and then to D3cold.
> 
> Can you please test the linux-next branch of the linux-pm.git tree and check
> if you see this problem in there too?

To be more precise, I wonder why you get ACPI_STATE_UNKNOWN in
device->power.state if the device is power-manageable.  In theory
acpi_bus_init_power() should change that to something meaningful and if it
doesn't, then there's a bug either in acpi_bus_init_power() or in the BIOS.

We may just need to try to force D0 in acpi_bus_init_power() if _PSC is missing,
for example.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
