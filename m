From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: lenovo ultrabay docking station: if power button pressed 1x it creates 2x the same ACPI event
Date: Mon, 22 Dec 2014 23:46:37 +0100
Message-ID: <1712969.2BqpevJf26@vostro.rjw.lan>
References: <5497ED42.2050003@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63511 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753853AbaLVWYn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Dec 2014 17:24:43 -0500
In-Reply-To: <5497ED42.2050003@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Monday, December 22, 2014 11:06:58 AM Toralf F=C3=B6rster wrote:
> This happens at a Lenovo T440s (took me some time to realize why my s=
uspend/resume script runs twice).
>=20
> Is this a known issue ?

Well, not in general.

What kernel is this?

Anyway, please file a bug entry at bugzilla.kernel.org for this sightin=
g
so that we don't lose it from our radar.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
