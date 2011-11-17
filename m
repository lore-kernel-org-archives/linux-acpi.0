From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset
 in acpi_read/write
Date: Wed, 16 Nov 2011 17:15:28 -0700
Message-ID: <CAErSpo49CSmB8hNW0Cecfs8WkxMPTpeYV=5Fat-OiB-nC9gj5g@mail.gmail.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
 <201111151749.53917.trenn@suse.de> <CAErSpo6E6ZLRMhLjE1zHjth=gO-LrhnTz=msRjY7mfG4ckCLfw@mail.gmail.com>
 <201111162058.09549.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60828 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1KQAPt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2011 19:15:49 -0500
Received: by ggnb2 with SMTP id b2so365786ggn.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2011 16:15:49 -0800 (PST)
In-Reply-To: <201111162058.09549.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Wed, Nov 16, 2011 at 12:58 PM, Thomas Renninger <trenn@suse.de> wrot=
e:
> On Wednesday 16 November 2011 16:45:11 Bjorn Helgaas wrote:

>> We should try very hard to treat APEI generic address structures the
>> same way as all others. =A0If that means some machines need firmware
>> upgrades or some sort of quirks to work around BIOS bugs, we might
>> have to accept that. =A0I think a single set of GAS accessors plus a=
 few
>> quirks that fix the GAS structures is far better than having
>> APEI-specific GAS accessors that are basically tailored to a few
>> broken machines.
> That does not account that Windows possibly also has duplicated GAS
> parsing code in their APEI subsystem/driver.
>
> Most APEI GAS structures have the mask value which makes bit_width
> needless/redundant.
>
> It's not unlikely that: Windows only ignores
> bit width on APEI GAS structures with a mask value (HEST table only?)=
=2E
> Then quirking specific BIOSes is a bad idea, we want to resolve this
> in a generic way and the only possibility (as so often) could be to
> do it the same way we expect Windows does it. And if they have
> duplicated GAS parsing code, we might need it as well.
> Therefore I would not rush with making APEI code using the generic
> interfaces. Possibly it's even wrong and will never happen.
>
> I'd like to see an APEI GAS parsing code being able to handle all
> (say as much as possible) APEI tables correctly first.

There's a lot of speculation above about Windows duplicating GAS
parsing, using mask instead of bit_width, etc.  I don't think we have
good evidence for it.  In general, my experience is that Windows has a
pretty high-quality ACPI implementation (though obviously it sometimes
interprets things differently than Linux), so I hesitate to assume
special cases like this in Windows.

APEI support in BIOSes is immature, and I don't want to hard-code
assumptions into Linux based on a few possibly defective BIOSes.
Assumptions like that will constrain us in the future.

>> Or maybe we could learn enough from a conversation with BIOS writers
>> about how they interpret the spec and what they expect to happen wit=
h
>> non-zero bit_offset and bit_width.
> You could try at a conference after some beers... This is extra diffi=
cult,
> because of the NDA coverage of the Whea spec.

I disagree.  The simple question "how do you expect the OS to
interpret this GAS?" has nothing to do with any Windows NDA.

You seem to have a nice collection of DSDT/APEI/etc tables.  Can you
get any idea of how many of them contain GAS structures that would
break under my proposal
(https://docs.google.com/spreadsheet/ccc?key=3D0AjvKas55tQpqdElKVXM2TEF=
VcnI3SjVuZ1pqUENMN1E)?

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
