From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: How should I handle device with two PNP-BIOS ids?
Date: Tue, 27 Jan 2009 19:17:52 +0200
Message-ID: <20090127171752.GI4996@sci.fi>
References: <497d80991ef709.35340258@wp.pl> <200901261513.32348.bjorn.helgaas@hp.com> <20090127094255.fc038987.krzysztof.h1@wp.pl> <200901270852.52153.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756926AbZA0RSQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200901270852.52153.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Adam Belay <abelay@mit.edu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 27, 2009 at 08:52:51AM -0700, Bjorn Helgaas wrote:
> On Tuesday 27 January 2009 01:42:55 am Krzysztof Helt wrote:
> > On Mon, 26 Jan 2009 15:13:31 -0700
> > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > Systems with the old chip probably report the device with a singl=
e
> > > PNP ID.  For PNPBIOS, that would be the "device product identifie=
r."
> > > For ACPI, it would be the _HID.
> > >=20
> > > Systems with the new chip should report both PNP IDs.  The PNPBIO=
S
> > > device product identifier or the ACPI _HID should be the new ID, =
and
> > > the older ID for backward compatibility should be reported in the
> > > PNPBIOS "compatible device identifiers" list or the ACPI _CID.
> > >=20
> > > The driver would list both IDs in the pnp_device_id table, and it
> > > looks like the driver probe routine gets called with the ID that
> > > matched.
> > >=20
> > > I don't see any drivers that actually do this, but I think the
> > > probe routine should be able to look at the ID that matched and
> > > determine whether the additional I/O range is present.
> >=20
> > The laptop in question is the Dell Latitude CPi and it does not
> > have ACPI only the PnP BIOS.=20
> > The both ids are reported as unrelated (two separate nodes in=20
> > the /sys/bus/pnp/).
>=20
> Oh.  That sounds like a BIOS bug.  If there's only one actual
> chip, the BIOS should not report it as two separate devices.

It's not a bug. The cs423x chips contain several logical devices.
WSS, MPU401, joystick etc. The control logical device (which is
not present in the early models) is unfortunately some kind of dumping
ground for new registers to keep the other logical devices' backwards
compatible. It contains at least some extra mixer control registers and
power management registers.

The datasheets are available at ftp.alsa-project.org.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
