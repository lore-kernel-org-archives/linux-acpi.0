From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Battery error with toshiba 2435
Date: Mon, 15 Dec 2003 18:07:10 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C29@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: adelorbeau-GANU6spQydw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>FYI: Using acpi-20031203 without the patch from Yu, Luming create the 2 =

>following problems:
>   A) cat /proc/acpi/battery/BAT1/state
>	present:                 yes
>	ERROR: Unable to read battery status
>   B) dmesg report a *lot* of messages like:
>    ACPI-0279: *** Error: Looking up [PBST] in namespace, =
AE_ALREADY_EXISTS
>    ACPI-1120: *** Error: Method execution failed =
[\_SB_.PCI0.LPC0.BAT1._BST]=20
> (Node c15bd200), AE_ALREADY_EXISTS

To verify it, I want to see dmesg.


>### What is wrong: ### (With both 2.6 up to date and 2.4 with older =
acpi)
>Command "acpi -ab" output:
>     Battery 1: discharging, 98%, charging at zero rate - will never =
fully=20
>charge.
>  AC Adapter 1: off-line

>"cat /proc/acpi/battery/BAT1/state"
>present:                 yes
>capacity state:          ok
>charging state:          discharging
>present rate:            0 mA		***** BAD Value *****
>remaining capacity:      3920 mAh
>present voltage:         16223 mV

Could we follow up this issue on =
http://bugzilla.kernel.org/show_bug.cgi?id=3D1618

PS. I want to see full dmesg rather than small snippets. =20

Thanks
Luming


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
