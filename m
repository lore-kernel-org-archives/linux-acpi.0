From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: acpi problems on a medion 8800 desktop pc
Date: Sun, 28 Oct 2007 00:00:04 +0400
Message-ID: <472398C4.1030308@gmail.com>
References: <200710272055.27056.bart.van.rillaer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:52996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbXJ0UAZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 16:00:25 -0400
Received: by ug-out-1314.google.com with SMTP id z38so826998ugc
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 13:00:24 -0700 (PDT)
In-Reply-To: <200710272055.27056.bart.van.rillaer@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bart <bart.van.rillaer@gmail.com>
Cc: linux-acpi@vger.kernel.org

Bart wrote:
> Hi,
>=20
> Currently I'm having two acpi problems on linux.
>=20
> 1. My temperature is reported as -47=B0C (THRM/temperature).
> 2. And sometimes the pc is automatically shutdown due to a critical=20
> temperature event (not often).
=46irst, check if you use lm_sensors.
They work with the same hardware as ACPI, and might cause wrong reading=
s.
>=20
> I've tried to decompile it with iasl and changed some dsdt logic
> but I am not able to solve the problem.
>=20
> I've fixed some errors and I also tried to remove the operating
> system checks in the DSDT so the same logic is executed on linux
> as on windows, however without success.
>=20
> Any feedback would be very appreciated on how I can solve
> these problems.=20
>=20
> In attachment you can see my dsdt.dat.=20
>=20
> Kind regards,
>=20
> Bart Van Rillaer
>=20
>=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
