From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Problem - 2.6.0 Kernel and irq 18: nobody cared!
Date: Sun, 18 Jan 2004 11:34:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CE4@PDSMSX403.ccr.corp.intel.com>
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
To: jan-christian-Uv4yylcIJW+ELgA04lAiVw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> The "Asus P4P800 Deluxe" mainboard has on Option "Enhanced=20
> Mode Support
> On" which can be set for P-ATA devices S-ATA devices or both. This
> option is for legacy OSes like MS-DOS/Win98/Me/NT4.0 on which=20
> the ICH5R
> supports only 4 devices and not 6 (4 P-ATA devices + 2 S-ATA devices).
>=20
> When the option is set to both, I get those error messages on booting
> Linux 2.4/2.6 but no error messages when booting WinXP.
>=20

I'm really interested in this option that caused irq 18 : nobody cared!=20

> When I set it to S-ATA (I don't have S-ATA devices) than everything
> works great with 2.6.
>=20
> If it'll be interesting for you to get 2.6 still working with=20
> the other
> option, I could send you more log's.
>=20

Thanks for you help, please send me with boot log as well as disassembly
file of
/proc/acpi/dsdt. I need to check AML methods involved in this issue.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
