From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/5] resources: add arch hook for preventing allocation
 in reserved areas
Date: Sat, 11 Dec 2010 20:16:15 -0800
Message-ID: <20101211201615.79186de7@jbarnes-desktop>
References: <20101208213606.13026.47657.stgit@bob.kio>
	<20101210123008.7fed582d@jbarnes-desktop>
	<20101210123609.73c12a23@jbarnes-desktop>
	<201012101407.24419.bjorn.helgaas@hp.com>
	<20101210173749.7ec3cc28@jbarnes-desktop>
	<AANLkTi=b5pq+RhA1DpyyRaLEQxQFOrf4aEXHrG-Qjqbt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=b5pq+RhA1DpyyRaLEQxQFOrf4aEXHrG-Qjqbt@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>, Matthew Garrett <mjg@redhat.com>, Dan Williams <dcbw@redhat.com>, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Sat, 11 Dec 2010 19:34:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 10, 2010 at 5:37 PM, Jesse Barnes <jbarnes@virtuousgeek.o=
rg> wrote:
> >
> > Thanks, I'll add Dan and Rafael's tested-bys to the patches (they'r=
e
> > already in my for-linus tree). =C2=A0Unless Linus has a problem wit=
h them
> > I'll send them over to him this weekend or Monday.
>=20
> See my other email I just sent out.
>=20
> I really am not going to take some totally new experimental and hacky
> major PCI resource management thing this late in the -rc game. No way=
,
> no how.
>=20
> If the top-down allocator is causing regressions that cannot be fixed
> by _simple_ patches, we're simply going to have to undo it. What's th=
e
> advantage of top-down? None. Not if we then need all this crap, which
> we could as easily do on top of the bottom-up one WITHOUT any
> regressions.
>=20
> Why isn't anybody else questioning the whole basic premise here?

Questioning the whole premise is fine, but so far we've gone in (or at
least think we're going in) a consistent direction: behave like Windows
on platforms designed for Windows to avoid bugs that Windows doesn't
hit and enable all the same devices Windows allows.

But yes, I really don't like the nx6325 patch either; there's obviously
something we're still missing that's preventing us from doing the right
thing on that platform.  Quirking it isn't a good long term answer.

--=20
Jesse Barnes, Intel Open Source Technology Center
