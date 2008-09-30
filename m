From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Re: Propose WMI patch
Date: Tue, 30 Sep 2008 12:29:17 +0100
Message-ID: <200809301229.17174.duartejcsilva@gmail.com>
References: <200809301206.35983.duartejcsilva@gmail.com> <200809301213.59150.carlos@strangeworlds.co.uk> <200809301216.11055.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:24124 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYI3Lbl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 07:31:41 -0400
Received: by ey-out-2122.google.com with SMTP id 6so722249eyi.37
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2008 04:31:40 -0700 (PDT)
In-Reply-To: <200809301216.11055.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Tuesday 30 September 2008 12:16:10 Carlos Corbacho wrote:
> On Tuesday 30 September 2008 12:13:58 Carlos Corbacho wrote:
> > On Tuesday 30 September 2008 12:06:35 Duarte Silva wrote:
> > > I wanted to propose a ACPI-WMI API change. Instead of having,
> > > wmi_has_guid returning a boolean, why not returning a acpi_status=
=2E It
> > > would allow extented error handling, and it would look more ACPI =
style
> > > :)
> >
> > NAK.
> >
> > We're not interested in ACPI error codes here, since we're never go=
ing to
> > do anything with them.
> >
> > We only care if the DSDT exists or not with this method - it's just=
 a
> > means of detection for other drivers.
>
> s/DSDT/GUID/
>
> -Carlos

On Tuesday 30 September 2008 12:16:10 you wrote:
> On Tuesday 30 September 2008 12:13:58 Carlos Corbacho wrote:
> > On Tuesday 30 September 2008 12:06:35 Duarte Silva wrote:
> > > I wanted to propose a ACPI-WMI API change. Instead of having,
> > > wmi_has_guid returning a boolean, why not returning a acpi_status=
=2E It
> > > would allow extented error handling, and it would look more ACPI =
style
> > > :)
> >
> > NAK.
> >
> > We're not interested in ACPI error codes here, since we're never go=
ing to
> > do anything with them.
> >
> > We only care if the DSDT exists or not with this method - it's just=
 a
> > means of detection for other drivers.
>
> s/DSDT/GUID/
>
> -Carlos

=46or instance, it would be nice to be able to do this,

for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].status =3D=20
wmi_is_guid_present(laptop->methods[i].guid);

instead of

for (i =3D 0; i < ARRAY_SIZE(laptop->methods); i++)
=A0=A0=A0=A0=A0=A0=A0=A0if (wmi_has_guid(laptop->methods[i].guid))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].stat=
us =3D AE_OK;
=A0=A0=A0=A0=A0=A0=A0=A0else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0laptop->methods[i].stat=
us =3D AE_NOT_FOUND;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
