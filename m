From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Gericom Hummer 2430 problems
Date: Wed, 14 Jan 2004 09:31:59 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CC7@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andy Beals <Andy_Beals-wAC0BGzJtFZBDgjK7y7TUQ@public.gmane.org>, Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Tue, 2004-01-13 at 10:06, Sebastien B wrote:
> > > I've recently noticed that this bug only happens while KDE is=20
> > > running. It's quite weird... and it is not only because=20
> of KDE : it=20
> > > locks up the whole system ; if I'm listening to music=20
> when the bug=20
> > > happens, there are interrupts in the song... I had the=20
> same problem=20
> > > with Linux 2.4.23 but without any message in the dmesg output.
> >=20
> > It happens because of the aKpi (battery monitor) applet is=20
> loaded on=20
> > login. It's is not because of aKpi itself, I can trigger the same=20
> > problem with the Gnome battery monitor applet. So this is=20
> definitely=20
> > ACPI related...
>=20
> I'd second that.  I'm seeing it with Sun JDS.  Easy=20
> reproduce-by: enable
> the gnome battery applet, leave system on overnight.  Results in a
> locked system the next day.  Disable battery applet, no=20
> locked system.=20
> I'm sure it's a corner-case hiding in the driver - just=20
> haven't had the
> time to go after it and thought that it might have been quashed in
> modern versions of the ACPI support.
>=20

The symptom seems to indicate there are some bugs triggered by=20
the battery monitor applet. We need to figure out what is the applet
doing , then we can deeply look into ACPI code.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
