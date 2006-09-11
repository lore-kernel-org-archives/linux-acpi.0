From: Stefan Seyfried <seife@suse.de>
Subject: Re: x60 - spontaneous thermal shutdown
Date: Mon, 11 Sep 2006 11:46:07 +0200
Message-ID: <20060911094607.GA14095@suse.de>
References: <20060904214059.GA1702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:15085 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932179AbWIKJqZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Sep 2006 05:46:25 -0400
Content-Disposition: inline
In-Reply-To: <20060904214059.GA1702@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

On Mon, Sep 04, 2006 at 11:40:59PM +0200, Pavel Machek wrote:
> Hi!
>=20
> x60 shut down after quite a while of uptime, in period of quite heavy
> load:
>=20
> Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shu=
tting down.
> Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
> Sep  4 23:34:42 amd init: Switching to runlevel: 0
>=20
> I do not think cpu reached 128C, as I still have my machine... Did
> anyone else see that?

my usual suspect: use ec_intr=3D0. I have seen this rather often on HP =
machines.
I attributed it to "communication problems with embedded controller" an=
d
ec_intr=3D0 seemed to help somehow. But then, this was some kernel vers=
ions
ago and i did not encounter it recently.
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write.=
"
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Co=
hen
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
