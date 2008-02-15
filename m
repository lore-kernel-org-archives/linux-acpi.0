From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc1 regression - IBM ACPI backlight
Date: Fri, 15 Feb 2008 12:02:13 +0100
Message-ID: <20080215110213.GA5648@ics.muni.cz>
References: <20080214103801.GB4366@ics.muni.cz> <20080214122452.GB12775@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:46566 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759244AbYBOLCT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 06:02:19 -0500
Content-Disposition: inline
In-Reply-To: <20080214122452.GB12775@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Feb 14, 2008 at 10:24:52AM -0200, Henrique de Moraes Holschuh w=
rote:
> > as of 2.6.25-rc1, there is no more /sys/class/backlight/acpi_video1=
 which
> > controlled LVDS backlight on Lenovo ThinkPad T61. There is still
> > acpi_video0 which seems to have sane values but echo N > brightness=
 has no
> > effect at all.
> >=20
> > thinkpad_acpi module reports that ACPI controlled backlight is pres=
ent.
>=20
> Please report this to linux-acpi @ vger . kernel . org...
>=20
> It is likely caused by the stuff to locate and disable the unused vid=
eo
> device in the DSDT (apparently it got the wrong device?!).
>=20
> However, BEFORE reporting to linux-acpi, please test it in single use=
r mode
> without X *ever* being loaded on that boot.  New X disables the BIOS
> brightness changes that ACPI uses.

2.6.24 kernel has two acpi_video[01]. 2.6.25-rc1 does not, it contains =
only
acpi_video0 (even in text mode in single user without X being loaded) w=
hich
does not work at all.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
