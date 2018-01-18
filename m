From: graeme.gregory@linaro.org
Subject: Re: [net-next: PATCH v3 0/7] Armada 7k/8k PP2 ACPI support
Date: Thu, 18 Jan 2018 15:53:16 +0000
Message-ID: <20180118155316.GA32010@xora-haswell>
References: <1516208146-4144-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516208146-4144-1-git-send-email-mw@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, andrew@lunn.ch, f.fainelli@gmail.com, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, stefanc@marvell.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, jaz@semihalf.com, tn@semihalf.com
List-Id: linux-acpi@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 05:55:39PM +0100, Marcin Wojtas wrote:
> Hi,
>=20
> This is a third version of the patchset introducing mvpp2 driver ability
> to operate with ACPI. Until follow-up generic MDIO is introduced
> it can using the link interrupt capability (a.k.a. in-band management)
> on all ports, 1000BaseT RGMII included.
> Driver operation was tested on top of the net-next branch
> with both DT and ACPI on MacchiatoBin and Armada 7040 DB boards.
>=20
> The main changes were requested during v2 review, which was
> adding generic helper routines for:
> * interating over available fwnodes (new patch 4/7)
> * getting IRQ directly from fwnode (new patch 3/7)
> Thanks to the latter the driver code could be simplified
> and allowed to drop formula-based IRQ obtaining. Changes are
> summarized in the changelog below.
>=20
> mvpp2 driver can work with the ACPI representation, as exposed
> on a public branch:
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/m=
arvell-armada-wip
> It was compiled together with the most recent Tianocore EDK2 revision.
> Please refer to the firmware build instruction on MacchiatoBin board:
> http://wiki.macchiatobin.net/tiki-index.php?page=3DBuild+from+source+-+UE=
FI+EDK+II
>=20
> ACPI representation of PP2 controllers (withouth PHY support) can
> be viewed in the github:
> * MacchiatoBin:
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/71ae=
395da1661374b0f07d1602afb1eee56e9794/Platforms/Marvell/Armada/AcpiTables/Ar=
mada80x0McBin/Dsdt.asl#L201
>=20
> * Armada 7040 DB:
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/71ae=
395da1661374b0f07d1602afb1eee56e9794/Platforms/Marvell/Armada/AcpiTables/Ar=
mada70x0/Dsdt.asl#L131
>=20
> I will appreciate any comments or remarks.
>=20

Nice work, this looks pretty neat to me, for series.

Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>

Thanks

Graeme

> Best regards,
> Marcin
>=20
> Changelog:
> v2 -> v3:
> * 1/7, 2/7
>     - Add Rafael's Acked-by's
> * 3/7, 4/7
>     - New patches
> * 6/7, 7/7
>     - Update driver with new helper routines usage
>     - Improve commit log.
>=20
> v1 -> v2:
> * Remove MDIO patches
> * Use PP2 ports only with link interrupts
> * Release second region resources in mvpp2 driver (code moved from
>   mvmdio), as explained in details in 5/5 commit message.
>=20
>=20
> Marcin Wojtas (7):
>   device property: Introduce fwnode_get_mac_address()
>   device property: Introduce fwnode_get_phy_mode()
>   device property: Introduce fwnode_irq_get()
>   device property: Allow iterating over available child fwnodes
>   net: mvpp2: simplify maintaining enabled ports' list
>   net: mvpp2: use device_*/fwnode_* APIs instead of of_*
>   net: mvpp2: enable ACPI support in the driver
>=20
>  drivers/base/property.c              | 105 ++++++++--
>  drivers/net/ethernet/marvell/mvpp2.c | 206 ++++++++++++--------
>  include/linux/property.h             |  11 ++
>  3 files changed, 230 insertions(+), 92 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEenb+qYJ1KjE/UpmZkGKawB22KXYFAlpgwt0ACgkQkGKawB22
KXa2shAAxtbh0QuiXwdwL1qSrAUMp47nJu/oojSCPwdcu4mphkdYu7kNRJE0iapM
PYfXxxWd4FOb3JzH3UU3eKxBk/Oj7zkUqPIg2xQ6T27jT1SmXLiN+0XFQlLeKnqf
Y4dmlTtq778e5pwIxznqAyWj/Pl4x4DsybXhvv5wxdT/quAWkf0k7cky8Q/2NT3F
7arwFskMP1h8iQVllmsgrGOLfPf+7XWIB68z1RmfBiZsR6oBiw40snWKsfF1WhON
kSjtBAAT2DhTGaYtuH33R9gbjktCzn+c015KBNszutB4rLEw0fNpt0ffolZJDVhA
3F/+cPZBsHJbAvaHOUV4Oq5C4YAMh/qQpxUgdWiGeCjdCwJXanxg8YIk1+WUiLcz
Yh4S3BfJQQMnQfQQGxrX7cyJw38HtjUsHrgfz2xHuFQbMIvMtZRQjXwJcFB5D7fJ
RuBQt+M8TWq0mvevzhgWimIMP52KZT0rtXOljXyTMvX3ijmLBSWnqAryQ2nwMTzA
mvgIJkVnXXPE/lO7YaTO3d9Z5nbf+FPpcpDvMGScPAV8JUmIMtnbi2z43nO7Ctj4
RH3se7pUlq9tVkghEIJHajAGQ6XDEjEAkfNo46lXWENovTYwfcIrB6noTqimQoAE
6QJjC1/IMgku505tiIEiO9qh3FwEz6kUKd5X2PFgR3tLvPrLbAk=
=IRpx
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
