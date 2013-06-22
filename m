From: Nick Warne <nick@linicks.net>
Subject: Re: Dmesg acpi warning message - question please
Date: Sat, 22 Jun 2013 15:14:15 +0100
Message-ID: <20130622141415.GA2077@sauron>
References: <20130622112722.GA2196@sauron>
 <51C5ADC7.6050009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from linicks.net ([87.127.191.50]:46741 "EHLO mail.linicks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab3FVOOT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jun 2013 10:14:19 -0400
Content-Disposition: inline
In-Reply-To: <51C5ADC7.6050009@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi Lan,

On Sat, Jun 22, 2013 at 09:59:35PM +0800, Lan Tianyu wrote:
> =E4=BA=8E 2013/6/22 19:27, Nick Warne =E5=86=99=E9=81=93:
> >Dear Devs,
> >
> >Please could anybody explain what this message means in dmesg (and s=
yslog) when I reboot my amdx86_64 machine:
> >
> >i2c i2c-3: nForce2 SMBus adapter at 0x1c00
> >i2c i2c-4: nForce2 SMBus adapter at 0x1c40
> >it87: Found IT8712F chip at 0x290, revision 8
> >ACPI Warning: 0x0000000000000295-0x0000000000000296 SystemIO conflic=
ts with Region \IP__ 1 (20130117/utaddress-251)
> >ACPI: If an ACPI driver is available for this device, you should use=
 it instead of the native driver
> >
> Because it87 driver try to use io resource which
> is used in the ACPI table. The it87 driver will not be
> loaded successfully in this case.

Thank you - I just rebuilt kernel without it87 sensor driver and logs a=
re clean, and lm-sensors/sensors work OK.

So basically, even though I have that chip, I should just let acpi do i=
t's stuff?  I think that is what confused me.

Thanks,

Nick
--=20
=46ree Software Foundation Associate Member 5508
http://linicks.net/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
