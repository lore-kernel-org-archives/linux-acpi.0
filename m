From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Fix potential oops in dock driver
Date: Wed, 18 Jul 2007 20:38:22 -0400
Message-ID: <200707182038.23028.lenb@kernel.org>
References: <200707180110.24792.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35588 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758996AbXGSAie convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 20:38:34 -0400
In-Reply-To: <200707180110.24792.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Applied.

thanks,
-Len

On Wednesday 18 July 2007 01:10, Dmitry Torokhov wrote:
> [PATCH] Fix potential oops in dock driver
> From:=20
> Dmitry Torokhov <dtor@insightbb.com>
>   To:=20
> linux-acpi@vger.kernel.org
>   CC:=20
> Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len=
=2Ebrown@intel.com>
>   Date:=20
> Today 01:10:24 am
>   =A0
>   Spam Status:=A0Spamassassin 0% probability of being spam.
>=20
> Full report:
> No, score=3D-2.1 required=3D5.0 tests=3DAWL,BAYES_00,FORGED_RCVD_HELO=
 autolearn=3Dham version=3D3.1.9 =A0
> Possible needed for -stable as well.
>=20
> --=20
> Dmitry
>=20
> ACPI: dock - fix an oops when _DCK evaluation fails
>=20
> Data returned by acpi_get_name in acpi_buffer is not acpi_object and
> therefore should not be cast to it, otherwise we'll get an nice oops
> trying to print error message.
>=20
> Also print name of the ACPI object corresponding to the docking stati=
on
> and elevate severity of the message printed when _DCK fails to KERN_E=
RR.
>=20
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> =A0drivers/acpi/dock.c | =A0 =A08 ++++----
> =A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Index: linux/drivers/acpi/dock.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/acpi/dock.c
> +++ linux/drivers/acpi/dock.c
> @@ -380,12 +380,11 @@ static void handle_dock(struct dock_stat
> =A0=A0=A0=A0=A0=A0=A0=A0union acpi_object arg;
> =A0=A0=A0=A0=A0=A0=A0=A0struct acpi_buffer buffer =3D { ACPI_ALLOCATE=
_BUFFER, NULL };
> =A0=A0=A0=A0=A0=A0=A0=A0struct acpi_buffer name_buffer =3D { ACPI_ALL=
OCATE_BUFFER, NULL };
> -=A0=A0=A0=A0=A0=A0=A0union acpi_object *obj;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0acpi_get_name(ds->handle, ACPI_FULL_PATHNAME,=
 &name_buffer);
> -=A0=A0=A0=A0=A0=A0=A0obj =3D name_buffer.pointer;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO PREFIX "%s\n", dock ? "docking=
" : "undocking");
> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO PREFIX "%s - %s\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(char *)name_buffer.poi=
nter, dock ? "docking" : "undocking");
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* _DCK method has one argument */
> =A0=A0=A0=A0=A0=A0=A0=A0arg_list.count =3D 1;
> @@ -394,7 +393,8 @@ static void handle_dock(struct dock_stat
> =A0=A0=A0=A0=A0=A0=A0=A0arg.integer.value =3D dock;
> =A0=A0=A0=A0=A0=A0=A0=A0status =3D acpi_evaluate_object(ds->handle, "=
_DCK", &arg_list, &buffer);
> =A0=A0=A0=A0=A0=A0=A0=A0if (ACPI_FAILURE(status))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("%s: failed to=
 execute _DCK\n", obj->string.pointer);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR PREFIX =
"%s - failed to execute _DCK\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 (char *)name_buffer.pointer);
> =A0=A0=A0=A0=A0=A0=A0=A0kfree(buffer.pointer);
> =A0=A0=A0=A0=A0=A0=A0=A0kfree(name_buffer.pointer);
> =A0}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
