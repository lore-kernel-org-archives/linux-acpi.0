From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Thu, 3 Nov 2011 19:55:03 -0600
Message-ID: <CAL-B5D1jkcH9+U=WeN+18ROn4kYMz14MxOnkEYjenr8ciDh8WQ@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	<201111031718.24291.trenn@suse.de>
	<CAL-B5D3ftTdqP8YNLn8y8HWgAEaq7bnq0EA328RBVHLXnE+4Tg@mail.gmail.com>
	<201111040316.33585.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47322 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab1KDBzF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2011 21:55:05 -0400
Received: by vcge1 with SMTP id e1so1711587vcg.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 Nov 2011 18:55:04 -0700 (PDT)
In-Reply-To: <201111040316.33585.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Thu, Nov 3, 2011 at 8:16 PM, Thomas Renninger <trenn@suse.de> wrote:
> On Thursday 03 November 2011 17:44:06 Myron Stowe wrote:
>> On Thu, Nov 3, 2011 at 10:18 AM, Thomas Renninger <trenn@suse.de> wr=
ote:
>> > On Thursday, November 03, 2011 02:53:09 PM Bjorn Helgaas wrote:
>> >> On Thu, Nov 3, 2011 at 3:16 AM, Thomas Renninger <trenn@suse.de> =
wrote:
>> >> > On Monday, October 31, 2011 04:51:07 PM Bjorn Helgaas wrote:
>> >> >> On Mon, Oct 31, 2011 at 4:33 AM, Thomas Renninger <trenn@suse.=
de> wrote:
>> >> >
>> >> >> Seems like these are BIOS bugs. =A0Do we know for sure that Wi=
ndows
>> >> >> consumes this information that seems to be wrong? =A0Have you =
had a
>> >> >> conversation with the vendor about whether the BIOS is at faul=
t here?
>> >> > Such closed specifications between a major OS and specific HW v=
endors
>> >> > should be forbidden by law and I expect in some countries you'l=
l win
>> >> > if you contest this contract in a high enough court...
>> >> > APEI is based on the Windows WHEA specification which only spec=
ific
>> >> > vendors can retrieve from Windows if they sign an NDA contract.
>> >> > I could imagine there you find details about the GAS structure =
usage
>> >> > in WHEA/APEI tables the way Windows like it.
>> >> >
>> >> > After looking at quite a lot APEI tables and their bit width, b=
yte access
>> >> > and mask values, I am pretty sure bit width is ignored on Windo=
ws.
>> >> > Or say, if these tables are used, access width is always correc=
t while
>> >> > bit width is not.
>> >> >
>> >> >> If we make Linux ignore the bit_width, that might "fix" these =
boxes
>> >> >> with broken BIOSes, but at the cost of breaking a box that use=
s
>> >> >> bit_width correctly.
>> >> > None of the "broken bit width" boxes I looked at should break i=
f
>> >> > access width is used.
>> >>
>> >> Yes, but bit_width is a standard part of the ACPI generic address
>> >> structure, and there's nothing to prevent a future BIOS from usin=
g it
>> >> and expecting it to work as documented.
>> > Yep, but access width is also part of the standard ACPI generic ad=
dress
>> > structure and currently gets totally ignored and bit width is used=
 instead.
>> >
>> > I just realized: what code is using acpi_read?
>> > I can't find any user...
>> >
>> > So we can either:
>> > =A0- modify acpi_read/write and implement things as needed -> nobo=
dy
>> > =A0 =A0uses it
>> > =A0- as acpi_read is acpica code we can for now leave this in apei=
 parts
>> > =A0 =A0(still consolidate duplicate code from atomicio.c, remove p=
re_map
>> > =A0 =A0stuff and the whole atomicio.c file) and still keep apei_ac=
pi_read
>> > =A0 =A0for now in apei-base.c. There we can implement what we like=
 to see
>> > =A0 =A0in acpi_read:
>> > =A0 =A0 =A0 - if access width is zero -> use bit width to determin=
e how many
>> > =A0 =A0 =A0 =A0 bytes have to be read
>> > =A0 =A0 =A0 - otherwise use access width
>> >
>> > Also an APEI version for apei_check_gar in apei-base.c isn't that =
bad
>> > for now.
>> >
>> > As there are no users of acpi_read and acpi_write yet, it might be=
 a good
>> > idea for now if this function simply reads the amount of bytes as
>> > described above and leave it up to the caller to cut off any bytes
>> > using bit width, bit offset or (for APEI GAR structs only) using t=
he mask.
>> > (As done by current APEI code, unfortunately twice).
>> >
>>
>> For now, I would like to continue with converting APEI to remove ato=
micio.[ch]
>> preserving the existing atomicio behavior - basically the same patch=
 I posted
>> a few weeks ago with the additions mentioned last night.
> You mean this:
> =A0struct acpi_generic_address gas; =A0/* on local stack */
> =A0gas =3D entry->register_region;
> =A0gas.bit_offset =3D 0;
> =A0acpi_read(val, &gas);
>
>
>> This would leave the more generic code (osl.c) unbiased for now. =A0=
We can
>> then account for all the APEI uniqueness - bit_width/access_width/ma=
sk -
>> in APEI code, not in the more generic code.
> Better don't use acpi_read (and thus also acpi_hw_validate_register()=
) in a
> first step. This is acpica code and modifying it in -rcX releases is =
not
> a good idea. acpi_read/write also might be used on other OSes (even l=
ikely,
> this would explain why it's unused on Linux) and getting changes in t=
here
> could get really difficult.

Yes, while I would like to end up with such (converting to acpi_read/ac=
pi_write)
eventually it's obvious now that we would need to augment them to handl=
e
GAS 'bit_offset' fields properly which, as you point out, may be a long
slow road.

Just an FYI; Bjorn pointed out that acpi_read is currently used in Linu=
x in
cpufreq.

> Also above "gas.bit_offset =3D 0" is not nice and not needed for now:
> Better copy over acpi_atomic_write, acpi_atomic_read and acpi_check_g=
ar()
> to apei-base.c (declaring them in apei-internal.h should be enough).
> apei_write, apei_read and apei_check_gar should be better names.
>
> I fully agree with:
>> I would like to continue with converting APEI to remove atomicio.[ch=
]
>> preserving the existing atomicio behavior
>
> You might want to add "considering access width" as I suggested or si=
milar.
> Or I can go on top later.
>
>> As far as I can tell, the two paths each of us want to take do not s=
eem to
>> interfere with each other.
> We are on the same road.
>
>> Do you see, or have, any issues with that approach?
> It's only the "use generic acpi_read/write()" issue.
> Let's better try to get rid of apei_read/write/check_gar specific fun=
ctions
> in a second step (the functions I suggested above to get copied from =
atomicio.c
> (from acpi_atomic_read/write and acpi_check_gar()) to apei-base.c and
> enhanced with access width considerations) and incorporate this
> into acpica after acpica people had more time and a closer look at th=
is.

Ok, I'll start working on a cut of -v2 tomorrow - it's getting late for=
 me.

Thanks,
 Myron
>
> =A0 =A0 Thomas
>
>> Thanks,
>> =A0Myron
>> >> If we make Linux
>> >> ignore/override the bit_width now, we'll build a legacy of machin=
es
>> >> that depend on the fact that we ignore it, and then we would have=
 no
>> >> way to deal with future machines that might expect us to pay atte=
ntion
>> >> to it.
>> > bit width is not ignored it should get used if access width is zer=
o or
>> > also to cut off bits.
>> > It can get ignored for APEI tables as the mask value already defin=
es
>> > which bits should get used and therefore seem to be ignored on oth=
er
>> > OSes.
>> >
>> > =A0 Thomas
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
