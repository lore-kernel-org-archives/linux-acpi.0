From: Lucas Levrel <lucas.levrel@free.fr>
Subject: Re: Help/info request (in re trip points)
Date: Tue, 26 Jul 2016 23:01:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.13.1607262256590.2759@localhost>
References: <alpine.LSU.2.20.13.1607221012230.4463@coulomb.u-pec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:53672 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486AbcGZVJf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2016 17:09:35 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id AE4D0CDBDBD
	for <linux-acpi@vger.kernel.org>; Tue, 26 Jul 2016 23:02:00 +0200 (CEST)
Received: from [192.168.1.10] (unknown [82.233.253.129])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id ECD5C7802D6
	for <linux-acpi@vger.kernel.org>; Tue, 26 Jul 2016 19:22:58 +0200 (CEST)
In-Reply-To: <alpine.LSU.2.20.13.1607221012230.4463@coulomb.u-pec.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi (once more),

Isn't there anyone who could spare a few minutes to guide me on this?

I found some references to trip_point_?_hyst files, which seem promisin=
g,=20
but they aren't there in my sysfs, and I cannot create them (e.g. "touc=
h:=20
cannot touch `trip_point_4_hyst': No such file or directory").

Thanks.

Lucas Levrel

Le 22 juillet 2016, Lucas Levrel a =E9crit :

> Hi,
>
> Is this the right place to request for help and/or information about =
thermal=20
> zones? If not, please point me to the right place.
>
> I browsed through thermal.c but couldn't find an answer to my questio=
n (it=20
> goes without saying I'm not an expert), namely:
> how are trip point temperatures set at boot, and how are they reset w=
hen=20
> crossed?
>
> I'm aiming at changing the temperatures at which the fan starts and s=
tops.=20
> The kernel parameter thermal.act=3DXXX did change the "fan on" temper=
ature, but=20
> not the "fan off" one. I expected the hysteresis T(on)-T(off) to be c=
onstant,=20
> and thus I thought T(off) would raise as much as I raised T(on), but =
this is=20
> not the case.
>
> Any help is greatly appreciated.
>
> Lucas Levrel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
