From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: False thermall shutdown (seems like 2.6 ACPI bug)
Date: Tue, 27 Apr 2004 22:39:06 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F840423FAC3@PDSMSX403.ccr.corp.intel.com>
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
To: "Rus V. Brushkoff" <rus-YPKzlcOx6JWP+XVi2HspGA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20

>	Hi.
>
> I'm trying to boot 2.6.5 at ASUS L3H laptop but got shutdown=20
>just after
>starting init, this is part of the dmesg :
>

This is a known issue, there is a sane check needed .

>..........
>
>exoparg2-0432 [50] ex_opcode_2A_1T_1R    : Index value=20
>(FFFFFFFF) beyond
>package end (7)
> psparse-1133: *** Error: Method execution failed [\_TZ_.RSCM] (Node
>c17ad1a8),
>AE_AML_PACKAGE_LIMIT

Hmmm, I need to verify your ASL code to verify it is not AML interpreter
fault.

> psparse-1133: *** Error: Method execution failed=20
>[\_TZ_.TZ__._SCP] (Node
>c17af128), AE_AML_PACKAGE_LIMIT
>acpi_thermal-0464 [42] acpi_thermal_critical : Critical trip point
>Critical temperature reached (255 C), shutting down.

255C is a unreasonable  value. Need sane check here.

>ACPI: Thermal Zone [TZ] (255 C)
>Asus Laptop ACPI Extras version 0.27
>  L3H model detected, supported
>..........
>
>
> The 2.4.X working ok on this machine. If somebody interested=20
>I can send
>any debug info or test new patches/ideas.

Did you found similar AE_AML_PACKAGE_LIMIT in 2.4?

Thanks,
Luming


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
