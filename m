From: lucas.levrel@free.fr
Subject: Re: Help/info request (in re trip points)
Date: Wed, 27 Jul 2016 12:12:39 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.13.1607271131590.4472@coulomb.u-pec.fr>
References: <alpine.LSU.2.20.13.1607221012230.4463@coulomb.u-pec.fr>  <alpine.LNX.2.20.13.1607262256590.2759@localhost> <1469582991.2367.63.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:35523 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630AbcG0KMm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jul 2016 06:12:42 -0400
Received: from [10.12.3.100] (unknown [193.48.143.176])
	(Authenticated sender: lucas.levrel)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 7BF4078039F
	for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2016 08:33:44 +0200 (CEST)
In-Reply-To: <1469582991.2367.63.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Rui,

=46irst, thank you very much for taking the time to answer!


Le 27 juillet 2016, Zhang Rui a =E9crit :
> As you have mentioned thermal.c, I think you are using ACPI thermal
> control on your platform, right?
> trip_point_?_hyst files are created by thermal core, if the platform
> thermal driver supports hysteresis, and ACPI thermal driver, which is
> used in your case, does not support=A0hysteresis.

I don't know what my system is using. In fact I know nothing about ACPI=
=2E I=20
couldn't find documentation (which doesn't mean there is no doc, just I=
=20
couldn't find it) explaining how this works. So I tried to guess,=20
gathering pieces of information by observing the behaviour of files in=20
/sys, and looking into code (but not being sure this code is relevant t=
o=20
my system!).

What I can say (I still don't know if it is valuable info):
- there is no hwmon/ directory anywhere under /sys,
- the thermal_zone* and cooling_device* directories are in
   /sys/devices/virtual/thermal.

>>> how are trip point temperatures set at boot,
>
> ACPI thermal driver gets the trip point temperature information from
> ACPI tables.

So, from some computer firmware.

>>>  and how are they reset when=A0crossed?
>>>
> Usually, ACPI trip point is not reset when crossed, but it does
> have=A0granularity, which determines when to generate a
> temperature change notification.
> Say, for a platform that the trip point temperature is 50C, and
> granularity is 5C, when the ACPI thermal driver receives a notificati=
on
> at 50C, it starts to spin the fan.
> Then next time when the ACPI thermal driver gets a temperature change
> notification, the temperature is either 55C, which means we need to
> take further action to cool the system, or the temperature is 45C and
> we can turn off the fan.
>
> In some cases, the trip point may get reset. You can refer to section
> 11.1.2 in ACPI spec 6.1. IN this case, a trip point change notificati=
on
> will be sent to thermal driver, and ACPI thermal driver will re-
> evaluate the trip point control methods to get new trip point
> temperature. But AFAICS, this is really rare.

Maybe I used the word "reset" inappropriately. Simply, I noticed the=20
contents of trip_point_4_temp changes from 50000 to 45000 when temp=20
reaches 50000 and the fan starts to spin. If the initial contents of=20
trip_point_4_temp is 60000 (thanks to the thermal.act kernel parameter)=
,=20
it also changes to 45000 when temp reaches 60000 and the fan starts to=20
spin. So it looks like in my case the turn-off temperature of 45 =B0C i=
s=20
chosen independently of the turn-on temperature. (And temp never gets d=
own=20
to this so low value of 45, so fan spins endlessly...)


>>> I'm aiming at changing the temperatures at which the fan starts and=
=20
>>> stops. The kernel parameter thermal.act=3DXXX did change the "fan o=
n"=20
>>> temperature, but not the "fan off" one. I expected the hysteresis=20
>>> T(on)-T(off) to be constant, and thus I thought T(off) would raise =
as=20
>>> much as I raised T(on), but this is not the case.
>>>
> Dynamic trip point can only be supported by platform thermal design.
> Specifying such values in userspace does not make sense, because it's
> not guaranteed that the thermal driver can get notification upon the
> values you specified, thus it would screw up the thermal control
> entirely.

Do you mean: if the system has a 5 =B0C granularity, and I had set=20
trip_point_4_temp to a value not multiple of 5 =B0C, say 53 =B0C, then =
the=20
driver would not e.g. turn off the fan when the temperature changes fro=
m=20
e.g. 55 to 50, because the driver does not check "temp <=3D=20
trip_point_4_temp" but rather "temp =3D=3D trip_point_4_temp"?


Your insight and help is much appreciated.

Best regards,
Lucas Levrel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
