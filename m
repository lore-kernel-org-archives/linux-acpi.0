From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: AW: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Fri, 13 Dec 2002 10:30:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F0D404A@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

That's a really bad idea! This size checks are identented to assure, =
that important data which accidently follows the buffer can't be =
overridden by brain dead bios coders. Now you allow buffer overflow =
injection into linux from the bios!
These are serious bios faults, in my DSDT I had to extend a buffer by =
128 bytes to avoid a buffer overflow!=20
The situation doesn't get better if we ignore such errors. We have to =
urge the manufacturers to correct the DSDT's. And the best way to do =
this is to recognise the faults and blame them.

Herbert.


> -----Urspr=FCngliche Nachricht-----
> Von: NoZizzing OrDripping [mailto:nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org]
> Gesendet: Freitag, 13. Dezember 2002 05:48
> An: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Betreff: [ACPI] [PATCH] Add CONFIG_ACPI_RELAXED_AML option
>=20
>=20
> The patch adds a new configuration option,
> CONFIG_ACPI_RELAXED_AML.  When turned on,
> the ACPI code will become forgiving of minor
> errors in the AML code.
>=20
> For this first cut, the patch and option will ignore
> region size errors.  An off-by-one error is often
> found in the AML shipped with Toshiba laptops,
> even new models. This minor error prevents the
> AC module from operating without this patch.
>=20
> I urge the adoption of this patch (or something
> similar) into the ACPI code.  This will make it
> much easier to install and proliferate Linux on
> a large category of laptops.
>=20
> Rick Richardson
> rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org
> [Sorry, have to use my Yahoo account to post to this list)
>=20
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
>=20


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
