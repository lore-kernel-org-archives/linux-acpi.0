From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Possible mem leak in drivers handling multiple HIDs with single driver->ops.add
Date: Fri, 3 Mar 2006 09:06:13 -0700
Message-ID: <200603030906.13851.bjorn.helgaas@hp.com>
References: <756b48450602180252h666256fo1cb9a2bf78b9deea@mail.gmail.com> <200602211033.31720.bjorn.helgaas@hp.com> <756b48450603022321t66ae776dj41078b729d319ee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:61061 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030227AbWCCQGR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2006 11:06:17 -0500
In-Reply-To: <756b48450603022321t66ae776dj41078b729d319ee0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 03 March 2006 00:21, Jaya Kumar wrote:
> On 2/22/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > But the loop body in acpi_driver_attach() is only executed once
> > per device (not once per device ID), so acpi_bus_driver_init() is
> > called at most once per device.  And acpi_bus_driver_init() calls
> > the .add() method only once.
> >
> The scenario I was asking about is different. I'm asking whether it's
> possible that a system has multiple ACPI devices that each have at
> least one HID that maps to a single driver add(). Here's a scenario I
> was thinking about, let's say the BIOS states that I have an ACPI
> device that handle miscellaneous control buttons:
>         Device (FOO1)
>         {
>             Name (_HID, "PNP0C0D")
> 
> and on the same system, the BIOS states that I have another ACPI
> device that handles the power button:
>         Device (FOO2)
>         {
>             Name (_HID, "ACPI_FPB")
> 
> then this scenario would result in button.c's add() getting called twice. Right?

Yes.  But you have two devices, and acpi_button_add() will get called
once for each of them, which is exactly what we want.  Your original
question was about this line in acpi_button_add():

311         button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);

This kmalloc will happen for every button device, but the pointer is
attached to the acpi_device:

        acpi_driver_data(device) = button;

and the corresponding kfree is in acpi_button_remove().

If you still think there is a problem, maybe it will be clear to me
if you post the patch to fix it.

Bjorn
