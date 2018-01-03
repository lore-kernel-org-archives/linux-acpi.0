From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Wed, 3 Jan 2018 11:00:48 +0000
Message-ID: <20180103110048.GA21230@xora-haswell>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34284 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeACLAx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2018 06:00:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so19701429wmg.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2018 03:00:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, ezequiel.garcia@free-electrons.com, Nadav Haklai <nadavh@marvell.com>, Neta


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 10:40:31AM +0100, Ard Biesheuvel wrote:
> On 18 December 2017 at 10:17, Marcin Wojtas <mw@semihalf.com> wrote:
> > Hi,
> >
> > This patchset introduces ACPI support in mvpp2 and mvmdio drivers.
> > First three patches introduce fwnode helpers for obtaining PHY
> > information from nodes and also MDIO fwnode API for registering
> > the bus with its PHY/devices.
> >
> > Following patches update code of the mvmdio and mvpp2 drivers
> > to support ACPI tables handling. The latter is done in 4 steps,
> > as can be seen in the commits. For the details, please
> > refer to the commit messages.
> >
> > Drivers operation was tested on top of the net-next branch
> > with both DT and ACPI. Although for compatibility reasons
> > with older platforms, the mvmdio driver keeps using
> > of_ MDIO registering, new fwnode_ one proved to fully work
> > with DT as well (tested on MacchiatoBin board).
> >
> > mvpp2/mvmdio driver can work with the ACPI representation, as exposed
> > on a public branch:
> > https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits=
/marvell-armada-wip
> > It was compiled together with the most recent Tianocore EDK2 revision.
> > Please refer to the firmware build instruction on MacchiatoBin board:
> > http://wiki.macchiatobin.net/tiki-index.php?page=3DBuild+from+source+-+=
UEFI+EDK+II
> >
> > Above support configures 1G to use its PHY normally. 10G can work now
> > only with the link interrupt mode. Somehow reading of the
> > string property in fwnode_mdiobus_child_is_phy works only with
> > DT and cannot cope with 10G PHY nodes as in:
> > https://pastebin.com/3JnYpU0A
> >
> > Above root cause will be further checked. In the meantime I will
> > appreciate any comments or remarks for the kernel patches.
> >
>=20
> Hi Marcin,
>=20
> I have added linux-acpi and Graeme to cc. I think it makes sense to
> discuss the way you describe the device topology before looking at the
> patches in more detail.
>=20
> In particular, I would like to request feedback on the use of
> [redundant] 'reg' properties and the use of _DSD + compatible to
> describe PHYs. Usually, we try to avoid this, given that it is
> essentially a ACPI encapsulated DT dialect that is difficult to
> support in drivers unless they are based on DT to begin with. Also,
> non-standard _DSD properties require a vendor prefix, it is not
> freeform.
>=20
> For reference, the ACPI description is here (starting at line 175)
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/72d5=
ac23b20dd74d479daa5e40ba443264b31261/Platforms/Marvell/Armada/AcpiTables/Ar=
mada80x0McBin/Dsdt.asl
>=20
So the representation of PHY's with _DSD was kind of formalised here

http://www.uefi.org/sites/default/files/resources/nic-request-v2.pdf

This is already in use in the kernel, and that DSDT seems to be along the s=
ame
lines. So seems ok in that manner.

The "reg", 0 property seems a little odd, it would probably make more
sense to check for the lack of ranges passed in in ACPI manner _CRS.

Graeme


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEenb+qYJ1KjE/UpmZkGKawB22KXYFAlpMt8kACgkQkGKawB22
KXa1nw/+OTGt355Z/pmZ1DMtMkM9CQ4A41tso9bzrnv/JEBIRnxAwBYPl5pK07bC
MHJ3RluxvDcJUOPqae3jR4fwW/dvEdyyVwUvsLB5mNM/KtjbLI7mY5R13OSCCnSh
n9wlwcpNBsjbaGOWHZ4HB4qfnK687mtLWzQt61KFFJeemzS22v3w7+H/ZRz8epEW
IXJrRxn7nYQ5nFe7wYzAlihLEB0t5ZEbEXfOmKltuaML0dFKO3YDr3J/jc0G4Ixu
FshF414Htp+fn2pwwjtKQnXsB+r4+VOsVWCLVGCIPZUlFhyvJanHckl3/hQ1alVn
+eL4FsJ+o59Q07+5u3MsDHEpPXLy8Znjc+OkuJ47fuqTpzz9KKQ4g5/J7t6fFLX5
9QMy0B798ndO1WEl0BgO/XFsGnSEyX2Z610Jgc6psHFRfLw5C+y+XPCl7Q8U9SIA
vrjBFaNnJHB9q5JQ0/C0P9iS3B3I8oPWqhELysbKRWmuW2HNmvAF2wWYSbifPA7g
OWSbc+Dyc2B+geyevJ3ZogTcbjLjy/QpRUKkdqosKRkjEJF0pAAGrj0f2296W/H3
IP5UVd/kCLMifjSyXmJtE7/M/Va7P3ZUt5ayeZdFdmaMcq9ZspD4NqVpsoS8wjvU
gJA6gC3jdEKRNJCsA26x+xS5bgvvAy8tByWCQms7c9Ogrbfl970=
=DJdY
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
