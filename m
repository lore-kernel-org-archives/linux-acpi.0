From: "Jeff.Wu" <chping@gmail.com>
Subject: Fwd: FW: [Update][PATCH] ACPI: Rework acpi_get_child() to be more efficient
Date: Thu, 16 May 2013 16:16:43 +0800
Message-ID: <CANh5a1xoR03j6yb7EfWFR=Go8XEqmOm3-=Ayasq8Vcg5_fS5yg@mail.gmail.com>
References: <1644954.gUaZqebo61@vostro.rjw.lan>
	<14285317.C5USrgceVP@vostro.rjw.lan>
	<6591808.qVVzyd5JNI@vostro.rjw.lan>
	<5180B254989D2842B6BD8114CBC703AC67E657@SCYBEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33818 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab3EPIQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2013 04:16:45 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so2827907lbj.10
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2013 01:16:43 -0700 (PDT)
In-Reply-To: <5180B254989D2842B6BD8114CBC703AC67E657@SCYBEXDAG01.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi Rafael

If  it add a _STA evaluating at do_acpi_find_child , is it reasonable ?
If No, where _STA evaluating should be added ?

At our platform ,ODD8/ODDZ/ODDL have the same _ADR.

 1. Address: 0x1FFFF (valid); handle: =ACSB_.PCI0.SATA.ODD8
 2. Address: 0x1FFFF (valid); handle: =ACSB_.PCI0.SATA.ODDZ
 3. Address: 0x1FFFF (valid);  handle: =ACSB_.PCI0.SATA.ODDL

if one device is enabled(_STA evaluating return 0xF), the others will
be disabled (_STA  evaluating return 0).

With the current do_acpi_find_child,If ODDL is enabled , the correct
handle should be " =ACSB_.PCI0.SATA.ODDL",
but do_acpi_find_child always return  "=ACSB_.PCI0.SATA.ODD8" handle.
So ,we want to add a _STA evaluating workaround  at do_acpi_find_child
to fix this issue.


Thanks
Jeff Wu




-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
Wysocki
Sent: Saturday, January 05, 2013 5:39 AM
To: ACPI Devel Maling List
Cc: LKML; Len Brown
Subject: Re: [Update][PATCH] ACPI: Rework acpi_get_child() to be more e=
fficient

On Wednesday, December 26, 2012 11:42:49 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI: Rework acpi_get_child() to be more efficient
>
> Observe that acpi_get_child() doesn't need to use the helper
> struct acpi_find_child structure and change it to work without it.
> Also, using acpi_get_object_info() to get the output of _ADR for the
> given device is overkill, because that function does much more than
> just evaluating _ADR (let alone the additional memory allocation
> done by it).
>
> Moreover, acpi_get_child() doesn't need to loop any more once it has
> found a matching handle, so make it stop in that case.  To prevent
> the results from changing, make it use do_acpi_find_child() as
> a post-order callback.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> The difference from the previous version is the replacement of
> acpi_get_object_info() with the direct execution of _ADR, which is
> more straightforward.

There seem to be no objections, most likely due to the holiday period
that has just ended, but if there are still none, I'm going to push thi=
s
for v3.9.

Thanks,
Rafael


> ---
>  drivers/acpi/glue.c |   33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>
> Index: linux/drivers/acpi/glue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/acpi/glue.c
> +++ linux/drivers/acpi/glue.c
> @@ -93,40 +93,31 @@ static int acpi_find_bridge_device(struc
>       return ret;
>  }
>
> -/* Get device's handler per its address under its parent */
> -struct acpi_find_child {
> -     acpi_handle handle;
> -     u64 address;
> -};
> -
> -static acpi_status
> -do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void =
**rv)
> +static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_no=
t_used,
> +                                   void *addr_p, void **ret_p)
>  {
> +     unsigned long long addr;
>       acpi_status status;
> -     struct acpi_device_info *info;
> -     struct acpi_find_child *find =3D context;
>
> -     status =3D acpi_get_object_info(handle, &info);
> -     if (ACPI_SUCCESS(status)) {
> -             if ((info->address =3D=3D find->address)
> -                     && (info->valid & ACPI_VALID_ADR))
> -                     find->handle =3D handle;
> -             kfree(info);
> +     status =3D acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL=
, &addr);
> +     if (ACPI_SUCCESS(status) && addr =3D=3D *((u64 *)addr_p)) {
> +             *ret_p =3D handle;
> +             return AE_CTRL_TERMINATE;
>       }
>       return AE_OK;
>  }
>
>  acpi_handle acpi_get_child(acpi_handle parent, u64 address)
>  {
> -     struct acpi_find_child find =3D { NULL, address };
> +     void *ret =3D NULL;
>
>       if (!parent)
>               return NULL;
> -     acpi_walk_namespace(ACPI_TYPE_DEVICE, parent,
> -                         1, do_acpi_find_child, NULL, &find, NULL);
> -     return find.handle;
> -}
>
> +     acpi_walk_namespace(ACPI_TYPE_DEVICE, parent, 1, NULL,
> +                         do_acpi_find_child, &address, &ret);
> +     return (acpi_handle)ret;
> +}
>  EXPORT_SYMBOL(acpi_get_child);
>
>  static int acpi_bind_one(struct device *dev, acpi_handle handle)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
