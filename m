From: Lucas Levrel <lucas.levrel@u-pec.fr>
Subject: Customizing fan behaviour (temperatures)
Date: Wed, 13 Jul 2016 16:47:35 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.13.1607131543390.7774@coulomb.u-pec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gulliver.u-pec.fr ([193.48.143.11]:35095 "EHLO
	gulliver.u-pec.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcGMPUO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2016 11:20:14 -0400
Received: from gulliver.u-pec.fr (localhost [127.0.0.1])
	by gulliver.u-pec.fr (Postfix) with ESMTP id 46A74C1C06
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jul 2016 16:47:35 +0200 (CEST)
Received: from [10.12.3.100] (unknown [10.12.3.100])
	by gulliver.u-pec.fr (Postfix) with ESMTP id 356CAC1BFC
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jul 2016 16:47:35 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I would like to adjust the temperature at which the fan starts, because=
 as=20
it is now it runs continuously, at low speed but this continuous noise=20
bothers me. I'd rather have it spin faster and intermittently. This is =
an=20
HP laptop.

I've read much (mostly Q&A pages and list threads, regular documentatio=
n=20
seems to be scarce), and investigated the behaviour of files in=20
/sys/devices/virtual/thermal . From what I understand there's no bug, j=
ust=20
the temperature thresholds are not to my taste.

More specifically, there are 7 cooling_device's (4 of type Fan, 2=20
Processor, 1 LCD) and 5 thermal_zone's (the first 4 really are=20
temperatures, the last is the fan speed). thermal_zone0 controls the fa=
n.=20
The lowest trip_point_?_temp (?=3D=3D4) is 45000, which is very low.=20
Basically, after a few minutes of idle operation temp reaches 50000 or=20
55000 (looks like there is 5 =B0C granularity) and never gets lower: I'=
ve=20
tried and manually set the fan to speed 2 (echo 1 >=20
cooling_device2/cur_state), even then temp doesn't decrease below 50000=
=2E

trip_point_?_temp are not writable. I've set thermal.act=3D60000 in the=
=20
kernel command line, to no avail; is this supposed to be reflected in t=
he=20
trip_point_?_temp files? (Note: trip_point_[1-4]_type is "active".) Thi=
s=20
is kernel 3.2.71 .

What can you advise me to do now?

And by the way, for my education:
- how are the trip_point values determined?
- how is hysteresis implemented? I mean, you don't want your fan speed =
to=20
change every other second, so the "speed up" threshold has to be higher=
=20
than the "speed down" one. In fact, I've found no explanation of how th=
e=20
trip_point values are used.

Thanks.

--=20
Lucas Levrel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
