From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: the role of the dstd
Date: Wed, 13 Sep 2006 11:41:53 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4EE17FC@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26512 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751092AbWIMSm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Sep 2006 14:42:28 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, =?iso-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmagarza@gmail.com>
Cc: linux-acpi@vger.kernel.org

> For example, Windows serializes (runs in one thread) procedures=20
> automatically, even if a procedure is labelled NotSerialized.  But=20
> Linux ACPI, unless you pass a boot option to tell it to act like=20
> Windows, will not serialize those procedures, and each one can run in=
=20
> its own thread.

Actually, we think that Windows does NOT serialize everything within th=
e AML interpreter.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Sanjoy Mahajan
> Sent: Wednesday, September 13, 2006 11:11 AM
> To: Rusl=E1n Ledesma Garza
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: the role of the dstd
>=20
> > Is this option "act like windows" really available? Is it a boot
> > parameter?
>=20
> It is.  Add these options to your boot parameters:
>=20
>   acpi_os_name=3D"Microsoft Windows" acpi_serialize
>=20
> -Sanjoy
>=20
> `Never underestimate the evil of which men of power are capable.'
>          --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
