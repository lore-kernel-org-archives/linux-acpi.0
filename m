From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: How can a critical temperature be set?
Date: Sat, 30 Nov 2013 18:54:29 +0800
Message-ID: <CAOLK0pwQX5qjggp=cD11sxyeV_Ap3+FGfDqbOu9yxLJ0VOk58w@mail.gmail.com>
References: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54427 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3K3Kya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Nov 2013 05:54:30 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so17648655ieb.11
        for <linux-acpi@vger.kernel.org>; Sat, 30 Nov 2013 02:54:29 -0800 (PST)
In-Reply-To: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013/11/29 Thomas Mitterfellner <thomas.mitterfellner@gmail.com>:
> Hello!
>
> How can I set a thermal trip point for the critical temperature as
> shown by acpi -V? (My laptop, Toshiba Satellite Pro l770-116, intel
> HM65 chipset, shuts down frequently under high CPU load and I suspect
> too low a critical temperature setting, namely 84=B0C, to be the
> culprit, as I read that 91+=B0C are not uncommon for my system under
> heavy load)
>
> I asked at the lm-sensors mailing list and I was advised to ask here.
> I was told that I might have to edit the DSDT tables to accomplish
> this. Is there possibly some simpler way or can someone give me a hin=
t
> on how to do this?

Please try adding kernel param "thermal.crt=3D91".

> What I want to accomplish is: I want to set (increase) the temperatur=
e
> temp_crit1 shown in the output of sensors -u for the virtual device
> acpitz-virtual-0.
>
> Thank you for your help,
>
> Thomas
>
>
> For reference, I attached the output of acpi -V and sensors -u comman=
ds.
>
> # acpi -V
> [=85]
> Thermal 0: ok, 57.0 degrees C
> Thermal 0: trip point 0 switches to mode critical at temperature 84.0
> degrees C
> Thermal 0: trip point 1 switches to mode passive at temperature 105.0
> degrees CThermal 0: ok, 57.0 degrees C
> Thermal 0: trip point 0 switches to mode critical at temperature 84.0
> degrees C
> Thermal 0: trip point 1 switches to mode passive at temperature 105.0
> degrees C:
> [=85]
>
> # sensors -u
>
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:
>   temp1_input: 73.000
>   temp1_crit: 84.000
>
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
>
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
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
