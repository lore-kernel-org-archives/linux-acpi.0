From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: VIA KT333 acpi DSDT bug
Date: Tue, 3 Feb 2004 15:24:56 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB66C@PDSMSX403.ccr.corp.intel.com>
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
To: chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I use a VIA KT333 motherboard.
>=20
> It hase some bugs in the DSDT file and I don't know how to fix them.
> Once when I had xp installed on it (2 days long ;) I had S0=20
> t/m S5 (Ofcourse=20
> not called that way by M$cro)
> No ACPI (sleep) say I only have S0 S3 S4 S5
> Some time none of them work becuase "one process didn't stop"=20
> But now it "at=20
> least I can "use S3", all that it does is putting my computer=20
> in 1/10000 sec=20
> to sleep (S3) mode and can be re-awakend. The lid switch=20
> doesn't do any=20
> thing.

Do you have any hints to let us know this kind of symptom is due
to DSDT bug?=20

>=20
> Maybe there is already a DSDT patch, but for some reason the=20
> pathes are=20
> ordened by computer brands and not by chip-set brand, still I=20
> have looked=20
> there but as far as I know there isn't a VIA / VIA KT333 DSDT file.
>=20
> I have tried to fix the bugs, even read a howto (+ some=20
> howto's it pointed to)=20
> and couldn't find a solution to my problem
>=20
> So I hope that some one can fix my DSDT file

Don't presume DSDT is the only buggy places.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
