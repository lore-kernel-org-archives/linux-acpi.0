From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Wed, 2 Nov 2011 19:42:34 -0600
Message-ID: <CAL-B5D0MfHZZY7CUbPBxY6_zD_dBpDzk1mas_eE-RF_pK7o38g@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	<201110280349.26410.trenn@suse.de>
	<CAErSpo5waF5Nz92d612tp60bV=oLNyb=yo1xh6_TMhGSvQ07tw@mail.gmail.com>
	<201110311147.40546.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56232 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934778Ab1KCBmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Nov 2011 21:42:35 -0400
Received: by vcge1 with SMTP id e1so717194vcg.19
        for <linux-acpi@vger.kernel.org>; Wed, 02 Nov 2011 18:42:34 -0700 (PDT)
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

We all seem to agree that bit offset handling can/should get added to t=
he
generic parts at some point.

As for APEI specifically and my patch to remove atomicio.[ch] I think w=
e
should add code prior to the converted 'acpi_read'/'acpi_write' calls t=
o copy
the GAS structure parameter onto the local stack and zero out the
gas.bit_offset value as in:

  struct acpi_generic_address gas;  /* on local stack */
  gas =3D entry->register_region;
  gas.bit_offset =3D 0;
  acpi_read(val, &gas);

This should cover the three issues that Thomas pointed out: "unsupporte=
d
register bit offset" warnings, invalid bit_width entries in APEI GAR en=
tries,
and GAR structures located in reserved BIOS areas that need to be
treated as const.

As for invalid bit_width entries in APEI GAR entries - atomicio.c curre=
ntly
ignores bit_offset so the approach above of clearing out such should be
safe in this context.

The above would also _not_ introduce "unsupported register bit offset"
warnings that were not there before although it might be nice to wrap t=
he
above GAS copying and gas.bit_offset clearing out into a wrapper routin=
e
and add a 'warn_once' within such indicating that we are ignoring a non=
-
zero bit_offset.  These warnings should be harmless in APEI context but
are admittedly alarming.

Lastly, the above addition also mitigates any modification of GAR struc=
tures
in the 'acpi_read'/'acpi_write' call paths.

Let me know what you all think and thanks Thomas for bringing these
issues to light.

Myron

> Still, if Windows has duplicated code for APEI GAR handling (with
> additional mask value, for example ignoring bit width) and does it
> slightly different than they do it in other parts,
> we also might not come around APEI specific GAR checking/workarounds.
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
