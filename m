From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: Dmesg acpi warning message - question please
Date: Sat, 22 Jun 2013 21:59:35 +0800
Message-ID: <51C5ADC7.6050009@gmail.com>
References: <20130622112722.GA2196@sauron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:50311 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab3FVN7n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jun 2013 09:59:43 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so9075606pac.29
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jun 2013 06:59:42 -0700 (PDT)
In-Reply-To: <20130622112722.GA2196@sauron>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nick Warne <nick@linicks.net>
Cc: linux-acpi@vger.kernel.org

=E4=BA=8E 2013/6/22 19:27, Nick Warne =E5=86=99=E9=81=93:
> Dear Devs,
>
> Please could anybody explain what this message means in dmesg (and sy=
slog) when I reboot my amdx86_64 machine:
>
> i2c i2c-3: nForce2 SMBus adapter at 0x1c00
> i2c i2c-4: nForce2 SMBus adapter at 0x1c40
> it87: Found IT8712F chip at 0x290, revision 8
> ACPI Warning: 0x0000000000000295-0x0000000000000296 SystemIO conflict=
s with Region \IP__ 1 (20130117/utaddress-251)
> ACPI: If an ACPI driver is available for this device, you should use =
it instead of the native driver
>
Because it87 driver try to use io resource which
is used in the ACPI table. The it87 driver will not be
loaded successfully in this case.

> Please cc: me, as I am not subscribed.
>
> Kind Regards,
>
> Nick
>

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
