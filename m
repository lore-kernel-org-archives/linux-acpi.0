From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Fri, 08 Jan 2016 09:51:23 -0500
Message-ID: <1452264683.31901.32.camel@redhat.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
	 <1450278993-12664-23-git-send-email-tn@semihalf.com>
	 <1452262581.31901.26.camel@redhat.com> <568FC969.8060909@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568FC969.8060909@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 2016-01-08 at 15:36 +0100, Tomasz Nowicki wrote:
> On 08.01.2016 15:16, Mark Salter wrote:
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
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident =3D "<Platform ident string>=
",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.callback =3D <handler>,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.matches =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ }
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
> Right, my next version already has alternative to DMI match handler, =
so=C2=A0
> there will be two ways to match:
> 1. DMI, like in this patch set
> 2. int (*match)(struct pci_mcfg_fixup *) where you can read CPUID, an=
d=C2=A0
> whatever is necessary.
>=20

Great. Thanks.

> >=20
> > Also, there doesn't seem to be a way to connect a given quirk check=
 to the
> > MCFG/device requesting the ops. So if there is a platform with mult=
iple PCIE
> > roots and not all of them have quirks, how does one no whether to o=
verride the
> > default ecam ops?
> >=20
>=20
> Then we can identify them using <domain:bus>. I was wondering to pass=
=C2=A0
> acpi device handler to match handler for the case where we need e.g.=C2=
=A0
> extra properties from related DSDT device descriptor. Does it make se=
nse=C2=A0
> to you?
>=20

The thing with domain:bus is that it is really a firmware setting. So o=
n one
platform domain 0 may be associated with hwdev X but on another platfor=
m it
may be associated with hwdev Y. But yes, an acpi handle would make it m=
uch
easier for the match handler to find out which hw dev it is being asked=
 to
match.
