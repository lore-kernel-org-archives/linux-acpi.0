From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] Toshiba L30-113A ACPI Ubuntu 7.04
Date: Mon, 3 Sep 2007 11:00:54 -0400
Message-ID: <200709031100.55012.lenb@kernel.org>
References: <97720510709030356kbc968fs853d05043ea0e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39460 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbXICO5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2007 10:57:15 -0400
In-Reply-To: <97720510709030356kbc968fs853d05043ea0e1f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org

(probably linux-acpi is a better place for this thread than linux-pm...=
)


On Monday 03 September 2007 06:56, valentin Petkov wrote:
> Hi,
> In the past few days i became quite frustrated with my Toshiba Satell=
ite
> L30-113a laptop. Thing is i can't get the ACPI to work. Or should i s=
ay it
> works partially, the functional keys work, i got the sound and the wi=
reless
> working, yet an important thing in the laptop is not working =E2=80=93=
 namely the
> CPU fan.

In what way does the CPU fan not work?  Does it not spin up
when the system is under load?

> I did some research and found that Toshiba are not very Linux=20
> friendly, yet there must be some solution.
>
> So far i have done this:
>=20
> I turned on Toshiba support in the ACPI at the kernel and compile it.
> The ACPI recognized and displayed the battery and the functional keys
>=20
> #cat /proc/toshiba/ - missing
> #cat /proc/acpi/toshiba - missing
>=20
> #lsmod | grep acpi
>=20
> pcc_acpi 14080 0
> dev_acpi 12292 0
> asus_acpi 17308 0
>=20
> It is clear that toshiba_acpi is missing and the module is not loaded
>=20
> #sudo modprobe toshiba_acpi
>=20
> FATAL: Error inserting toshiba_acpi
> (/lib/modules/2.6.20-16-generic/kernel/drivers/acpi/toshiba_acpi.ko):=
 No
> such device

toshiba_acpi is a reverse engineered platform specific driver,
and it depends on specific code in the ACPI DSDT on toshiba machines.
In this case, it apparently doesn't find that code, and gives up.

Your fan should work correctly even without this driver.

Perhaps you can open a sighting at bugzilla.kernel.org and
attach the output from acpidump?

thanks,
-Len

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
