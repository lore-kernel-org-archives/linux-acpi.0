From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Sun, 6 Nov 2011 14:30:53 +0100
Message-ID: <201111061430.53293.rjw@sisk.pl>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110311147.40546.trenn@suse.de> <CAL-B5D0MfHZZY7CUbPBxY6_zD_dBpDzk1mas_eE-RF_pK7o38g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53024 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab1KFN2S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Nov 2011 08:28:18 -0500
In-Reply-To: <CAL-B5D0MfHZZY7CUbPBxY6_zD_dBpDzk1mas_eE-RF_pK7o38g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On Thursday, November 03, 2011, Myron Stowe wrote:
> On Mon, Oct 31, 2011 at 4:47 AM, Thomas Renninger <trenn@suse.de> wrote:
> > On Friday 28 October 2011 17:03:03 Bjorn Helgaas wrote:
> >> On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wrote:
> >> > On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
> >> > ..
> >> >> Myron Stowe (2):
> >> >>       ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() and remove ./drivers/acpi/atomicio.[ch]
> >> >>       ACPI: Export interfaces for ioremapping/iounmapping ACPI registers
> >> >
> >> > Would be great to know whether these are going to be accepted.
> >> > If yes, this check should get removed as well:
> >> >
> >> > drivers/acpi/acpica/hwregs.c:
> >> > acpi_status
> >> > acpi_hw_validate_register(struct acpi_generic_address *reg,
> >> >                          u8 max_bit_width, u64 *address)
> >> > {
> >> > ...
> >> >        if (reg->bit_offset != 0) {
> >> >                ACPI_WARNING((AE_INFO,
> >> >                              "Unsupported register bit offset: 0x%X",
> >> >                              reg->bit_offset));
> >> >        }
> >> >
> >> > because APEI GAR declarations do use bit_offset != 0.
> >>
> >> Half of this makes sense to me.  Myron's patch changes APEI from using
> >> acpi_atomic_read() (which doesn't call acpi_hw_validate_register()) to
> >> using acpi_read(), which *does* call it.  So after Myron's patch,
> >> we'll see warnings we didn't see before.
> >>
> >> The part that doesn't make sense to me is just removing the warning.
> >> That warning looks to me like it's saying "oops, here's something we
> >> should support, but haven't implemented yet."  Wouldn't it be better
> >> to implement support for bit_offset in acpi_read() at the same time we
> >> remove the warning?  Then Myron could update his patch to drop the
> >> bit_offset support in __apei_exec_read_register() when converting to
> >> acpi_read().
> >>
> >> If APEI uses bit_offset != 0, it's at least possible that other areas
> >> will use it in the future, and it'd be nicer to have all the support
> >> in acpi_read() rather than forcing APEI and others to each implement
> >> their own support for it.
> > Googling for the warning:
> > "Unsupported register bit offset"
> > only points to code snippets.
> > The code needs to be compatible with a long history of ACPI table
> > implementations (the reason why I thought to keep bit offset handling
> > in APEI code for now is the safer approach). But bit_offset != 0 seem
> > to only appear in latest APEI table implementations.
> > Looks like this condition was never run into and it should be safe
> > to add bit offset support to these generic parts.
> > -> I agree that bit offset handling can/should get added there.
> >
> 
> We all seem to agree that bit offset handling can/should get added to the
> generic parts at some point.
> 
> As for APEI specifically and my patch to remove atomicio.[ch] I think we
> should add code prior to the converted 'acpi_read'/'acpi_write' calls to copy
> the GAS structure parameter onto the local stack and zero out the
> gas.bit_offset value as in:
> 
>   struct acpi_generic_address gas;  /* on local stack */
>   gas = entry->register_region;
>   gas.bit_offset = 0;
>   acpi_read(val, &gas);
> 
> This should cover the three issues that Thomas pointed out: "unsupported
> register bit offset" warnings, invalid bit_width entries in APEI GAR entries,
> and GAR structures located in reserved BIOS areas that need to be
> treated as const.
> 
> As for invalid bit_width entries in APEI GAR entries - atomicio.c currently
> ignores bit_offset so the approach above of clearing out such should be
> safe in this context.

This might work as well, but I wonder if it has any impact on performance?

> The above would also _not_ introduce "unsupported register bit offset"
> warnings that were not there before although it might be nice to wrap the
> above GAS copying and gas.bit_offset clearing out into a wrapper routine
> and add a 'warn_once' within such indicating that we are ignoring a non-
> zero bit_offset.  These warnings should be harmless in APEI context but
> are admittedly alarming.
> 
> Lastly, the above addition also mitigates any modification of GAR structures
> in the 'acpi_read'/'acpi_write' call paths.
> 
> Let me know what you all think and thanks Thomas for bringing these
> issues to light.

We cat do this to start with, IMO, and then move to something more elaborate
if there are any problems.

Thanks,
Rafael
