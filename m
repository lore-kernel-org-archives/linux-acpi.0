From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Tue, 26 Feb 2008 19:49:37 +0100
Message-ID: <20080226184937.GA4280@ics.muni.cz>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl> <20080225200354.GE16513@khazad-dum.debian.net> <20080225204951.GB4432@ics.muni.cz> <20080225210113.GF16513@khazad-dum.debian.net> <20080225220720.GA4523@ics.muni.cz> <20080225230035.GA14503@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:60068 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbYBZSty (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 13:49:54 -0500
Content-Disposition: inline
In-Reply-To: <20080225230035.GA14503@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, Feb 25, 2008 at 08:00:35PM -0300, Henrique de Moraes Holschuh w=
rote:
> On Mon, 25 Feb 2008, Lukas Hejtmanek wrote:
> > volume keys work. But anything through acpid does not. Even AC/batt=
ery switch
> > is not signalized. So the bug may be somewhere else?
>=20
> Yeah, there is an EC-related regression in 2.6.25-rc3 that bites your
> thinkpad.  I don't have a link to it right now, but if you look for t=
he
> messages to LKML on the last 48h, you will find it.

this one fixes all my troubles with thinkpad hotkeys in rc3.
http://lkml.org/lkml/2008/2/25/400
=20
> > [  418.816087] thinkpad_acpi: requested hot key mask 0xffffffff, bu=
t firmware forced it to 0x00ffffff
>=20
> Don't do this.  Just let the driver select the default mask, unless y=
ou
> *really* know better.

OK, thanks.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
