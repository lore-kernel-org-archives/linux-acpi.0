From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Fri, 8 Jan 2016 15:12:17 +0000
Message-ID: <20160108151216.GJ3097@leverpostej>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <1452262581.31901.26.camel@redhat.com>
 <20160108150137.GH3097@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160108150137.GH3097@leverpostej>
Sender: linux-pci-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, Lorenzo.Pieralisi@arm.com, Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com, Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de, mw@semihalf.com, jcm@redhat.com, jchandra@broadcom.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 08, 2016 at 03:01:37PM +0000, Mark Rutland wrote:
> On Fri, Jan 08, 2016 at 09:16:21AM -0500, Mark Salter wrote:
> > On Wed, 2015-12-16 at 16:16 +0100, Tomasz Nowicki wrote:
> > > Some platforms may not be fully compliant with generic set of PCI=
 config
> > > accessors. For these cases we implement the way to overwrite acce=
ssors
> > > set before PCI buses enumeration. Algorithm that overwrite access=
ors
> > > matches against platform ID (DMI), domain and bus number, hopeful=
ly
> > > enough for all cases. All quirks can be defined using:
> > > DECLARE_ACPI_MCFG_FIXUP() and keep self contained.
> > >=20
> > > example:
> > >=20
> > > static const struct dmi_system_id yyy[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident =3D "<Platform ident string>",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.callback =3D <handler>,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.matches =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ }
> > > };
> > >=20
> >=20
> > This seems awkward to me in the case where the quirk is SoC-based a=
nd there
> > may be multiple platforms affected. Needing a DECLARE_ACPI_MCFG_FIX=
UP for
> > each platform using such a SoC (i.e. Mustang and Moonshot) doesn't =
seem
> > right. In that case, I think it'd be better to check CPUID and poss=
ibly
> > some SoC register to cover all platforms affected.
>=20
> CPUs get reused across SoCs, so as you've implicitly noted, the CPUID
> alone is insufficient.
>=20
> Given that IP blocks get moved around between SoC variants, I don't
> think you can check "some SoC register" based on the CPU ID -- you ca=
n
> end up bringing the board down at that point.
>=20
> If the CPU ID alone is insufficient to tell you about a component, it
> cannot give you enough information about a component you can use to
> query more information from.
>=20
> If your platform requires a quirk, it's always going to be painful (a=
nd
> to some extent, rightfulyl so). We should aim for correctness here wi=
th
> explicit matching.

=46urther, if there is going to be an ever-expanding set of platforms
requring quirks, then we need a standard mechanism in ACPI to enable th=
e
platform to tell us explicitly either which specific PCI implementation
is used, or which common quirk is necessary.

Thanks,
Mark.
