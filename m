From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi on r40e
Date: Mon, 16 Feb 2004 18:25:28 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB6C4@PDSMSX403.ccr.corp.intel.com>
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
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Praveen C <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > On Thu, 12 Feb 2004, [iso-8859-1] Praveen C wrote:
> > > I removed all HKEY related stuff and assembled dsdt.dsl=20
> using iasl.
> > > Then I used the DSDT initrd patch together with the new=20
> > DSDT table. I
> > > STILL cant get the volume and brightness buttons to work.
> > > praveen
> >=20
> > Apparently you didn't read my reply to you.  If you want the=20
> > buttons, use
> > APM and disable ACPI.
> >=20
>=20
> From hardware point of view, User interface can trigger SMI#=20
> and SCI# ,
> So, maybe it's possible that Hot key feature handled by SMM code
> can work with ACPI. I'm not sure, it is just my imagination.
>=20
> --Luming

  I just want to add my experience on T21 for hot key issue .
The hot key FN+Home (End) is for brightness control on T21.=20
It do work with ACPI without any Linux ACPI code, which is expected=20
to support hot key feature.
  To identify the problem you may have, could you send out
/proc/interrupts
befroe and after pressing hot-key. I want to see whether this is=20
interrupt or event releated problem.
  I suspect something is wrong with triggering SMI# or SCI#  on r40e.

(Full boot log is appreciated!)

--Luming


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
