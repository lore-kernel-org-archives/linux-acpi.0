From: "Ryan May" <rmay-GrrYUJ3DTa8@public.gmane.org>
Subject: CPU Performance Management
Date: Tue, 1 Apr 2003 21:33:57 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <00a201c2f8c8$b2019130$89106144@cyclone>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009F_01C2F896.672D2570"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_009F_01C2F896.672D2570
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Toshiba 2415-s205 with a P4M-2.0GHz and have recently been =
toying with ACPI support in the linux kernel.  So far, I have gotten two =
versions running: The 2.5.66 kernel with the 20030328 ACPI patch and the =
2.4.20 kernel with the 20021222 ACPI patch.  Neither of the kernels have =
any other patches applied.

I am happy to see that (with a quick look) many features work well, =
except for an issue with the 20030328 patch.  When I cat =
/proc/acpi/processor/CPU0/info I get the following output:

processor id:                      0
acpi id:                              1
bus mastering control:        yes
power management:           yes
throttling control:                no
performance management:  no
limit interface:                    no

Knowing that I have a P4M, I would have expected to have the option of =
performance management.  Indeed, on the 20021212 patch on a 2.4.20 =
kernel, I have both performance management and limit interface enabled.  =
Anyone have any clue what changed to actually disable performance =
management?

I've tried disassembling and recompiling my DSDT (using iasl 20030228);  =
It gives me three identical warnings:

Package (0x00) {},
                    ^ Effective AML package length is zero

Could this be my problem?

Any help would be greatly appreciated.

Ryan May

------=_NextPart_000_009F_01C2F896.672D2570
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1141" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a Toshiba 2415-s205 with a =
P4M-2.0GHz and=20
have recently been toying with ACPI support in the linux kernel.&nbsp; =
So far, I=20
have gotten two versions running: The 2.5.66 kernel with the 20030328 =
ACPI patch=20
and the 2.4.20 kernel with the 20021222 ACPI patch.&nbsp; Neither of the =
kernels=20
have any other patches applied.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am happy to see that&nbsp;(with a =
quick look)=20
many features work well, except for&nbsp;an issue with the&nbsp;20030328 =

patch.&nbsp; When I cat /proc/acpi/processor/CPU0/info I get the =
following=20
output:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>processor=20
id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</FONT></D=
IV>
<DIV><FONT face=3DArial size=3D2>acpi=20
id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bus mastering =
control:&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; yes</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>power=20
management:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;yes</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>throttling control:&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; no</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>performance management:&nbsp; =
no</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>limit interface:&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;=20
no</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Knowing that I have a P4M, I would have =
expected to=20
have the option of performance management.&nbsp; Indeed, on the 20021212 =
patch=20
on a 2.4.20 kernel, I have both performance management and limit=20
interface&nbsp;enabled.&nbsp; Anyone have any clue what changed to =
actually=20
disable performance management?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I've tried disassembling and =
recompiling my DSDT=20
(using iasl 20030228);&nbsp; It gives me three identical =
warnings:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Package (0x00)&nbsp;{},</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
^ Effective AML package length is zero</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Could this be my problem?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any help would be greatly =
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Ryan May</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_009F_01C2F896.672D2570--




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
