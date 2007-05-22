From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Date: Tue, 22 May 2007 08:19:27 +0200
Message-ID: <46528B6F.3050701@assembler.cz>
References: <20070513223329.GA29207@dreamland.darkstar.lan>	 <46520F36.4080006@assembler.cz> <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ms.trustica.cz ([82.208.32.68]:44541 "EHLO ms.trustica.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762042AbXEVGVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 02:21:18 -0400
In-Reply-To: <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca <kronos.it@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I have following readings:

w83627ehf-isa-0290
Adapter: ISA adapter
VCore:     +1.52 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:      +12.30 V  (min =3D +13.46 V, max =3D +13.04 V) ALARM
AVCC:      +3.36 V  (min =3D  +4.08 V, max =3D  +3.95 V) ALARM
3VCC:      +3.36 V  (min =3D  +4.05 V, max =3D  +3.06 V) ALARM
in4:       +2.04 V  (min =3D  +1.78 V, max =3D  +2.04 V)
in5:       +1.60 V  (min =3D  +2.04 V, max =3D  +2.02 V) ALARM
in6:       +5.12 V  (min =3D  +6.12 V, max =3D  +6.53 V) ALARM
VSB:       +3.36 V  (min =3D  +4.08 V, max =3D  +4.08 V) ALARM
VBAT:      +3.30 V  (min =3D  +4.08 V, max =3D  +3.04 V) ALARM
in9:       +1.65 V  (min =3D  +0.98 V, max =3D  +2.04 V)
Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 8)
CPU Fan:  1638 RPM  (min =3D    0 RPM, div =3D 4)
Aux Fan:  1436 RPM  (min =3D 4272 RPM, div =3D 4) ALARM
fan5:        0 RPM  (min =3D    0 RPM, div =3D 16)
Sys Temp:    +28=C2=B0C  (high =3D   -65=C2=B0C, hyst =3D   -34=C2=B0C)=
   ALARM
CPU Temp:  +34.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)
AUX Temp:  +38.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)

=46an4 is disabled in the chip. I think the board has 4 connectors. I d=
ont have=20
time right now to check the manual.

Rudolf

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
