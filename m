From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: smartbattery status on Laptop
Date: Thu, 31 May 2007 12:20:15 +0400
Message-ID: <465E853F.6090406@gmail.com>
References: <200705311711.09397.jfloyd@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:47118 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbXEaIUS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 04:20:18 -0400
Received: by py-out-1112.google.com with SMTP id a29so149406pyi
        for <linux-acpi@vger.kernel.org>; Thu, 31 May 2007 01:20:17 -0700 (PDT)
In-Reply-To: <200705311711.09397.jfloyd@bigpond.net.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Floyd <jfloyd@bigpond.net.au>
Cc: linux-acpi@vger.kernel.org

Please open bug at bugzilla.kernel.org and attach acpidump output.

Thanks,
Alex.

John Floyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>=20
> Have a specialised weatherproof laptop with a smartbattery running FC=
6
>  latest kernel. I cannot get battey monitoring going. Have loaded
>  modules i2c_ec and sbs with out any errors.
>=20
> log/messages indicate that the EC driver loads with
> ACPI: EC HC smbus [SMB1]
>=20
> There is nothing from the sbs module though it is loaded and
> the /proc/acpi/battery directory is empty.
>=20
> The smartbattery can be recognized. If I run the following command ..=
=2E
>=20
> smartbattery 1             (1 is to specify the i2c dev,
>                             needs i2c-dev module loaded)
>=20
> then I get battery status, which behaves properly (changes if I unplu=
g
>  AC etc). It shows Battery name, status , charge or discharge current=
,
>  time to full/left, temperature etc.  The smartbattery command came
>  with the initial code exploring the ec-smbus interface a couple of
>  years ago by Bruno Ducrot.
>=20
> However nothing shows up in the proc/acpi/battery directory under the
>  sbs module, and therefore the gui battery indicators do not work
>=20
> Any suggestions?
>=20
>=20
> Love to get this working in the gui.
>=20
>=20
> John
> --
> John Floyd
> Senior Natural Resource Officer
> Department of Environment and Climate Change
> Phone +61-2-9895-5956
> Fax   +61-2-9895-7263
> john.floyd@dnr.nsw.gov.au
>=20
> -------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
