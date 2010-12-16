From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/9] PCI: revert to allocating bottom-up, avoid E820
 areas
Date: Thu, 16 Dec 2010 14:03:21 -0800
Message-ID: <20101216140321.1a75ccef@jbarnes-desktop>
References: <20101216173614.8185.19462.stgit@bob.kio>
	<AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Dec 2010 13:59:33 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com>=
 wrote:
> >
> > So I think the best band-aid for now is to revert to bottom-up allo=
cation
> > and do a better job of avoiding E820 reserved areas. =C2=A0Obviousl=
y, it's not
> > complete because we could still trip over ACPI devices (as in 23802=
), but
> > that's a problem we've always had and it's not as likely if we go b=
ottom-up.
>=20
> Ok, ack for this series. Have we got testers for it? In particular,
> have the people who have seen regressions been notified of this new
> series?
>=20
> That said, let's just try to merge it quickly so that we get maximal
> coverage before the holiday season starts. Jesse, it makes sense
> through your tree, but if you'd rather me take it directly, I can do
> that.

I'll pull it into my tree and send you a pull req tomorrow if that's
ok.  I have a couple of fixes besides this, but I have to drop Bjorn's
earlier series...

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center
