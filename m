From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Propose WMI patch
Date: Tue, 30 Sep 2008 12:40:33 +0100
Message-ID: <200809301240.34032.carlos@strangeworlds.co.uk>
References: <200809301206.35983.duartejcsilva@gmail.com> <200809301216.11055.carlos@strangeworlds.co.uk> <200809301229.17174.duartejcsilva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:43692 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbYI3Lkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 07:40:37 -0400
In-Reply-To: <200809301229.17174.duartejcsilva@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duarte Silva <duartejcsilva@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 30 September 2008 12:29:17 Duarte Silva wrote:
> For instance, it would be nice to be able to do this,
>
> for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
> =A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].status =3D
> wmi_is_guid_present(laptop->methods[i].guid);
>
> instead of
>
> for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
> =A0=A0=A0=A0=A0=A0=A0=A0if (wmi_has_guid(laptop->methods[i].guid))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].st=
atus =3D AE_OK;
> =A0=A0=A0=A0=A0=A0=A0=A0else
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].st=
atus =3D AE_NOT_FOUND;

Why not just do:

for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
         laptop->methods[i].exists =3D
                 wmi_is_guid_present(laptop->methods[i].guid);

I don't see why you need an ACPI status here, when a simple bool will d=
o just=20
fine?

Otherwise, instead of being able to do this:

if (laptop->methods[i].exists) {
        /* do something */
}

you end up having to use one of the ACPI status wrappers all the time:

if (ACPI_SUCCESS(laptop->methods[i].status)) {
         /* do something */
}

-Carlos
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
