From: Lucas Levrel <lucas.levrel@u-pec.fr>
Subject: Re: Customizing fan behaviour (temperatures)
Date: Wed, 13 Jul 2016 22:16:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.13.1607132207120.2512@localhost>
References: <alpine.LSU.2.20.13.1607131543390.7774@coulomb.u-pec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:49801 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGMUXw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2016 16:23:52 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 60DAACAA0BE
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jul 2016 22:17:01 +0200 (CEST)
Received: from [192.168.1.10] (unknown [82.233.253.129])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 54ED4780304
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jul 2016 18:36:50 +0200 (CEST)
In-Reply-To: <alpine.LSU.2.20.13.1607131543390.7774@coulomb.u-pec.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Le 13 juillet 2016, Lucas Levrel a =E9crit :

> Hi,
>
> I would like to adjust the temperature at which the fan starts, becau=
se as it=20
> is now it runs continuously, at low speed but this continuous noise b=
others=20
> me. I'd rather have it spin faster and intermittently. This is an HP =
laptop.
>
> I've read much (mostly Q&A pages and list threads, regular documentat=
ion=20
> seems to be scarce), and investigated the behaviour of files in=20
> /sys/devices/virtual/thermal . From what I understand there's no bug,=
 just=20
> the temperature thresholds are not to my taste.
>
> More specifically, there are 7 cooling_device's (4 of type Fan, 2 Pro=
cessor,=20
> 1 LCD) and 5 thermal_zone's (the first 4 really are temperatures, the=
 last is=20
> the fan speed). thermal_zone0 controls the fan. The lowest trip_point=
_?_temp=20
> (?=3D=3D4) is 45000, which is very low. Basically, after a few minute=
s of idle=20
> operation temp reaches 50000 or 55000 (looks like there is 5 =B0C gra=
nularity)=20
> and never gets lower: I've tried and manually set the fan to speed 2 =
(echo 1=20
>> cooling_device2/cur_state), even then temp doesn't decrease below 50=
000.
>
> trip_point_?_temp are not writable. I've set thermal.act=3D60000 in t=
he kernel=20
> command line, to no avail; is this supposed to be reflected in the=20
> trip_point_?_temp files? (Note: trip_point_[1-4]_type is "active".) T=
his is=20
> kernel 3.2.71 .
>
> What can you advise me to do now?
>
> And by the way, for my education:
> - how are the trip_point values determined?
> - how is hysteresis implemented? I mean, you don't want your fan spee=
d to=20
> change every other second, so the "speed up" threshold has to be high=
er than=20
> the "speed down" one. In fact, I've found no explanation of how the=20
> trip_point values are used.
>
> Thanks.

Hi again,

After investigating some more, I found how hysteresis works: the=20
trip_point_?_temp changes when it is crossed. In my case,=20
trip_point_4_temp is 50000 at first (by default), and goes down to 4500=
0=20
when the fan starts.

This is also why I saw no effect of thermal.act=3D60000 last time I tes=
ted:=20
during boot the temperature reaches this threshold, and trip_point_4_te=
mp=20
is set to 45000.

I remain with the following questions:
- how are the trip_point values determined?
- is there a way to set them to taste? More specifically, I would like =
to=20
rise the "fan stop" trigger temp; thermal.act=3D visibly didn't change=20
this...

Thanks again.

--=20
Lucas Levrel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
