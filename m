From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Thu, 3 Nov 2011 10:44:06 -0600
Message-ID: <CAL-B5D3ftTdqP8YNLn8y8HWgAEaq7bnq0EA328RBVHLXnE+4Tg@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	<201111031016.52676.trenn@suse.de>
	<CAErSpo7CTFTCQRPJtAqYM2VnhV4nOWX799YrwCBZTufGZ7rMEQ@mail.gmail.com>
	<201111031718.24291.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61633 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934045Ab1KCQoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2011 12:44:10 -0400
Received: by wyh15 with SMTP id 15so1398314wyh.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 Nov 2011 09:44:09 -0700 (PDT)
In-Reply-To: <201111031718.24291.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Thu, Nov 3, 2011 at 10:18 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Thursday, November 03, 2011 02:53:09 PM Bjorn Helgaas wrote:
>> On Thu, Nov 3, 2011 at 3:16 AM, Thomas Renninger <trenn@suse.de> wro=
te:
>> > On Monday, October 31, 2011 04:51:07 PM Bjorn Helgaas wrote:
>> >> On Mon, Oct 31, 2011 at 4:33 AM, Thomas Renninger <trenn@suse.de>=
 wrote:
>> >
>> >> Seems like these are BIOS bugs. =A0Do we know for sure that Windo=
ws
>> >> consumes this information that seems to be wrong? =A0Have you had=
 a
>> >> conversation with the vendor about whether the BIOS is at fault h=
ere?
>> > Such closed specifications between a major OS and specific HW vend=
ors
>> > should be forbidden by law and I expect in some countries you'll w=
in
>> > if you contest this contract in a high enough court...
>> > APEI is based on the Windows WHEA specification which only specifi=
c
>> > vendors can retrieve from Windows if they sign an NDA contract.
>> > I could imagine there you find details about the GAS structure usa=
ge
>> > in WHEA/APEI tables the way Windows like it.
>> >
>> > After looking at quite a lot APEI tables and their bit width, byte=
 access
>> > and mask values, I am pretty sure bit width is ignored on Windows.
>> > Or say, if these tables are used, access width is always correct w=
hile
>> > bit width is not.
>> >
>> >> If we make Linux ignore the bit_width, that might "fix" these box=
es
>> >> with broken BIOSes, but at the cost of breaking a box that uses
>> >> bit_width correctly.
>> > None of the "broken bit width" boxes I looked at should break if
>> > access width is used.
>>
>> Yes, but bit_width is a standard part of the ACPI generic address
>> structure, and there's nothing to prevent a future BIOS from using i=
t
>> and expecting it to work as documented.
> Yep, but access width is also part of the standard ACPI generic addre=
ss
> structure and currently gets totally ignored and bit width is used in=
stead.
>
> I just realized: what code is using acpi_read?
> I can't find any user...
>
> So we can either:
> =A0- modify acpi_read/write and implement things as needed -> nobody
> =A0 =A0uses it
> =A0- as acpi_read is acpica code we can for now leave this in apei pa=
rts
> =A0 =A0(still consolidate duplicate code from atomicio.c, remove pre_=
map
> =A0 =A0stuff and the whole atomicio.c file) and still keep apei_acpi_=
read
> =A0 =A0for now in apei-base.c. There we can implement what we like to=
 see
> =A0 =A0in acpi_read:
> =A0 =A0 =A0 - if access width is zero -> use bit width to determine h=
ow many
> =A0 =A0 =A0 =A0 bytes have to be read
> =A0 =A0 =A0 - otherwise use access width
>
> Also an APEI version for apei_check_gar in apei-base.c isn't that bad
> for now.
>
> As there are no users of acpi_read and acpi_write yet, it might be a =
good
> idea for now if this function simply reads the amount of bytes as
> described above and leave it up to the caller to cut off any bytes
> using bit width, bit offset or (for APEI GAR structs only) using the =
mask.
> (As done by current APEI code, unfortunately twice).
>

=46or now, I would like to continue with converting APEI to remove atom=
icio.[ch]
preserving the existing atomicio behavior - basically the same patch I =
posted
a few weeks ago with the additions mentioned last night.

This would leave the more generic code (osl.c) unbiased for now.  We ca=
n
then account for all the APEI uniqueness - bit_width/access_width/mask =
-
in APEI code, not in the more generic code.

As far as I can tell, the two paths each of us want to take do not seem=
 to
interfere with each other.  Do you see, or have, any issues with that a=
pproach?

Thanks,
 Myron
>> If we make Linux
>> ignore/override the bit_width now, we'll build a legacy of machines
>> that depend on the fact that we ignore it, and then we would have no
>> way to deal with future machines that might expect us to pay attenti=
on
>> to it.
> bit width is not ignored it should get used if access width is zero o=
r
> also to cut off bits.
> It can get ignored for APEI tables as the mask value already defines
> which bits should get used and therefore seem to be ignored on other
> OSes.
>
> =A0 Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
