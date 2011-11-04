From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Fri, 4 Nov 2011 17:54:39 -0600
Message-ID: <CAL-B5D0Dp8AoMUUJxy58EMdL0k0LRwJ_xa3XRdGT32qrhR0D+g@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	<201110280349.26410.trenn@suse.de>
	<CAErSpo5waF5Nz92d612tp60bV=oLNyb=yo1xh6_TMhGSvQ07tw@mail.gmail.com>
	<201110311147.40546.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52536 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab1KDXyk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2011 19:54:40 -0400
Received: by vcbf1 with SMTP id f1so864928vcb.19
        for <linux-acpi@vger.kernel.org>; Fri, 04 Nov 2011 16:54:39 -0700 (PDT)
In-Reply-To: <201110311147.40546.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Mon, Oct 31, 2011 at 4:47 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Friday 28 October 2011 17:03:03 Bjorn Helgaas wrote:
>> On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wr=
ote:
>> > On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
>> > ..
>> >> Myron Stowe (2):
>> >> =A0 =A0 =A0 ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() a=
nd remove ./drivers/acpi/atomicio.[ch]
>> >> =A0 =A0 =A0 ACPI: Export interfaces for ioremapping/iounmapping A=
CPI registers
>> >
>> > Would be great to know whether these are going to be accepted.
>> > If yes, this check should get removed as well:
>> >
>> > drivers/acpi/acpica/hwregs.c:
>> > acpi_status
>> > acpi_hw_validate_register(struct acpi_generic_address *reg,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 max_bit_widt=
h, u64 *address)
>> > {
>> > ...
>> > =A0 =A0 =A0 =A0if (reg->bit_offset !=3D 0) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_WARNING((AE_INFO,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unsupp=
orted register bit offset: 0x%X",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg->bi=
t_offset));
>> > =A0 =A0 =A0 =A0}
>> >
>> > because APEI GAR declarations do use bit_offset !=3D 0.
>>
>> Half of this makes sense to me. =A0Myron's patch changes APEI from u=
sing
>> acpi_atomic_read() (which doesn't call acpi_hw_validate_register()) =
to
>> using acpi_read(), which *does* call it. =A0So after Myron's patch,
>> we'll see warnings we didn't see before.
>>
>> The part that doesn't make sense to me is just removing the warning.
>> That warning looks to me like it's saying "oops, here's something we
>> should support, but haven't implemented yet." =A0Wouldn't it be bett=
er
>> to implement support for bit_offset in acpi_read() at the same time =
we
>> remove the warning? =A0Then Myron could update his patch to drop the
>> bit_offset support in __apei_exec_read_register() when converting to
>> acpi_read().
>>
>> If APEI uses bit_offset !=3D 0, it's at least possible that other ar=
eas
>> will use it in the future, and it'd be nicer to have all the support
>> in acpi_read() rather than forcing APEI and others to each implement
>> their own support for it.
> Googling for the warning:
> "Unsupported register bit offset"
> only points to code snippets.
> The code needs to be compatible with a long history of ACPI table
> implementations (the reason why I thought to keep bit offset handling
> in APEI code for now is the safer approach). But bit_offset !=3D 0 se=
em
> to only appear in latest APEI table implementations.
> Looks like this condition was never run into and it should be safe
> to add bit offset support to these generic parts.
> -> I agree that bit offset handling can/should get added there.
>
> Still, if Windows has duplicated code for APEI GAR handling (with
> additional mask value, for example ignoring bit width) and does it
> slightly different than they do it in other parts,
> we also might not come around APEI specific GAR checking/workarounds.
>

I've hit a snag - hopefully I'm just not seeing something obvious so I =
thought
I would relay what I'm encountering and see if you or Bjorn have any id=
eas.

We all (Thomas, Bjorn, and myself) seem to all agree that GAS/GAR 'bit_=
offset'
handling should be handled in the generic ACPI code - acpi_read()/acpi_=
write()
as it is a member of GAS.  In order to do this we need to augment acpi_=
read()/
acpi_write() to handle 'bit_offset's properly and at the same time remo=
ve the
'bit_offset' warning from acpi_hw_validate_register().

By the same reasoning, APEI 'mask' handling should remain in the APEI c=
ode
as it is APEI specific.

Now, with that context, I have been attempting to convert APEI usages o=
f
acpi_atomic code to generic ACPI code, specifically:
  acpi_pre_map_gar()   ->  acpi_os_map_generic_address()
  acpi_post_unmap_gar()  ->  acpi_os_unmap_generic_address()
  acpi_atomic_read()  ->   acpi_read()
  acpi_atomic_write()  ->  acpi_write()
which seems to work out fairly nicely, allowing for the removal of
drivers/acpi/atomicio.[ch] in its entirety as it is now fairly redundan=
t.

The snag I've hit concerns these conversions with respect to
__apei_exec_write_register().  If __apei_exec_write_register() is calle=
d with a
APEI flag of APEI_EXEC_PRESERVE_REGISTER the code writes the
target register's bits of interest, specified by 'mask' and 'bit_offset=
', while
maintaining the current value of all the other bits of the register.

If we believe that 'bit_offset' should be handled by generic GAS/GAR re=
lated
code and 'mask' should be handled by APEI specific code, I do not see h=
ow
to maintain the behavior of __apei_exec_write_register()'s
APEI_EXEC_PRESERVE_REGISTER block.  With the 'bit_offset' handling
split out into ACPI generic code as with such, we would end up losing t=
he
value of any bits below a 'bit_offset' value that need to be maintained=
=2E

If you work through this example of __apei_exec_write_register() and as=
sume
'bit_offset' has been moved into ACPI generic code I believe you will s=
ee what
I am trying to point out.

Assume val =3D 0x0123456789abcdef, mask =3D 0xff, bit_offset =3D 16 (0x=
10),
valr =3D 0xfedcba987654321, and (flags & APEI_EXEC_PRESERVE_REGISTER)
is true the the current code works as follows:
  val &=3D mask     0x00000000000000ef
  val <<=3D bit_offset     0x0000000000ef0000
  now the APEI_EXEC_PRESERVE_REGISTER block
  valr &=3D ~(mask << bit_offset)     0xfedcba9876003210
  val |=3D valr     0xfedeba9876EF3210

I don't see how to maintain this behavior with a converted acpi_write()=
 that
itself handles 'bit_offset' shifting.

The only solution I've thought of would be to maintain much of
__apei_exec_write_register()'s current behavior with the addition of a =
hacky
adjustment to zero out 'bit_offset' just prior to the write if the
flag test is true.

I believe there has to be a better solution but I'm just not seeing it
currently?


Thomas - this issue exists with either conversion approach (my approach=
 of
getting acpi_read()/acpi_write() augmented to handle 'bit_offset' value=
s and
using those or your idea of copying acpi_atomicio_read()/acpi_atomicio_=
write(),
changing their names to apei_read()/apei_write(), augmenting those to
handle 'bit_offset' values and using them).


Thanks,
 Myron

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
