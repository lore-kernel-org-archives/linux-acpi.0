From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/13] ACPI / PM: Rework power resources management
Date: Thu, 25 Nov 2010 21:45:19 +0100
Message-ID: <201011252145.19814.rjw@sisk.pl>
References: <AANLkTimahUpEL3cV6pFhkN8KqrphfVMSOw8xAN2=9jPy@mail.gmail.com> <201011252129.02027.rjw@sisk.pl> <AANLkTi=QH=SNyfZEaak6pYyCJchSwDp6sdn-yOSz2MRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=QH=SNyfZEaak6pYyCJchSwDp6sdn-yOSz2MRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 25, 2010, Sedat Dilek wrote:
> On Thu, Nov 25, 2010 at 9:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
> > On Thursday, November 25, 2010, Rafael J. Wysocki wrote:
> >> On Thursday, November 25, 2010, Sedat Dilek wrote:
> >> > On Thu, Nov 25, 2010 at 10:41 AM, Sedat Dilek
> >> > <sedat.dilek@googlemail.com> wrote:
> >> > > On Thu, Nov 25, 2010 at 10:11 AM, Sedat Dilek
> >> > > <sedat.dilek@googlemail.com> wrote:
> >> > >> Hi Rafael,
> >> > >>
> >> > [ ... ]
> >> > >> # grep "error:" build_linux-next_next20101124.dileks.2.log
> >> > >> /home/sd/src/linux-2.6/linux-2.6.37-rc3/debian/build/source_i=
386_none/drivers/platform/x86/fujitsu-laptop.c:692:
> >> > >> error: implicit declaration of function =E2=80=98acpi_bus_get=
_power=E2=80=99
> >> > [ ... ]
> >> > >
> >> > > Guess this is conflicting with your patch
> >> > > "12-13-ACPI-PM-Drop-acpi_bus_get_power.patch".
> >> > >
> >> > > - Sedat -
> >> > >
> >> > > P.S.: Note to myself, add the following snippet for testing pu=
rposes:
> >> > >
> >> > > [ debian/config/i386/none/config.686 ]
> >> > > ...
> >> > > ##
> >> > > ## file: drivers/platform/x86/Kconfig
> >> > > ##
> >> > > # CONFIG_FUJITSU_LAPTOP is not set
> >> > > - EOT -
> >> > >
> >> >
> >> > Applied on top of linux-next (next-20101125) and running.
> >> >
> >> >      Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> >>
> >> Great, thanks a lot!
> >>
> >> I should have said the patchset is on top of the current Linus' tr=
ee.
> >
> > Actually it also breaks with the current Linus' tree, but the appen=
ded patch
> > should fix it.
> >
> > Thanks,
> > Rafael
> >
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: Platform / x86: Make fujitsu_laptop use acpi_bus_update_po=
wer()
> >
> > Use the new function acpi_bus_update_power(), which is safer than
> > acpi_bus_get_power(), for getting device power state in
> > acpi_fujitsu_add().
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/platform/x86/fujitsu-laptop.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-2.6/drivers/platform/x86/fujitsu-laptop.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/platform/x86/fujitsu-laptop.c
> > +++ linux-2.6/drivers/platform/x86/fujitsu-laptop.c
> > @@ -689,7 +689,7 @@ static int acpi_fujitsu_add(struct acpi_
> >        if (error)
> >                goto err_free_input_dev;
> >
> > -       result =3D acpi_bus_get_power(fujitsu->acpi_handle, &state)=
;
> > +       result =3D acpi_bus_update_power(fujitsu->acpi_handle, &sta=
te);
> >        if (result) {
> >                printk(KERN_ERR "Error reading power state\n");
> >                goto err_unregister_input_dev;
> >
>=20
> Sorry, I crapped my own quotes.
> Missed to catch line #860?

Indeed, sorry.  Updated patch is appended.

Rafael


---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>
Subject: Platform / x86: Make fujitsu_laptop use acpi_bus_update_power(=
)

Use the new function acpi_bus_update_power(), which is safer than
acpi_bus_get_power(), for getting device power state in
acpi_fujitsu_add().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/platform/x86/fujitsu-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/platform/x86/fujitsu-laptop.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/platform/x86/fujitsu-laptop.c
+++ linux-2.6/drivers/platform/x86/fujitsu-laptop.c
@@ -689,7 +689,7 @@ static int acpi_fujitsu_add(struct acpi_
 	if (error)
 		goto err_free_input_dev;
=20
-	result =3D acpi_bus_get_power(fujitsu->acpi_handle, &state);
+	result =3D acpi_bus_update_power(fujitsu->acpi_handle, &state);
 	if (result) {
 		printk(KERN_ERR "Error reading power state\n");
 		goto err_unregister_input_dev;
@@ -857,7 +857,7 @@ static int acpi_fujitsu_hotkey_add(struc
 	if (error)
 		goto err_free_input_dev;
=20
-	result =3D acpi_bus_get_power(fujitsu_hotkey->acpi_handle, &state);
+	result =3D acpi_bus_update_power(fujitsu_hotkey->acpi_handle, &state)=
;
 	if (result) {
 		printk(KERN_ERR "Error reading power state\n");
 		goto err_unregister_input_dev;
