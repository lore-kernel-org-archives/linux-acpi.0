From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc1 regression - IBM ACPI backlight
Date: Fri, 15 Feb 2008 13:53:19 +0100
Message-ID: <20080215125318.GC4269@ics.muni.cz>
References: <20080214103801.GB4366@ics.muni.cz> <20080214122452.GB12775@khazad-dum.debian.net> <20080215110213.GA5648@ics.muni.cz> <20080215120720.GA31578@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:36767 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802AbYBOMxY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 07:53:24 -0500
Content-Disposition: inline
In-Reply-To: <20080215120720.GA31578@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 12:07:20PM +0000, Matthew Garrett wrote:
> On Fri, Feb 15, 2008 at 12:02:13PM +0100, Lukas Hejtmanek wrote:
> > 2.6.24 kernel has two acpi_video[01]. 2.6.25-rc1 does not, it conta=
ins only
> > acpi_video0 (even in text mode in single user without X being loade=
d) which
> > does not work at all.
>=20
> Sigh. Ok. Could you attach the output of acpidump and lspci, please?=20
> I'll try to figure out why this is wrong.

I created a bug report here including acpidump and lspci:
http://bugzilla.kernel.org/show_bug.cgi?id=3D9995

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
