From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Mon, 04 Jan 2016 14:50:57 +0100
Message-ID: <2131424.aXhRMSo6AO@vostro.rjw.lan>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org> <6338540.F7x0ET9vtV@vostro.rjw.lan> <CAHp75VfKeJodVtTLUS=dzzOgjydsRSEiLyLRbLQn5SW=CyVFnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfKeJodVtTLUS=dzzOgjydsRSEiLyLRbLQn5SW=CyVFnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, jcm@redhat.com, helgaas@kernel.org, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, January 04, 2016 11:01:05 AM Andy Shevchenko wrote:
> On Fri, Jan 1, 2016 at 2:48 AM, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> > On Wednesday, December 30, 2015 09:55:35 PM Andy Shevchenko wrote:
> >> On Wed, Dec 30, 2015 at 9:17 PM, Sinan Kaya <okaya@codeaurora.org>=
 wrote:
> >> > On 12/30/2015 8:28 AM, Andy Shevchenko wrote:
> >> >> Yep, I meant not to use an additional variable.
> >> >>
> >> >>> > BTW, I suggest you spend some time around checkpatch for con=
tributions. I could
> >> >>> > have caught most of the issues you are generally concerned b=
efore submitting a patch.
> >> >> Is it a question?
> >> >
> >> > It is a request not a question. I hate wasting your time and my =
time with things that I could
> >> > have fixed before submitting a patch.
> >> >
> >> > I ran the checkpatch and it said I'm good to go. But, obviously =
I'm not.
> >>
> >> Hmm=E2=80=A6 checkpatch.pl is just a small helper to fix style iss=
ues. Here is
> >> just a common sense rule, or kind of Occam's razor: no need to hav=
e
> >> more variables then needed if it doesn't improve something really
> >> significantly.
> >
> > That said, compilers optimize things anyway, so using an extra loca=
l variable
> > shouldn't matter for the resulting machine code.
>=20
> I'm not totally against that, but is the additional variable helpful =
here?

Well, I guess you can argue both ways.

Surely, the same result can be achieved with fewer lines of code if tha=
t's
what you mean, so what about the following change on top of the $subjec=
t patch?

---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI / PCI: Simplify acpi_penalize_isa_irq()

acpi_penalize_isa_irq() can be written in fewer lines of code,
so do that.  No functional change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_link.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/acpi/pci_link.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/pci_link.c
+++ linux-pm/drivers/acpi/pci_link.c
@@ -877,17 +877,9 @@ static int __init acpi_irq_penalty_updat
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
-	int penalty;
-
-	if (irq < 0)
-		return;
-
-	if (active)
-		penalty =3D PIRQ_PENALTY_ISA_USED;
-	else
-		penalty =3D PIRQ_PENALTY_PCI_USING;
-
-	acpi_irq_add_penalty(irq, penalty);
+	if (irq >=3D 0)
+		acpi_irq_add_penalty(irq, active ?
+			PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
=20
 bool acpi_isa_irq_available(int irq)
