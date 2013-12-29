From: "Vadim A. Misbakh-Soloviov" <mva@mva.name>
Subject: [Regression] acpi_rsdp doesn't work in 3.12.{5-6}
Date: Sun, 29 Dec 2013 17:34:46 +0700
Message-ID: <1441555.SfFoqOgBsH@note>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward1h.mail.yandex.net ([84.201.187.146]:41286 "EHLO
	forward1h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab3L2Kew convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Dec 2013 05:34:52 -0500
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
	by forward1h.mail.yandex.net (Yandex) with ESMTP id 137A09E133B
	for <linux-acpi@vger.kernel.org>; Sun, 29 Dec 2013 14:34:47 +0400 (MSK)
Received: from smtp2h.mail.yandex.net (localhost [127.0.0.1])
	by smtp2h.mail.yandex.net (Yandex) with ESMTP id CFD8117017EC
	for <linux-acpi@vger.kernel.org>; Sun, 29 Dec 2013 14:34:47 +0400 (MSK)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello there!
Unfortunately I've server, that requires to manually point kernel to RS=
DP-
table. Otherwise ACPI doesn't work properly and kernel limits processor=
s to 1.

All the time until upgrade to 3.12.5/3.12.6 I did it by specifying=20
acpi_rsdp=3D0x7F1F7000 to the kernel cmdline (where 0x7F1F7000 is real =
address=20
of RSDP table) and all worked fine. But now, after the upgrade, kernel =
can't=20
find RSDP table anyway, even with redefinition in cmdline, and so it pr=
ints
> [    0.000000] ACPI BIOS Error (bug): A valid RSDP was not found=20
(20130725/tbxfroot-212)
And boots just like I don't specified real RSDT table address for it (w=
ith 1=20
processor and with broken acpi functionality).

As far, as I investigated, probleam appeared after=20
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D40031da445fb4d269af9c7c445b2adf674f171e7

Unfortunately, I can't fully bisect it and get exact place.

Can you advice me, if it is possible to redefine RSDP table now, in 3.1=
2, and=20
how? And if it should use same syntax =E2=80=94 why it stop working?

--=20
Best regsrds,
mva
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
