From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Wed, 02 Dec 2015 10:34:44 +0800
Message-ID: <1449023684.22697.14.camel@rzhang1-mobl4>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com>
	 <CALCETrX24s2wzXs4bz4GH-XAi8COk2nKUkXYY2i81MV=r5H_PQ@mail.gmail.com>
	 <744357E9AAD1214791ACBA4B0B9092633A91E855@SHSMSX101.ccr.corp.intel.com>
	 <2125838.NE6T2gi0bX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3122 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755110AbbLBCes (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Dec 2015 21:34:48 -0500
In-Reply-To: <2125838.NE6T2gi0bX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Lutomirski <luto@amacapital.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, 2015-12-02 at 02:18 +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 01, 2015 03:25:41 AM Zhang, Rui wrote:
> > Hi, all,
> > 
> > The problem here is that the ACPI device node has
> >             Name (_HID, "INT33D5")  // _HID: Hardware ID
> >             Name (_CID, "PNP0C02" /* PNP Motherboard Resources */)  //
> > _CID: Compatible ID
> > 
> > Andy wants to write a driver for INT33D5 device, but unfortunately
> > 1. _CID "PNP0C02" makes it impossible to bind via platform bus
> > 2. Lacking of _CRS makes it impossible to bind via PNP bus.
> > 
> > I've seen similar problem before, and the solution is to ask BIOS people to remove the _CID "PNP0C02".
> 
> What if they refuse?

Well, we don't have a kernel solution for this case so far.
> 
> > IMO, such AML code does not make sense at all (even if _CRS is provided), because in this case, the _CID and the _HID of the same ACPI device node actually represent two totally different devices.
> 
> That's correct.  I guess this is a hack for Windows to prevent it from
> displaying "yellow bangs" for devices without "real" drivers.

Does this mean that the Windows "PNP0C02" driver won't prevent any other
driver from probing its devices?
> 
> > OR, a clean way to fix this in Linux is to make the motherboard resource reservation stuff a function call instead of a driver, and invoke the function call in either PNP or ACPI bus code by checking "PNP0C02". In this case, only the device id that represents the physical device (INT33D5 in this case) can be used for device enumeration and driver probing.
> 
> OK, but we need to keep the current ordering or there will be regressions in
> some odball configurations.
> 
> What about walking (a) creating a list of things that have "PNP0C02" in their
> list of PNP IDs and (b) walking that list after we've completed the initial
> scan and reserving the resources for the ones that still have no drivers?
> 
hmmm, first of all, a question, say, for a device have _CID "PNP0C02"
and _HID, if we want to bind the _HID, what should we do?
should we reserve the resources before loading the _HID driver, and free
the resources after unloading the _HID driver?
or should we always reserve such resources, no matter if the _HID driver
is loaded or not?

If it is the latter one, then IMO, we can use a scan handler to reserve
the resources, before all the other handlers.
If it is the first one, then it's much more complex, because what we
want is to make "PNP0C02" resource reservation work as a "shadow"
driver, which only takes effect when there is no other driver binded.

thanks,
rui
> That should preserve the current behavior at least, shouldn't it?
> 
> Thanks,
> Rafael
> 


