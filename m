From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Mon, 31 Oct 2011 11:47:39 +0100
Message-ID: <201110311147.40546.trenn@suse.de>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de> <CAErSpo5waF5Nz92d612tp60bV=oLNyb=yo1xh6_TMhGSvQ07tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57518 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932639Ab1JaJrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Oct 2011 05:47:19 -0400
In-Reply-To: <CAErSpo5waF5Nz92d612tp60bV=oLNyb=yo1xh6_TMhGSvQ07tw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Friday 28 October 2011 17:03:03 Bjorn Helgaas wrote:
> On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wrote:
> > On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
> > ..
> >> Myron Stowe (2):
> >>       ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() and remove ./drivers/acpi/atomicio.[ch]
> >>       ACPI: Export interfaces for ioremapping/iounmapping ACPI registers
> >
> > Would be great to know whether these are going to be accepted.
> > If yes, this check should get removed as well:
> >
> > drivers/acpi/acpica/hwregs.c:
> > acpi_status
> > acpi_hw_validate_register(struct acpi_generic_address *reg,
> >                          u8 max_bit_width, u64 *address)
> > {
> > ...
> >        if (reg->bit_offset != 0) {
> >                ACPI_WARNING((AE_INFO,
> >                              "Unsupported register bit offset: 0x%X",
> >                              reg->bit_offset));
> >        }
> >
> > because APEI GAR declarations do use bit_offset != 0.
> 
> Half of this makes sense to me.  Myron's patch changes APEI from using
> acpi_atomic_read() (which doesn't call acpi_hw_validate_register()) to
> using acpi_read(), which *does* call it.  So after Myron's patch,
> we'll see warnings we didn't see before.
> 
> The part that doesn't make sense to me is just removing the warning.
> That warning looks to me like it's saying "oops, here's something we
> should support, but haven't implemented yet."  Wouldn't it be better
> to implement support for bit_offset in acpi_read() at the same time we
> remove the warning?  Then Myron could update his patch to drop the
> bit_offset support in __apei_exec_read_register() when converting to
> acpi_read().
> 
> If APEI uses bit_offset != 0, it's at least possible that other areas
> will use it in the future, and it'd be nicer to have all the support
> in acpi_read() rather than forcing APEI and others to each implement
> their own support for it.
Googling for the warning:
"Unsupported register bit offset"
only points to code snippets.
The code needs to be compatible with a long history of ACPI table
implementations (the reason why I thought to keep bit offset handling
in APEI code for now is the safer approach). But bit_offset != 0 seem
to only appear in latest APEI table implementations.
Looks like this condition was never run into and it should be safe
to add bit offset support to these generic parts.
-> I agree that bit offset handling can/should get added there.

Still, if Windows has duplicated code for APEI GAR handling (with
additional mask value, for example ignoring bit width) and does it
slightly different than they do it in other parts,
we also might not come around APEI specific GAR checking/workarounds.

   Thomas
