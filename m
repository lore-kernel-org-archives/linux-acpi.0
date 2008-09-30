From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Re: Propose WMI patch
Date: Tue, 30 Sep 2008 14:05:25 +0100
Message-ID: <200809301405.25117.duartejcsilva@gmail.com>
References: <200809301206.35983.duartejcsilva@gmail.com> <200809301229.17174.duartejcsilva@gmail.com> <200809301240.34032.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:10236 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbYI3NHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 09:07:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so2768nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2008 06:07:48 -0700 (PDT)
In-Reply-To: <200809301240.34032.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Tuesday 30 September 2008 12:40:33 Carlos Corbacho wrote:
> On Tuesday 30 September 2008 12:29:17 Duarte Silva wrote:
> > For instance, it would be nice to be able to do this,
> >
> > for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
> > =A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].status =3D
> > wmi_is_guid_present(laptop->methods[i].guid);
> >
> > instead of
> >
> > for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
> > =A0=A0=A0=A0=A0=A0=A0=A0if (wmi_has_guid(laptop->methods[i].guid))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].=
status =3D AE_OK;
> > =A0=A0=A0=A0=A0=A0=A0=A0else
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].=
status =3D AE_NOT_FOUND;
>
> Why not just do:
>
> for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
>          laptop->methods[i].exists =3D
>                  wmi_is_guid_present(laptop->methods[i].guid);
>
> I don't see why you need an ACPI status here, when a simple bool will=
 do
> just fine?
>
> Otherwise, instead of being able to do this:
>
> if (laptop->methods[i].exists) {
>         /* do something */
> }
>
> you end up having to use one of the ACPI status wrappers all the time=
:
>
> if (ACPI_SUCCESS(laptop->methods[i].status)) {
>          /* do something */
> }
>
> -Carlos

yes, a bool should suffice, thanks :)

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
