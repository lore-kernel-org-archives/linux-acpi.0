From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 05/28] ACPICA: Hardware: Enable firmware waking vector for both 32-bit and 64-bit FACS.
Date: Fri, 26 Jun 2015 03:41:15 +0200
Message-ID: <2265033.O0oIZqVsfD@vostro.rjw.lan>
References: <cover.1434684719.git.lv.zheng@intel.com> <31220621.6TtT1kp1Fm@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E8802734087@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46323 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751579AbbFZBPF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2015 21:15:05 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802734087@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Friday, June 26, 2015 12:51:39 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Friday, June 26, 2015 8:44 AM
> > 
> > On Thursday, June 25, 2015 12:43:39 AM Zheng, Lv wrote:
> > > Hi, Rafael
> > >
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Thursday, June 25, 2015 7:57 AM
> > > >
> > 
> > [cut]
> > 
> > > > >
> > > > > +/*******************************************************************************
> > > > > + *
> > > > > + * FUNCTION:    acpi_set_firmware_waking_vector
> > > > > + *
> > > > > + * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
> > > > > + *                                    entry point
> > > > > + *              physical_address64  - 64-bit physical address of ACPI protected
> > > > > + *                                    entry point
> > > > > + *
> > > > > + * RETURN:      Status
> > > > > + *
> > > > > + * DESCRIPTION: Sets the firmware_waking_vector fields of the FACS
> > > > > + *
> > > > > + ******************************************************************************/
> > > > > +
> > > > > +acpi_status
> > > > > +acpi_set_firmware_waking_vector(acpi_physical_address physical_address,
> > > > > +				acpi_physical_address physical_address64)
> > > >
> > > > The question here is: Why does the host OS need to care about the second
> > > > argument of this function that will always be 0?  Why didn't you keep the
> > > > old header of acpi_set_firmware_waking_vector() as a one-argument function
> > > > taking a u32 and why didn't you add something like
> > > >
> > > > acpi_status acpi_set_firmware_waking_vector_full(u32 real_mode_address,
> > > > 					acpi_physical_address high_address)
> > > >
> > > > and why didn't you redefine acpi_set_firmware_waking_vector() as
> > > >
> > > > acpi_status acpi_set_firmware_waking_vector(u32 real_mode_address)
> > > > {
> > > > 	return acpi_set_firmware_waking_vector_full(real_mode_address, 0);
> > > > }
> > > >
> > > > ?
> > > >
> > > > If you did that, there wouldn't be any need to touch the code in
> > > > drivers/acpi/sleep.c and the arch headers, so can you please explain to me
> > > > why *exactly* you didn't do that?
> > >
> > > Host OS can set non 0 address for both  real_mode_address and high_address to indicate that it can support both 32-bit and 64-bit
> > resume environments.
> > > So if a BIOS favors 32-bit resume environment, it can resume from here; if another BIOS favors 64-bit resume environment, it can
> > resume from there.
> > > And host OSes can be implemented using only 1 binary to work with both BIOSes.
> > 
> > I'm not talking about that.
> > 
> > It is fine to provide a *new* interface for the OSes that want to do that
> > (if any), but *why* is that regarded as a good enough reason for essentially
> > *removing* the old interface that Linux (and presumably other OSes too) have
> > been using so far?
> 
> Maybe we should ask Bob if we shall just provide a new interfaces for this
> and keep the old ones?

Sure, we can talk to Bob about that.

> According to my understanding, there is no such example in the ACPICA upstream.

Even so, that doesn't necessarily mean it is be impossible.

> Some xxxx_full functions are still pending for being merged by ACPICA upstream,
> they are divergences for now.

And it looks like this particular case will become one more divergence of that
kind.
 
> > 
> > We don't want to pass nonzero as high_address anyway, so why are we *forced* to
> > make pointless changes to non-ACPICA code just to be able to always pass 0
> > as high_address?
> 
> IMO, OSPMs can do this if the cost is not high.
> It seems by following your suggestion, we only need to do slight changes in sleep.c.

Which aren't necessary, right?  And they don't really make things any better.

So I don't see a reason to make them.

Thanks,
Rafael

