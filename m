From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Tue, 15 Nov 2011 11:45:42 -0700
Message-ID: <CAErSpo5Kk1MNURpC3-BpQ=E_Z83tQkZZrO18-mjMCnmCRC_Cmg@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de>
 <CAErSpo5waF5Nz92d612tp60bV=oLNyb=yo1xh6_TMhGSvQ07tw@mail.gmail.com>
 <201110311147.40546.trenn@suse.de> <CAL-B5D0Dp8AoMUUJxy58EMdL0k0LRwJ_xa3XRdGT32qrhR0D+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38309 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1KOSqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2011 13:46:04 -0500
Received: by ywt32 with SMTP id 32so3794998ywt.19
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2011 10:46:03 -0800 (PST)
In-Reply-To: <CAL-B5D0Dp8AoMUUJxy58EMdL0k0LRwJ_xa3XRdGT32qrhR0D+g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Fri, Nov 4, 2011 at 5:54 PM, Myron Stowe <myron.stowe@gmail.com> wro=
te:
> The snag I've hit concerns these conversions with respect to
> __apei_exec_write_register(). =A0If __apei_exec_write_register() is c=
alled with a
> APEI flag of APEI_EXEC_PRESERVE_REGISTER the code writes the
> target register's bits of interest, specified by 'mask' and 'bit_offs=
et', while
> maintaining the current value of all the other bits of the register.
>
> If we believe that 'bit_offset' should be handled by generic GAS/GAR =
related
> code and 'mask' should be handled by APEI specific code, I do not see=
 how
> to maintain the behavior of __apei_exec_write_register()'s
> APEI_EXEC_PRESERVE_REGISTER block. =A0With the 'bit_offset' handling
> split out into ACPI generic code as with such, we would end up losing=
 the
> value of any bits below a 'bit_offset' value that need to be maintain=
ed.
>
> If you work through this example of __apei_exec_write_register() and =
assume
> 'bit_offset' has been moved into ACPI generic code I believe you will=
 see what
> I am trying to point out.
>
> Assume val =3D 0x0123456789abcdef, mask =3D 0xff, bit_offset =3D 16 (=
0x10),
> valr =3D 0xfedcba987654321, and (flags & APEI_EXEC_PRESERVE_REGISTER)
> is true the the current code works as follows:
> =A0val &=3D mask =A0 =A0 0x00000000000000ef
> =A0val <<=3D bit_offset =A0 =A0 0x0000000000ef0000
> =A0now the APEI_EXEC_PRESERVE_REGISTER block
> =A0valr &=3D ~(mask << bit_offset) =A0 =A0 0xfedcba9876003210
> =A0val |=3D valr =A0 =A0 0xfedeba9876EF3210
>
> I don't see how to maintain this behavior with a converted acpi_write=
() that
> itself handles 'bit_offset' shifting.

I think this analysis is incorrect because it keeps the bit_offset
shift in __apei_exec_write_register() even though it assumes
acpi_read() uses bit_offset to extract the region.

Assume a 64-bit CSR at 0x1000, with bit_offset =3D 16 in the GAS and an
8-bit mask, so the region of interest is bits [23:16]:

    gas->address                0x1000
    gas->bit_offset             16 (0x10)
    entry->mask                 0x00000000000000ff

Here's how we handle this in the current __apei_exec_write_register(),
with acpi_read() ignoring bit_offset:

      val &=3D entry->mask;
      val <<=3D entry->register_region.bit_offset;
      if (entry->flags & APEI_EXEC_PRESERVE_REGISTER) {
          acpi_atomic_read(&valr, &entry->register_region);
          valr &=3D ~(entry->mask << entry->register_region.bit_offset)=
;
          val |=3D valr;
      }
      acpi_atomic_write(val, &entry->register_region);

      initial value @0x1000     0xfedcba9876543210
      value to write (val)      0x0123456789abcdef
      val &=3D mask               0x00000000000000EF
      val <<=3D bit_offset        0x0000000000EF0000
      valr                      0xfedcba9876543210 (from acpi_atomic_re=
ad)
      valr &=3D ~(mask << offset) 0xfedcba9876003210
      val |=3D valr               0xfedcba9876EF3210
      final value @0x1000       0xfedcba9876EF3210 (by acpi_atomic_writ=
e)

If we make acpi_read() & acpi_write() pay attention to bit_offset,
__apei_exec_write_register() should look like this:

      val &=3D entry->mask;
      if (entry->flags & APEI_EXEC_PRESERVE_REGISTER) {
          acpi_read(&valr, &entry->register_region);  /* valr =3D bits =
[xx:16] */
          valr &=3D ~entry->mask;
          val |=3D valr;
      }
      acpi_write(val, &entry->register_region);  /* writes only bits [x=
x:16] */

      initial value @0x1000     0xfedcba9876543210
      value to write (val)      0x0123456789abcdef
      val &=3D mask               0x00000000000000EF
      valr                      0x0000fedcba987654 (from acpi_read)
      valr &=3D ~mask             0x0000fedcba987600
      val |=3D valr               0x0000fedcba9876EF
      final value @0x1000       0xfedcba9876EF3210 (by acpi_write)

This depends on some assumptions about how acpi_read() and
acpi_write() deal with bit_offset and probably bit_width.  I don't
think we have those behaviors all worked out yet, but I think it's
possible, and this is a good opportunity to do it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
