From: John Belmonte <john@neggie.net>
Subject: Re: [PATCH] Add bluetooth support to toshiba-acpi driver
Date: Mon, 22 Oct 2007 07:26:26 -0400
Message-ID: <471C88E2.3020102@neggie.net>
References: <20071021173529.GH1880@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from memebeam.org ([80.68.89.71]:4303 "EHLO jvb.vm.bytemark.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbXJVLba (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Oct 2007 07:31:30 -0400
In-Reply-To: <20071021173529.GH1880@earth.li>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> This patch adds bluetooth support to the toshiba-acpi driver. I have
> tried to follow the same format for the /proc/acpi/toshiba/bluetooth
> file as followed in the thinkpad-acpi driver. In the long term the
> rfkill infrastructure looks like the way forward for this functionali=
ty,
> but at present it doesn't seem to be suitable.
>=20
> Traditionally the userland "toshset" program would have been used to
> enable bluetooth, but this requires either CONFIG_TOSHIBA or a patche=
d
> toshiba-acpi to emulate the /dev/toshiba device. Also toshset doesn't
> currently run in 64bit mode.
>=20
> Patch has been successfully tested on a Port=E9g=E9 R200 (in 32bit mo=
de) and
> an R500 (in 64bit mode).
>=20
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>

The /proc/acpi/toshiba interface should not be expanded-- do not apply
this patch.  If any patch is applied, it would be to optionally
implement the generic /dev/toshiba interface so that user space tools
like toshset can operate.

--John Belmonte
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
