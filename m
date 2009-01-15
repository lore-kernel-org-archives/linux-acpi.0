From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [2.6.28] Kernel panic after closing lid on HP 2510p
Date: Thu, 15 Jan 2009 12:20:58 +0800
Message-ID: <20090115042058.GA4073@localhost>
References: <200901121356.46236.elendil@planet.nl> <20090113123056.GA2464@deprecation.cyrius.com> <20090114162603.c632d82e.akpm@linux-foundation.org> <20090115020311.GA18740@srcf.ucam.org> <20090114181542.34614acf.akpm@linux-foundation.org> <20090115022106.GA19069@srcf.ucam.org> <1231988103.20746.149.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55776 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524AbZAOEVK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jan 2009 23:21:10 -0500
Content-Disposition: inline
In-Reply-To: <1231988103.20746.149.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Michlmayr <tbm@cyrius.com>, "elendil@planet.nl" <elendil@planet.nl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>

On Thu, Jan 15, 2009 at 04:55:03AM +0200, Zhang, Rui wrote:
> On Thu, 2009-01-15 at 10:21 +0800, Matthew Garrett wrote:
> > On Wed, Jan 14, 2009 at 06:15:42PM -0800, Andrew Morton wrote:
> > > On Thu, 15 Jan 2009 02:03:11 +0000 Matthew Garrett <mjg59@srcf.uc=
am.org> wrote:
> > > > Lid actions typically trigger SMI code, so it's entirely capabl=
e of=20
> > > > destroying CPU state in such a way that the kernel falls over (=
and=20
> > > > probably even in ways that cause the kernel to turn green, emit=
 pleasing=20
> > > > warbling noises or invade neighbouring pieces of hardware). In =
this case=20
> > > > it seems to be SMP specific - the system's entirely stable in U=
P mode.=20
> > > > It's greatly vexing.
> > >=20
> > > Does it always crash in the same way?
> >=20
> > Not in my experience. Sometimes it falls over in the ACPI parsing c=
ode,=20
> > but sometimes the backtrace is nonsense and the IP is in the middle=
 of=20
> > nowhere. I've now got a working 2510p again, so maybe I'll have tim=
e to=20
> > look at this on the way to LCA.
> >=20
> please check if this is a duplicate of bug #11259.
> http://bugzilla.kernel.org/show_bug.cgi?id=3D11259
>=20
>=20
> We (Wu, fengguang and me) reproduced this bug on a HP 6910p.
> and we found that windows run a different AML code path when closing =
Lid
> on this laptop and the SMI is not invoked...
> And I have verified how to make Linux run the same code path by chang=
ing
> the IGD OpRegion code.
>=20
> DIDL is an IGD OpRegion field, as the Supported Display Devices ID Li=
st.
> =EF=BB=BFit's evaluated by the _DOD method when ACPI video driver is =
loaded.
> And according to the spec, "The graphics driver writes to this field
> once during its initialization"
> if DIDL is not empty, a flag is set and the SMI will not be invoked w=
hen
> closing the lid.
> In our tests, this field (DIDL) is set in windows when _DOD is invoke=
d
> while it's not in Linux.
> I can workaround this bug by setting the DIDL manually in AML code.
>=20
> So a patch setting the DIDL in i915_opregion.c should be a proper fix
> for this problem. Fengguang will cook up a patch later.

I found it not easy given the required sequence of operations:
=46or this specific bug, opregion DIDL entry must be set before the
*first* _DOD invocation, i.e. the ACPI video module loading time.

This means=20
        - opregion module must be loaded before ACPI video module
        - the opregion DIDL setting code must run in module init time,
          instead of the current implemented startx time.
          However, how can the opregion module get the right DIDL data
          without the help of Xorg and intel driver? Maybe kernel mode
          setting?

So the module dependencies could be:
        ACPI video =3D> i915 opregion =3D> kernel mode setting

The latter dependency should be a reasonable one, but does the first
one make sense in general?

Or is it possible to delay the first _DOD invocation in ACPI video?

Thanks,
=46engguang
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
