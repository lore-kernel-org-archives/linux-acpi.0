From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [GIT PULL] ACPI fixes for v4.7-rc7
Date: Sun, 10 Jul 2016 13:00:09 +0200
Message-ID: <d3bc7758-2f97-474e-bd48-19457bda8b1d@leemhuis.info>
References: <CAJZ5v0hDSZGX90hxkACwC0DktD-_Baq=+DDkR7_zv8464iHG-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from basicbox7.server-home.net ([195.137.212.29]:60173 "EHLO
	basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcGJLAN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jul 2016 07:00:13 -0400
In-Reply-To: <CAJZ5v0hDSZGX90hxkACwC0DktD-_Baq=+DDkR7_zv8464iHG-Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael!

On 08.07.2016 01:43, Rafael J. Wysocki wrote:
>
> Please pull from
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-4.7-rc7
>=20
> to receive ACPI fixes for v4.7-rc7 with top-most commit
> [=E2=80=A6]
> All of these fix recent regressions in ACPICA, in the ACPI PCI IRQ
> management code and in the ACPI AML debugger.

=46YI, it seems these changes lead to a new regression. Quoting
https://bugzilla.kernel.org/show_bug.cgi?id=3D121701

"""
> Kernel fails to boot with this commit. With the commit reverted,
> everything is fine. I cannot bisect any further - git is failing with
> "you are trying to use to much memory"(?!)
>=20
> This is a Dell Precision 5510 with the latest (1.2.10) BIOS applied.
>=20
> Let me know what additional information I can provide."""
"""

Cheers, Thorsten
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
