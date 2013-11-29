From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: How can a critical temperature be set?
Date: Fri, 29 Nov 2013 13:25:32 +0100
Message-ID: <5973936.aJ38W1h68Q@vostro.rjw.lan>
References: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54466 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751690Ab3K2MMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2013 07:12:40 -0500
In-Reply-To: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Cc: Rui

On Friday, November 29, 2013 10:06:12 AM Thomas Mitterfellner wrote:
> Hello!
>=20
> How can I set a thermal trip point for the critical temperature as
> shown by acpi -V? (My laptop, Toshiba Satellite Pro l770-116, intel
> HM65 chipset, shuts down frequently under high CPU load and I suspect
> too low a critical temperature setting, namely 84=C2=B0C, to be the
> culprit, as I read that 91+=C2=B0C are not uncommon for my system und=
er
> heavy load)
>=20
> I asked at the lm-sensors mailing list and I was advised to ask here.
> I was told that I might have to edit the DSDT tables to accomplish
> this. Is there possibly some simpler way or can someone give me a hin=
t
> on how to do this?
> What I want to accomplish is: I want to set (increase) the temperatur=
e
> temp_crit1 shown in the output of sensors -u for the virtual device
> acpitz-virtual-0.
>=20
> Thank you for your help,
>=20
> Thomas
>=20
>=20
> For reference, I attached the output of acpi -V and sensors -u comman=
ds.
>=20
> # acpi -V
> [=E2=80=A6]
> Thermal 0: ok, 57.0 degrees C
> Thermal 0: trip point 0 switches to mode critical at temperature 84.0
> degrees C
> Thermal 0: trip point 1 switches to mode passive at temperature 105.0
> degrees CThermal 0: ok, 57.0 degrees C
> Thermal 0: trip point 0 switches to mode critical at temperature 84.0
> degrees C
> Thermal 0: trip point 1 switches to mode passive at temperature 105.0
> degrees C:
> [=E2=80=A6]
>=20
> # sensors -u
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:
>   temp1_input: 73.000
>   temp1_crit: 84.000
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:
>   temp1_input: 71.000
>   temp1_max: 86.000
>   temp1_crit: 100.000
>   temp1_crit_alarm: 0.000
> Core 0:
>   temp2_input: 71.000
>   temp2_max: 86.000
>   temp2_crit: 100.000
>   temp2_crit_alarm: 0.000
> Core 1:
>   temp3_input: 71.000
>   temp3_max: 86.000
>   temp3_crit: 100.000
>   temp3_crit_alarm: 0.000
>=20
> pkg-temp-0-virtual-0
> Adapter: Virtual device
> temp1:
>   temp1_input: 71.000
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
