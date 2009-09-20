From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: asus_atk0110 not working on Asus P7P55D PRO
Date: Sun, 20 Sep 2009 16:51:10 -0600
Message-ID: <51f3faa70909201551k70ace90x2b25351bfc04c555@mail.gmail.com>
References: <4AB1C907.1070503@gmail.com>
	 <20090920162306.GA18214@dreamland.darkstar.lan>
	 <51f3faa70909201047x56313d99q7cdc49bcc4634b01@mail.gmail.com>
	 <20090920185824.GA23206@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:51044 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZITWvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Sep 2009 18:51:08 -0400
In-Reply-To: <20090920185824.GA23206@dreamland.darkstar.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Sun, Sep 20, 2009 at 12:58 PM, Luca Tettamanti <kronos.it@gmail.com>=
 wrote:
>> >> I'm guessing this board uses a different format than what the dri=
ver
>> >> is expecting. I'm attaching the gzipped decompiled DSDT from the
>> >> board, hopefully it's useful to somebody..
>> >
>> > Please try the following patch, it should detect the proper buffer=
 size.
>> >
>>
>> Obviously something not quite right:
>
> Ah yes, the pointer for the output buffer was pointing to the wrong
> variable. Sorry for that ;)

Cool, seems to be working. Though the high and critical temperatures
seem a bit odd, but maybe that's what the BIOS actually reports:

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +1.18 V  (min =3D  +0.80 V, max =3D  +1.60 V)
+3.3V Voltage:      +3.44 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V Voltage:        +5.18 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V Voltage:      +12.21 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU Fan Speed:     1080 RPM  (min =3D  600 RPM)
Chassis1 Fan Speed:   0 RPM  (min =3D  600 RPM)
Chassis2 Fan Speed:1464 RPM  (min =3D  600 RPM)
Power Fan Speed:      0 RPM  (min =3D    0 RPM)
CPU Temperature:    +32.5=B0C  (high =3D +45.0=B0C, crit =3D +45.5=B0C)
MB Temperature:     +31.0=B0C  (high =3D +45.0=B0C, crit =3D +46.0=B0C)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
