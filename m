From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Wed, 02 Dec 2015 15:37:22 +0100
Message-ID: <1511399.A7Ia5eFWOM@vostro.rjw.lan>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com> <1449023684.22697.14.camel@rzhang1-mobl4> <13177559.3ZmjZKOO1k@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54004 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757791AbbLBOHd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 09:07:33 -0500
In-Reply-To: <13177559.3ZmjZKOO1k@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wednesday, December 02, 2015 01:22:16 PM Rafael J. Wysocki wrote:
> On Wednesday, December 02, 2015 10:34:44 AM Zhang Rui wrote:
> > On Wed, 2015-12-02 at 02:18 +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, December 01, 2015 03:25:41 AM Zhang, Rui wrote:
> > > > Hi, all,
> > > > 
> > > > The problem here is that the ACPI device node has
> > > >             Name (_HID, "INT33D5")  // _HID: Hardware ID
> > > >             Name (_CID, "PNP0C02" /* PNP Motherboard Resources */)  //
> > > > _CID: Compatible ID
> > > > 
> > > > Andy wants to write a driver for INT33D5 device, but unfortunately
> > > > 1. _CID "PNP0C02" makes it impossible to bind via platform bus
> > > > 2. Lacking of _CRS makes it impossible to bind via PNP bus.
> > > > 
> > > > I've seen similar problem before, and the solution is to ask BIOS people to remove the _CID "PNP0C02".
> > > 
> > > What if they refuse?
> > 
> > Well, we don't have a kernel solution for this case so far.
> > > 
> > > > IMO, such AML code does not make sense at all (even if _CRS is provided), because in this case, the _CID and the _HID of the same ACPI device node actually represent two totally different devices.
> > > 
> > > That's correct.  I guess this is a hack for Windows to prevent it from
> > > displaying "yellow bangs" for devices without "real" drivers.
> > 
> > Does this mean that the Windows "PNP0C02" driver won't prevent any other
> > driver from probing its devices?
> > > 
> > > > OR, a clean way to fix this in Linux is to make the motherboard resource reservation stuff a function call instead of a driver, and invoke the function call in either PNP or ACPI bus code by checking "PNP0C02". In this case, only the device id that represents the physical device (INT33D5 in this case) can be used for device enumeration and driver probing.
> > > 
> > > OK, but we need to keep the current ordering or there will be regressions in
> > > some odball configurations.
> > > 
> > > What about walking (a) creating a list of things that have "PNP0C02" in their
> > > list of PNP IDs and (b) walking that list after we've completed the initial
> > > scan and reserving the resources for the ones that still have no drivers?
> > > 
> > hmmm, first of all, a question, say, for a device have _CID "PNP0C02"
> > and _HID, if we want to bind the _HID, what should we do?
> > should we reserve the resources before loading the _HID driver, and free
> > the resources after unloading the _HID driver?
> 
> No, we shouldn't.  Handling the resources is up to the driver then.

Actually, scratch that.

We should register IO and memory resources for everything with _CRS to prevent
them from being allocated to something else (and possibly use _PRS/_SRS if
available to resolve conflicts).

If we do that, we won't need the special driver for "PNP0C02" at all.

Thanks,
Rafael

