From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: need debugging help
Date: Sun, 13 Jul 2003 17:04:33 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E97021@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chander Kant <ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, sorry for the delay.

So do you have the ability to change your systems' BIOS? If so it is an
easy fix. If not, then there is a Relaced AML patch to workaround this
issue, but the ideal situation would be to fix the firmware.

Regards -- Andy

> -----Original Message-----
> From: Chander Kant [mailto:ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org]=20
> Sent: Tuesday, July 01, 2003 5:13 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Grover, Andrew; ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org
> Subject: need debugging help
>=20
>=20
>=20
> Thanks Andrew. I am moving the discussion to the acpi-devel list:
>=20
> All,
>=20
> I am attaching the output of "iasl -d dsdt" (in zipped format).
>=20
> Please let me know if we can do anything on this system to=20
> get rid of the problem mentioned below.
>=20
> Thanks,
> Chander
>=20
>=20
> "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote ..
> > > When we bring up a recent Linux kernel (2.4.20) with ACPI=20
> > > patch on our laptop. We get following error messages=20
> > > continously from the kernel:
> > >=20
> > > Jul  2 04:31:16 localhost kernel:     ACPI-1103: *** Error:=20
> > > Method execution failed [\_SB_.PCI0.SBRG.EC0_._Q1E] (Node=20
> > > c33b1380), AE_AML_REGION_LIMIT
> > >=20
> > > Besides filling up the log files, and making the console=20
> > > windows, I think it is also hampering ACPI functionality to=20
> > > work, as I do not see and battery file in the /proc/acpi=20
> directory.
> > >=20
> > > I have seen other folks in user groups and lists getting=20
> > > these errors, but so far I have not seen a good response as=20
> > > far as a fix or workaround.
> >=20
> > It's most likely an AML error. This particular error is not=20
> uncommon.
> >=20
> > Do you have the ASL for this machine? If not, get iasl from
> >=20
> http://developer.intel.com/technology/iapc/acp> i/downloads.htm and
feed
> > your DSDT into it (from /proc/acpi/dsdt). with the -d=20
> option. Then, go
> > take a look at the _Q1E method.
> >=20
> >=20
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
