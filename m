From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
Date: Mon, 6 Feb 2017 09:06:17 -0600
Message-ID: <CAD8Lp46dOONGZYkr7izJo+rrRhxCr9H62HRbsUTB_ycLTmDaWg@mail.gmail.com>
References: <20170203205654.28269-1-jprvita@endlessm.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E563AEA@ORSMSX110.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE36E22@SHSMSX101.ccr.corp.intel.com> <CA+A7VXXNk58unA+k6743VV7=cHTTbW8YHVf_5GAYdv1EPA5dPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34711 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdBFPGT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2017 10:06:19 -0500
Received: by mail-oi0-f52.google.com with SMTP id s203so48301661oie.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2017 07:06:18 -0800 (PST)
In-Reply-To: <CA+A7VXXNk58unA+k6743VV7=cHTTbW8YHVf_5GAYdv1EPA5dPw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@endlessm.com" <linux@endlessm.com>, Jo?o Paulo Rechi Vita <jprvita@endlessm.com>, "Box, David E" <david.e.box@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>

On Mon, Feb 6, 2017 at 8:46 AM, Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.c=
om> wrote:
> Yes, the real problem is i2c_hid not being probed for the touchpad
> device on this platform

The lack of probe was because when i2c_acpi_add_device() called
acpi_bus_get_device() on the handle for the touchpad device (TPL1), it
was returning the acpi_device for something totally unrelated.

We checked that the original handle-to-device mapping was set up
correctly before that point, hence this looks like memory corruption,
and the problem went away as soon as we fixed the double free.

> [    0.317002] ACPI Warning: Obj ffffa00472a445e8, Reference Count is
> already zero, cannot decrement
> [    0.317178]  (20160422/utdelete-442)
>
>> See this bug for reference:
>> https://bugs.acpica.org/show_bug.cgi?id=3D1336
>>
>
> Looks like it could be the same problem, indeed. I'm attaching a
> kernel log with acpi.trace_debug_layer=3D0x10091
> acpi.trace_debug_level=3D0x107FFF
> acpi.trace_method_name=3D_SB.PCI0.I2C1.TPL1._CID
> acpi.trace_state=3Dopcode, which is what I was using to investigate the
> problem

The debug messages in that log stop when the method execution
completes, so it may also be useful to share a part of an earlier log
where you can see the double freeing happen in a bit more detail. For
each of the 2 objects double-freed below we confirmed that the first
unreference is the one in acpi_ns_repair_HID and the second
unreference is the one removed in JP's patch.

nsprepkg-0105 ns_check_package      : \_SB.PCI0.I2C1.TPL1._CID
Validating return Package of Type 2, Count 2
utobject-0404 ut_allocate_object_des: ffff940f6ba36480 Size 48
utdelete-0750 ut_remove_reference   : Obj ffff940f6ba36cf0 Current
Refs=3D1 [To Be Decremented]
utdelete-0447 ut_update_ref_count   : Obj ffff940f6ba36cf0 Type 02
Refs 00 [Decremented]
utdelete-0096 ut_delete_internal_obj: **** String ffff940f6ba36cf0,
ptr ffff9f654004e2a8
utdelete-0336 ut_delete_internal_obj: Deleting Object ffff940f6ba36cf0 [Str=
ing]
utdelete-0750 ut_remove_reference   : Obj ffff940f6ba36cf0 Current
Refs=3D0 [To Be Decremented]
ACPI Warning: Obj ffff940f6ba36cf0, Reference Count is already zero,
cannot decrement
(20160422/utdelete-442)
utdelete-0447 ut_update_ref_count   : Obj ffff940f6ba36cf0 Type 02
Refs 00 [Decremented]
utdelete-0096 ut_delete_internal_obj: **** String ffff940f6ba36cf0,
ptr ffff9f654004e2a8
utdelete-0336 ut_delete_internal_obj: Deleting Object ffff940f6ba36cf0 [Str=
ing]
utobject-0404 ut_allocate_object_des: ffff940f6ba36cf0 Size 48
utdelete-0750 ut_remove_reference   : Obj ffff940f6ba36c60 Current
Refs=3D1 [To Be Decremented]
utdelete-0447 ut_update_ref_count   : Obj ffff940f6ba36c60 Type 02
Refs 00 [Decremented]
utdelete-0096 ut_delete_internal_obj: **** String ffff940f6ba36c60,
ptr ffff9f654004e2b2
utdelete-0336 ut_delete_internal_obj: Deleting Object ffff940f6ba36c60 [Str=
ing]
utdelete-0750 ut_remove_reference   : Obj ffff940f6ba36c60 Current
Refs=3D0 [To Be Decremented]
ACPI Warning: Obj ffff940f6ba36c60, Reference Count is already zero,
cannot decrement
(20160422/utdelete-442)
utdelete-0447 ut_update_ref_count   : Obj ffff940f6ba36c60 Type 02
Refs 00 [Decremented]
utdelete-0096 ut_delete_internal_obj: **** String ffff940f6ba36c60,
ptr ffff9f654004e2b2
utdelete-0336 ut_delete_internal_obj: Deleting Object ffff940f6ba36c60 [Str=
ing]
  nseval-0315 ns_evaluate           : *** Completed evaluation of
object _CID ***

Thanks,
Daniel
