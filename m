From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix for 2.4.21-pre2 and acpi-20021212
Date: Fri, 3 Jan 2003 11:58:44 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F23@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
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
To: joergprante-UIqTAjE4tzc5WgrkcBd8vg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: J=F6rg Prante [mailto:joergprante-UIqTAjE4tzc5WgrkcBd8vg@public.gmane.org]=20
> this patch is needed for acpi-20021212 with 2.4.21-pre2 on a=20
> Pentium 4 with=20
> ACPI IO-APIC. The dynamic MP busses and IRQ_SOURCES in=20
> 2.4.21-pre2 introduced=20
> a conflict that will rise NULL pointer dereferences when=20
> combined with the=20
> ACPI patch. I don't have the hardware to test it, but Margit=20
> Schubert-While=20
> reported a successful boot.
>=20
> http://infolinux.de/jp/087_acpi-mpparse-fix

Excellent! Thanks, applied.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
