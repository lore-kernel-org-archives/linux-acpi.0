From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ACPI-sppt] RE: [ACPI] Re: [Acpi4asus-user] ACPI with Kernel 2.6.0-test9 on Asus M2N
Date: Thu, 30 Oct 2003 11:49:09 +0800
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720B72@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, rmuehlhoff <rmuehlhoff-52dn/g0OV9M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Did you have APIC enabled ? If so, please try patch at =
http://bugme.osdl.org/show_bug.cgi?id=3D1269

--Luming

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Karol =
Kozimor
Sent: 2003?10?28? 1:04
To: rmuehlhoff
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; =
acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; acpi4asus-user@lists.sourceforge.net
Subject: [ACPI] Re: [Acpi4asus-user] ACPI with Kernel 2.6.0-test9 on =
Asus M2N


Thus wrote rmuehlhoff:
> I just updated from 2.4 to 2.6 kernel. I'm using the original sources =
wthout any patches.=20
> When compiling the kernel with ACPI support, it hangs on startup when =
initialising ACPI=20
> (hmm difficult to describe because I cant't give you a log for this =
happens so early, logging is not yt active).=20
>=20
> You know, when ACPI get initialised in the early startup phase, there =
are various moments where long lines of dots=20
> appear on the screen... In the third instance, the system hangs after =
a few dots.=20

A blind guess: try to reverse the patch [1] and recompile your kernel.
[1]
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.=
22/20031017152411-acpi_ec_gpe_query.patch

Best regards,

--=20
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
