From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset
 in acpi_read/write
Date: Wed, 16 Nov 2011 08:45:11 -0700
Message-ID: <CAErSpo6E6ZLRMhLjE1zHjth=gO-LrhnTz=msRjY7mfG4ckCLfw@mail.gmail.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
 <20111111230513.20897.36014.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo7SJNM73ei5aN=9UCsvgU6OZoupWUoUP3Hts3GGfwE37A@mail.gmail.com> <201111151749.53917.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59727 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab1KPPpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2011 10:45:31 -0500
Received: by ggnb2 with SMTP id b2so8931234ggn.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2011 07:45:31 -0800 (PST)
In-Reply-To: <201111151749.53917.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Tue, Nov 15, 2011 at 9:49 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Tuesday, November 15, 2011 04:13:15 PM Bjorn Helgaas wrote:
>> On Fri, Nov 11, 2011 at 4:05 PM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> > acpi_read(), acpi_write(), acpi_hw_read(), and acpi_hw_write() cur=
rently
>> > ignore the GAS bit_offset field (but they do warn if it is non-zer=
o).
>> >
>> > APEI tables are starting to use non-zero bit_offsets. =A0APEI uses
>> > special-purpose apei_exec_read_register() and apei_exec_write_regi=
ster()
>> > interfaces that apply the bit_offset.
>> >
>> > This patch adds bit_offset support to the generic interfaces, whic=
h is
>> > one small step toward using them instead of the special-purpose AP=
EI ones.
>>
>> Eww, brown paper bag time. =A0Just pretend you never saw this lame
>> implementation attempt.
>>
>> I do think we need to make acpi_read() smart enough to extract a bit
>> field, but this try doesn't work.
>
> As a first step it would be great if Ying's and Myron's patches which
> afaik conflict get serialized and pushed into an "acpi branch".
> What the status there?

Ying's patch ("Add RAM mapping support") fixes a real issue with using
EINJ, so we need to do something with it.  Myron's patches are a nice
refactoring, but as far as I know, they don't fix any current issues,
and there's still a lot of work to hash out how to handle bit_offset,
bit_width, and access_width.

I think we should regard Ying's patches as being first in line, and
Myron's as work in progress.  So I don't think we're ready to try to
combine them and resolve conflicts yet -- Myron just has to update his
work to follow whatever Ying does.

> I'd like to add access width support to the APEI parts on top then.

We should try very hard to treat APEI generic address structures the
same way as all others.  If that means some machines need firmware
upgrades or some sort of quirks to work around BIOS bugs, we might
have to accept that.  I think a single set of GAS accessors plus a few
quirks that fix the GAS structures is far better than having
APEI-specific GAS accessors that are basically tailored to a few
broken machines.

To make acpi_read/acpi_write truly generic, we really need to nail
down the semantics of GAS bit_offset, bit_width, and access_width.

It would be useful to know how Windows deals with those.  I don't
think we have convincing information about it (all I remember is
"here's a GAS that looks wrong, but Windows still works," but I don't
think we know exactly *what* Windows is doing, or even whether it
looks at the broken GAS).  If we could figure out a way to feed a
variety of structures to Windows and observe what happens with
something like qemu, I think we'd learn a lot.

Or maybe we could learn enough from a conversation with BIOS writers
about how they interpret the spec and what they expect to happen with
non-zero bit_offset and bit_width.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
