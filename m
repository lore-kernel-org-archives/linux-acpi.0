From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: eisa_set_level_irq(acpi_fadt.sci_int)
Date: 23 Oct 2003 23:13:26 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1066965206.3864.55.camel@dhcppc4>
References: <1066254483.2535.51.camel@dhcppc4>
	 <20031017154107.GI8668@poupinou.org>  <1066411716.2527.100.camel@dhcppc4>
	 <1066796711.2593.30.camel@dhcppc4>
	 <1066964092.1541.16.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1066964092.1541.16.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Actually that change in -pre8 was a no-op -- we still force the PIC
SCI from Edge to Level, just that now we print a message when we do so.

I expect the regression related to your lid switch is cased
by something else.  But since you have a box with an Edge Triggered
SCI, I'd be interested if you are able to receive ACPI interrupts
if we leave the SCI in Edge Triggered mode:

=3D=3D=3D=3D=3D arch/i386/kernel/acpi.c 1.14 vs edited =3D=3D=3D=3D=3D
--- 1.14/arch/i386/kernel/acpi.c        Mon Oct 20 18:08:05 2003
+++ edited/arch/i386/kernel/acpi.c      Thu Oct 23 23:09:05 2003
@@ -492,6 +492,8 @@
        if (!(val & mask)) {
                printk(KERN_WARNING PREFIX "IRQ %d was Edge Triggered, "
                        "setting to Level Triggerd\n", irq);
+               printk(KERN_WARNING PREFIX "NOT!\n");
+               return;
                outb(val | mask, port);
        }
 }

If you get a chance to try it, please send the /proc/interrupts
from before & after.

thanks,
-Len


On Thu, 2003-10-23 at 22:54, S=E9rgio Monteiro Basto wrote:
> Hi
> Seems that patch has been applied into kernel-2.4.23-pre8 and hangs my
> laptop when lid button is pressed.
> Here is dmesg file.
> where you can see ACPI: IRQ 10 was Edge Triggered, setting to Level
> Triggerd
> Notes:=20
> With pre7 all works fine.
> I have APIC disable.
> Other buttons like sleep, power have the normal beaver=20
> if I can help testing something else tell me.
>=20
> thanks
>=20
> On Wed, 2003-10-22 at 05:25, Len Brown wrote:
> > Ducrot,
> > I've found at least 1 system where hardcoding the PIC SCI to
> > Level-Triggered fails, while leaving it as Edge Triggered succeeds.
> >=20
> > The Intel SE7505VB2 "Vero Beach" when booted with "noapic" leaves IRQ=
9
> > as edge triggered.
> >=20
> > When we force it to level triggered, we get no ACPI events.
> > If we leave it as edge triggered, we do get ACPI events.
> >=20
> > The other systems in my office leave the PIC SCI in Level Triggered
> > mode, so Linux need do nothing to the trigger.
> >=20
> > Today's patch prints a warning when the mode changes:
> >=20
> >                 printk(KERN_WARNING PREFIX "IRQ %d was Edge Triggered=
, "
> >                         "setting to Level Triggerd\n", irq);
> >=20
> > But I'm thinking that by default we should _not_ change the trigger.
> > Instead we should do so only upon, say acpi=3Dsci_level_trigger or so=
me
> > such.  If there is a popular model that leaves SCI as edge and requir=
es
> > level to work, then we can use DMI to set this param for it.
> >=20
> > thanks,
> > -Len
> >=20
> > On Fri, 2003-10-17 at 13:28, Len Brown wrote:
> > > On Fri, 2003-10-17 at 11:41, Ducrot Bruno wrote:
> > > > On Wed, Oct 15, 2003 at 05:48:04PM -0400, Len Brown wrote:
> > > > > What does eisa_set_level_irq() do for us?
> > > > >=20
> > > > > As its presence breaks the !CONFIG_PCI build, I deleted it and =
found
> > > > > that ACPI in PIC mode seems to work just fine without it (at le=
ast on 2
> > > > > of 2 systems tested so far)
> > > > >=20
> > > >=20
> > > > This ensure SCI interrupt is correctly initialized for (poorly) w=
ritten
> > > > BIOS.  Without it, this break one of my laptop, and certainly oth=
ers as well.
> > >=20
> > > Do ACPI interrupt work on this latop?  What happens on that system =
if
> > > you delete the call to eisa_set_level_irq()?
> > >=20
> > > If we blindly program the PIC to be level senstive when the hardwar=
e is
> > > designed to be edge triggered, then we'll probably get no ACPI even=
ts on
> > > those systems, as the pulse may not be asserted long enough to prov=
oke
> > > an interrupt.
> > >=20
> > > We used to blindly program the APIC assuming the SCI was ACPI compl=
iant,
> > > but we got burnt when we discovered that a significant set of syste=
m do
> > > _not_ have a level-triggered active-low SCI.  Most of those specifi=
ed
> > > their deviation with an SCI-over-ride in the MADT, but some did not=
:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D774
> > >=20
> > > The APIC solution was to
> > > 1. don't hard-code level-triggered active-low
> > > 2. do whatever the SCI over-ride says
> > > 3. if no SCI over-ride, leave the interrupt trigger/polarity as the=
 BIOS
> > > programmed it.
> > >=20
> > > thanks,
> > > -Len
> > >=20
> > > ps. this routine is mis-named, it it not EISA specific.  Further, i=
t is
> > > mis-located in a PCI-specific file but is not PCI specific.  It sho=
uld
> > > be in an X86 specific interrupt file and be named pic_something.  I=
'm
> > > thinking I'll clone it into our x86 acpi code and add a warning whe=
n we
> > > find that it actually _changes_ the polarity.



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
