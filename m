From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: Possible mem leak in drivers handling multiple HIDs with single driver->ops.add
Date: Fri, 3 Mar 2006 15:21:16 +0800
Message-ID: <756b48450603022321t66ae776dj41078b729d319ee0@mail.gmail.com>
References: <756b48450602180252h666256fo1cb9a2bf78b9deea@mail.gmail.com>
	 <200602211033.31720.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:56649 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752074AbWCCHVR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Mar 2006 02:21:17 -0500
Received: by pproxy.gmail.com with SMTP id z74so247720pyg
        for <linux-acpi@vger.kernel.org>; Thu, 02 Mar 2006 23:21:16 -0800 (PST)
In-Reply-To: <200602211033.31720.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On 2/22/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> But the loop body in acpi_driver_attach() is only executed once
> per device (not once per device ID), so acpi_bus_driver_init() is
> called at most once per device.  And acpi_bus_driver_init() calls
> the .add() method only once.
>
> I don't see the scenario you're concerned about.  Did I miss
> something?
>

The scenario I was asking about is different. I'm asking whether it's
possible that a system has multiple ACPI devices that each have at
least one HID that maps to a single driver add(). Here's a scenario I
was thinking about, let's say the BIOS states that I have an ACPI
device that handle miscellaneous control buttons:
        Device (FOO1)
        {
            Name (_HID, "PNP0C0D")

and on the same system, the BIOS states that I have another ACPI
device that handles the power button:
        Device (FOO2)
        {
            Name (_HID, "ACPI_FPB")

then this scenario would result in button.c's add() getting called twice. Right?

Thanks,
jayakumar
