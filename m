From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Re: Problems evaluating WMI method
Date: Wed, 1 Oct 2008 21:48:53 +0100
Message-ID: <200810012149.06331.duartejcsilva@gmail.com>
References: <200810012113.50723.duartejcsilva@gmail.com> <200810012126.29618.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14916564.XBVY1gq0JG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:42537 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYJAUvc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 16:51:32 -0400
Received: by ug-out-1314.google.com with SMTP id k3so905890ugf.37
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2008 13:51:30 -0700 (PDT)
In-Reply-To: <200810012126.29618.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart14916564.XBVY1gq0JG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 01 October 2008 21:26:28 Carlos Corbacho wrote:
> On Wednesday 01 October 2008 21:13:50 Duarte Silva wrote:
> > I got the correct answer when I do instance =3D 0x33 and method_id =3D =
0x01.
> > So, I looked at hp-wmi.c code and acer-wmi.c and they depend on this
> > instance and method_id. But my laptop doesnt seem to depend.
>
> acer-wmi doesn't rely on the instance_id, it just gets ignored. It does u=
se
> the method_id though.
>
> > Is this
> > instance and method_id a WMI standart or is it a HP and Acer laptop
> > specific? My laptop is a LG.
>
> Yes, these are part of the WMI standard (in that, they need to be passed
> in). I would recommend you read through the spec:
>
> http://web.archive.org/web/20071011004327/http://www.microsoft.com/whdc/s=
ys
>tem/pnppwr/wmi/wmi-acpi.mspx
>
> Essentially - you need to pass the instance and method id's, but what
> values you pass and their meaning is completely vendor specific (which is
> pretty much a good summary of ACPI-WMI in general).
>
> -Carlos

Oh, I got it, so it doesnt have a standart meaning, now it makes sence. In =
my=20
case when you pass 0x01 as the method_id you are saying you want to get the=
=20
value defined by the instance variable. Other values for the method_id can=
=20
mean other actions. Thanks for the help Carlos :)

--nextPart14916564.XBVY1gq0JG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQEcBAABAgAGBQJI4+JCAAoJEECjj32IIUeOKW4IAJ81kea0RWZ7qnKcdsSW73Gs
KDDVybdd1aTXzem6opQOwAIgxIRmosJ5Iz/OE0theCtyadETsi/0euSYELMfhx5+
6AVXwqr2P7/Zl4gflG8GgzmV7gx13C8YgPxbQndKFhxR4qiDl8lUEu/a4/xahBq5
etSpRw+GCGjyxVbcpl9ajnqnm9jvwT7Cw1bjhEpxD6w4Mx7iDhBNDTl6peRM0HCW
VdrfJDGTJ5bdOi+XP+tOFX7pS4biF7wyXOi6w028eYw94T4695eLHfHk+bOEqDDe
hovPa8aj9dMQlUhd+sMayU0WyMeg8xzPRSBW3Nf5JrJQPZmdNKdzlMFex9JwdOY=
=x9Al
-----END PGP SIGNATURE-----

--nextPart14916564.XBVY1gq0JG--
