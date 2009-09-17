From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: asus_atk0110 not working on Asus P7P55D PRO
Date: Thu, 17 Sep 2009 11:17:42 +0200
Message-ID: <68676e00909170217y8819e3dv115fd6c987942495@mail.gmail.com>
References: <4AB1C907.1070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37574 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZIQJRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Sep 2009 05:17:41 -0400
In-Reply-To: <4AB1C907.1070503@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, Sep 17, 2009 at 7:28 AM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> Just built a new system with an Asus P7P55D PRO motherboard. The ATK0=
110
> driver doesn't seem to be able to retrieve any hardware monitoring
> parameters successfully, sensors gives:
>
> atk0110-acpi-0
> Adapter: ACPI interface
> ERROR: Can't get value of subfeature in0_input: I/O error
> Vcore Voltage: =C2=A0 =C2=A0 =C2=A0+0.00 V =C2=A0(min =3D =C2=A0+0.80=
 V, max =3D =C2=A0+1.60 V)
> ERROR: Can't get value of subfeature in1_input: I/O error
> +3.3V Voltage: =C2=A0 =C2=A0 =C2=A0+0.00 V =C2=A0(min =3D =C2=A0+2.97=
 V, max =3D =C2=A0+3.63 V)
> ERROR: Can't get value of subfeature in2_input: I/O error
> +5V Voltage: =C2=A0 =C2=A0 =C2=A0 =C2=A0+0.00 V =C2=A0(min =3D =C2=A0=
+4.50 V, max =3D =C2=A0+5.50 V)
>
> etc. and dmesg spits out a bunch of these:
>
> ATK0110 ATK0110:00: atk_read_value_new: ACPI exception: AE_BUFFER_OVE=
RFLOW

Hum, they changed the output buffer size. I'm working on a fix.

Luca
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
