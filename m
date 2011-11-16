From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset in acpi_read/write
Date: Wed, 16 Nov 2011 20:58:08 +0100
Message-ID: <201111162058.09549.trenn@suse.de>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <201111151749.53917.trenn@suse.de> <CAErSpo6E6ZLRMhLjE1zHjth=gO-LrhnTz=msRjY7mfG4ckCLfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab1KPT6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Nov 2011 14:58:15 -0500
In-Reply-To: <CAErSpo6E6ZLRMhLjE1zHjth=gO-LrhnTz=msRjY7mfG4ckCLfw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Wednesday 16 November 2011 16:45:11 Bjorn Helgaas wrote:
> On Tue, Nov 15, 2011 at 9:49 AM, Thomas Renninger <trenn@suse.de> wrote:
> > On Tuesday, November 15, 2011 04:13:15 PM Bjorn Helgaas wrote:
> >> On Fri, Nov 11, 2011 at 4:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> > acpi_read(), acpi_write(), acpi_hw_read(), and acpi_hw_write() currently
> >> > ignore the GAS bit_offset field (but they do warn if it is non-zero).
> >> >
> >> > APEI tables are starting to use non-zero bit_offsets.  APEI uses
> >> > special-purpose apei_exec_read_register() and apei_exec_write_register()
> >> > interfaces that apply the bit_offset.
> >> >
> >> > This patch adds bit_offset support to the generic interfaces, which is
> >> > one small step toward using them instead of the special-purpose APEI ones.
> >>
> >> Eww, brown paper bag time.  Just pretend you never saw this lame
> >> implementation attempt.
> >>
> >> I do think we need to make acpi_read() smart enough to extract a bit
> >> field, but this try doesn't work.
> >
> > As a first step it would be great if Ying's and Myron's patches which
> > afaik conflict get serialized and pushed into an "acpi branch".
> > What the status there?
> 
> Ying's patch ("Add RAM mapping support") fixes a real issue with using
> EINJ, so we need to do something with it.  Myron's patches are a nice
> refactoring, but as far as I know, they don't fix any current issues,
> and there's still a lot of work to hash out how to handle bit_offset,
> bit_width, and access_width.
> 
> I think we should regard Ying's patches as being first in line, and
> Myron's as work in progress.  So I don't think we're ready to try to
> combine them and resolve conflicts yet -- Myron just has to update his
> work to follow whatever Ying does.
> 
> > I'd like to add access width support to the APEI parts on top then.
> 
> We should try very hard to treat APEI generic address structures the
> same way as all others.  If that means some machines need firmware
> upgrades or some sort of quirks to work around BIOS bugs, we might
> have to accept that.  I think a single set of GAS accessors plus a few
> quirks that fix the GAS structures is far better than having
> APEI-specific GAS accessors that are basically tailored to a few
> broken machines.
That does not account that Windows possibly also has duplicated GAS
parsing code in their APEI subsystem/driver.

Most APEI GAS structures have the mask value which makes bit_width
needless/redundant.

It's not unlikely that: Windows only ignores
bit width on APEI GAS structures with a mask value (HEST table only?).
Then quirking specific BIOSes is a bad idea, we want to resolve this
in a generic way and the only possibility (as so often) could be to
do it the same way we expect Windows does it. And if they have
duplicated GAS parsing code, we might need it as well.
Therefore I would not rush with making APEI code using the generic
interfaces. Possibly it's even wrong and will never happen.

I'd like to see an APEI GAS parsing code being able to handle all
(say as much as possible) APEI tables correctly first.

> To make acpi_read/acpi_write truly generic, we really need to nail
> down the semantics of GAS bit_offset, bit_width, and access_width.
> 
> It would be useful to know how Windows deals with those.  I don't
> think we have convincing information about it (all I remember is
> "here's a GAS that looks wrong, but Windows still works," but I don't
> think we know exactly *what* Windows is doing, or even whether it
> looks at the broken GAS).  If we could figure out a way to feed a
> variety of structures to Windows and observe what happens with
> something like qemu, I think we'd learn a lot.
Sure, but we should not wait until someone (possibly never) comes up
with it, but make the APEI GAS parsing code to work with as much BIOSes
as possible in a generic way.
A 64 bit address cut down to 8 bits obviously is wrong. I agree that if
possible, such a condition should get checked and a firmware bug message
is appropriate.

> Or maybe we could learn enough from a conversation with BIOS writers
> about how they interpret the spec and what they expect to happen with
> non-zero bit_offset and bit_width.
You could try at a conference after some beers... This is extra difficult,
because of the NDA coverage of the Whea spec.

   Thomas
