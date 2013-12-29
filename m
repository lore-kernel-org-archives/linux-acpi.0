From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Regression] acpi_rsdp doesn't work in 3.12.{5-6}
Date: Sun, 29 Dec 2013 15:25:30 +0100
Message-ID: <3242554.Mp2o1Ic4BX@vostro.rjw.lan>
References: <1441555.SfFoqOgBsH@note>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62476 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752091Ab3L2OL4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Dec 2013 09:11:56 -0500
In-Reply-To: <1441555.SfFoqOgBsH@note>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Vadim A. Misbakh-Soloviov" <mva@mva.name>
Cc: linux-acpi@vger.kernel.org

On Sunday, December 29, 2013 05:34:46 PM Vadim A. Misbakh-Soloviov wrot=
e:
> Hello there!
> Unfortunately I've server, that requires to manually point kernel to =
RSDP-
> table. Otherwise ACPI doesn't work properly and kernel limits process=
ors to 1.
>=20
> All the time until upgrade to 3.12.5/3.12.6 I did it by specifying=20
> acpi_rsdp=3D0x7F1F7000 to the kernel cmdline (where 0x7F1F7000 is rea=
l address=20
> of RSDP table) and all worked fine. But now, after the upgrade, kerne=
l can't=20
> find RSDP table anyway, even with redefinition in cmdline, and so it =
prints
> > [    0.000000] ACPI BIOS Error (bug): A valid RSDP was not found=20
> (20130725/tbxfroot-212)
> And boots just like I don't specified real RSDT table address for it =
(with 1=20
> processor and with broken acpi functionality).
>=20
> As far, as I investigated, probleam appeared after=20
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D40031da445fb4d269af9c7c445b2adf674f171e7

This is a merge, so it covers a whole bunch of commits.

> Unfortunately, I can't fully bisect it and get exact place.
>=20
> Can you advice me, if it is possible to redefine RSDP table now, in 3=
=2E12, and=20
> how? And if it should use same syntax =E2=80=94 why it stop working?

Can you please check if commit afdca01c9821 (Merge branch 'acpica') wor=
ks for you?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
