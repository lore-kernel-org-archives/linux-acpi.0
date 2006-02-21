From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Possible mem leak in drivers handling multiple HIDs with single driver->ops.add
Date: Tue, 21 Feb 2006 10:33:31 -0700
Message-ID: <200602211033.31720.bjorn.helgaas@hp.com>
References: <756b48450602180252h666256fo1cb9a2bf78b9deea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:47518 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750720AbWBURdi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 12:33:38 -0500
In-Reply-To: <756b48450602180252h666256fo1cb9a2bf78b9deea@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 18 February 2006 03:52, Jaya Kumar wrote:
> ... I'm trying to
> understand if there maybe a possible memory leak in the following
> scenario. Here's what I see:
> 
> drivers/acpi/button.c calls:
> 464         result = acpi_bus_register_driver(&acpi_button_driver);
> 
> with acpi_button_driver containing:
>  77         .ids = "ACPI_FPB,ACPI_FSB,PNP0C0D,PNP0C0C,PNP0C0E",
> 
> Now, acpi_bus_register_driver calls acpi_driver_attach which does the following:
> 560         list_for_each_safe(node, next, &acpi_device_list) {
> ...
> 568                 if (!acpi_bus_match(dev, drv)) {
> 569                         if (!acpi_bus_driver_init(dev, drv)) {
> 
> In iterating over the acpi_device_list, are there possible scenarios
> of hardware containing multiple matching HIDS where acpi_bus_match
> (which matches individual device HIDs to the driver's supported .ids)
> ends up matching for a single driver and then calling
> acpi_bus_driver_init which ends up calling that single driver's add
> function multiple times:
> 
> 514         result = driver->ops.add(device);

An ACPI device may have multiple IDs (a _HID and zero or more _CIDs).

But the loop body in acpi_driver_attach() is only executed once
per device (not once per device ID), so acpi_bus_driver_init() is
called at most once per device.  And acpi_bus_driver_init() calls
the .add() method only once.

I don't see the scenario you're concerned about.  Did I miss
something?

> In the button.c case, this calls:
> 
> 300 static int acpi_button_add(struct acpi_device *device)
> ...
> 311         button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
> 
> In which case, acpi_button_add is called multiple times and we leak
> all but the last kmalloc of button, as well as other stuff like proc
> setup, etc.
> 
> To summarize the question, is it possible for one overall ACPI setup
> to have multiple HIDs that then map to a single driver's add function?
> If so, then I believe that button.c and container.c could leak memory.
> 
> If you think that this situation is possible, then I'll do a small
> patch to fixup button.c and container.c.
> 
> Thanks,
> jayakumar
