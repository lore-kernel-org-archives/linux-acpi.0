From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Possible mem leak in drivers handling multiple HIDs with single driver->ops.add
Date: Sat, 18 Feb 2006 05:52:54 -0500
Message-ID: <756b48450602180252h666256fo1cb9a2bf78b9deea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:62123 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750997AbWBRKwz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Feb 2006 05:52:55 -0500
Received: by zproxy.gmail.com with SMTP id z3so568868nzf
        for <linux-acpi@vger.kernel.org>; Sat, 18 Feb 2006 02:52:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi ACPI folk,

I was looking at the following ACPI code in 2.6.16-rc3. I'm trying to
understand if there maybe a possible memory leak in the following
scenario. Here's what I see:

drivers/acpi/button.c calls:
464         result = acpi_bus_register_driver(&acpi_button_driver);

with acpi_button_driver containing:
 77         .ids = "ACPI_FPB,ACPI_FSB,PNP0C0D,PNP0C0C,PNP0C0E",

Now, acpi_bus_register_driver calls acpi_driver_attach which does the following:
560         list_for_each_safe(node, next, &acpi_device_list) {
...
568                 if (!acpi_bus_match(dev, drv)) {
569                         if (!acpi_bus_driver_init(dev, drv)) {

In iterating over the acpi_device_list, are there possible scenarios
of hardware containing multiple matching HIDS where acpi_bus_match
(which matches individual device HIDs to the driver's supported .ids)
ends up matching for a single driver and then calling
acpi_bus_driver_init which ends up calling that single driver's add
function multiple times:

514         result = driver->ops.add(device);

In the button.c case, this calls:

300 static int acpi_button_add(struct acpi_device *device)
...
311         button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);

In which case, acpi_button_add is called multiple times and we leak
all but the last kmalloc of button, as well as other stuff like proc
setup, etc.

To summarize the question, is it possible for one overall ACPI setup
to have multiple HIDs that then map to a single driver's add function?
If so, then I believe that button.c and container.c could leak memory.

If you think that this situation is possible, then I'll do a small
patch to fixup button.c and container.c.

Thanks,
jayakumar
