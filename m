From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Gateway 200x - trouble supplying ECDT table
Date: Thu, 25 Dec 2003 12:08:41 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C59@PDSMSX403.ccr.corp.intel.com>
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
To: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>I am sorry that you will receive this twice.
>I did not send my original reply back to the mailinglist.
>

Never mind!

>  I applied this patch to my 2.4.23 kernel=20
>(started back from the fresh sources and applied the latest ACPI patch
first)

After a few investigation on your problem, that patch doesn't apply.
>From your DSDT,=20
ECDT seems to be  unnecessary to your box.

>Unfortunately, I'm still getting the same sorts of >>messages on boot.=20
>The _REG method of the Embedded Control fails as follows:

Obviously, this issue is relative to acpi_ec_space_handler.
=20
>ACPI: Embedded Controller [H_EC] (gpe 28)
>evregion-0348: *** Error: Handler for [EmbeddedControl] returned
AE_BAD_PARAMETER
> dswexec-0435 [30] ds_exec_end_op        : [Store]: Could not resolve
operands, AE_BAD_PARAMETER
> psparse-1120: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.H_EC._REG] (Node df5e7ae8), AE_BAD_PARAMETER

I just filed a patch for you testing, just try it.
http://bugzilla.kernel.org/show_bug.cgi?id=3D1744

Maybe we need to support other access bit width.  I found AccessType:
DWordAcc in your EC region definition.

Thanks,
Luming



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
