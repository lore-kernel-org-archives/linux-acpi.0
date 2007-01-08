From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Sun, 7 Jan 2007 22:08:07 -0700
Message-ID: <200701072208.07831.bjorn.helgaas@hp.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com> <200701031329.34665.bjorn.helgaas@hp.com> <1e2af89e0701071210i3efc9f50w635013f7ec0b0a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:58879 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161128AbXAHFIO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jan 2007 00:08:14 -0500
In-Reply-To: <1e2af89e0701071210i3efc9f50w635013f7ec0b0a32@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Brett <matthew.brett@gmail.com>
Cc: linux-acpi@vger.kernel.org, konstantin.a.karasyov@intel.com

On Sunday 07 January 2007 13:10, Matthew Brett wrote:
> I am sorry, I am a bit lost.  Should I expect replacing:
> 
> > +       device->flags.force_power_state = 1;
> > +       acpi_bus_set_power(device->handle, state);
> > +       device->flags.force_power_state = 0;
> 
> with:
> 
> > +       if (state == ACPI_STATE_D0)
> > +               acpi_bus_set_power(fan->handle, ACPI_STATE_D3);
> > +       else if (state == ACPI_STATE_D3)
> > +               acpi_bus_set_power(fan->handle, ACPI_STATE_D0);
> > +       acpi_bus_set_power(fan->handle, state);
> 
> in fan.c from 2.6.20-rc3 should solve the problem (replacing
> fan->handle with device->handle)?  It does not seem to.

I think the "acpi_bus_set_power" call was added after
2.6.17.  So if you remove it, I suspect your fan might work
like it used to.

I doubt that's the correct fix, though, because that call
was probably added for a reason.  Konstantin can probably
speak to that.

If you feel like experimenting, you could print out what
state the BIOS tells you the fan is in (from the
acpi_bus_get_power() call), try setting it to either
ACPI_STATE_D0 or ACPI_STATE_D3, and see what the fan does.
