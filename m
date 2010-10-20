From: Ingo Molnar <mingo@elte.hu>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
 interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 17:24:53 +0200
Message-ID: <20101020152453.GD22271@elte.hu>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com>
 <20101020134848.GB7970@elte.hu>
 <AANLkTi=LWrOKow7Nw8dr_YZTeMGncP+Vowz3EZK5vShD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=LWrOKow7Nw8dr_YZTeMGncP+Vowz3EZK5vShD@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Junio C Hamano <gitster@pobox.com>, sassmann@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Oct 20, 2010 at 6:48 AM, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > I re-created the merge commit the following way:
> >
> > =A0git checkout c2f4398 =A0 =A0 =A0 =A0 =A0 # has old drivers/acpi/=
pci_irq.c
> > =A0git merge 662c319 =A0 =A0 =A0 =A0 =A0 =A0 =A0# contains new driv=
ers/acpi/pci_irq.c bits
>=20
> The other way around. The c2f4398 version is the new one, the 662c319=
 is the old=20
> one. So git picks the new one.

Ah, indeed - i got confused by the fact that the newer tree had the 'ol=
der' content=20
of drivers/acpi/pci_irq.c. (which was really a new version as you noted=
)

=46ound the right commit as well - that chunk got zapped by:

 |
 | commit ec9f168fcc344d2ffec1c8c822076bf22dab5c33
 | Merge: b2576e1 087da3b
 | Author: Len Brown <len.brown@intel.com>
 | Date:   Fri Jan 9 03:41:08 2009 -0500
 |
 |    Merge branch 'simplify_PRT' into release
 |   =20
 |    Conflicts:
 |        drivers/acpi/pci_irq.c
 |   =20
 |    Note that this merge disables
 |    e1d3a90846b40ad3160bf4b648d36c6badad39ac
 |    pci, acpi: reroute PCI interrupt to legacy boot interrupt equival=
ent
 |   =20
 |    Signed-off-by: Len Brown <len.brown@intel.com>
 |

And was marked thusly by Len. So everything is in order - this chunk fe=
ll victim to=20
non-trivial merge complications and needs a resurrection.

Thanks,

	Ingo
