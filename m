From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Sun, 6 Nov 2011 14:19:17 +0100
Message-ID: <201111061419.17460.rjw@sisk.pl>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52957 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab1KFNQk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Nov 2011 08:16:40 -0500
In-Reply-To: <201110280349.26410.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com, bhelgaas@google.com

On Friday, October 28, 2011, Thomas Renninger wrote:
> On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
> ..
> > Myron Stowe (2):
> >       ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() and remove ./drivers/acpi/atomicio.[ch]
> >       ACPI: Export interfaces for ioremapping/iounmapping ACPI registers
> 
> Would be great to know whether these are going to be accepted.
> If yes, this check should get removed as well:
> 
> drivers/acpi/acpica/hwregs.c:
> acpi_status
> acpi_hw_validate_register(struct acpi_generic_address *reg,
>                           u8 max_bit_width, u64 *address)
> {
> ...
>         if (reg->bit_offset != 0) {
>                 ACPI_WARNING((AE_INFO,
>                               "Unsupported register bit offset: 0x%X",
>                               reg->bit_offset));
>         }
> 
> because APEI GAR declarations do use bit_offset != 0.
> 
> There is another problem. Would be great to get some opinions/feedback
> on it already:
> APEI GAR entries seem to have invalid bit_width entries on some platforms.
> After looking at several tables, I expect that with APEI tables access width
> (in bytes) should get used instead, Windows seem to ignore bit width fields,
> at least for APEI tables.

There are a couple of things we could do.  First, ignore the widths as Windows
does (but that would make the code a bit fragile).  Second, replace the invalid
widths with something sane when (or right after) loading the APEI tables.

Is there any automatic check we can use to detect if the BIOS-provided widths
are invalid?

> I have patches but I need to know whether your patches are accepted.
> 
> There also is a problem with modifying GAR bit_width field to be able to
> pass it to the generic acpica functions (what your patches are doing).

What patches are you referring to, I don't see anything like this in [1/2]
and [2/2]?

> The problem is that the structures are located in reserved BIOS areas and
> they should be const and not get modified.

But we can cache them, can't we?

> I have 2 solutions for this:
>   1) Make apei_check_gar() pass 2 struct acpi_generic_address:
>      int apei_check_gar(struct acpi_generic_address *reg,
>                     const struct acpi_generic_address *orig, u64 *paddr)
>      orig -> is the one located in reserved mem area, mapped to virtual addr space
>      reg  -> will be a copy of it, possibly with bit_width adjusted which then
>             can be passed to acpi_memory_read/write and friends.
>   2) Allocate memory and copy whole APEI tables
> 
> 1. Should have the advantage of less memory waste
> 2. Should have the advantage of a bit nicer code (kalloc and memcpy per table) and
>    if more things like this happen, tables could get adjusted easily.
>    It also has the advantage that GAR structures do not need to get double
>    checked and eventually adjusted at runtime again.
> 
> Below is the first patch which goes for 1. More patches may be needed, but I
> as said, I need to know whether your patches get accepted.
> What do you think?

I'd go for 2.  Really, it's not like we have a shortage of memory on the
affected systems and it's so much simpler than the alternative that I'm
not sure if the alternative makes sense at all.

Thanks,
Rafael
