From: Nate Grey <nate-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Subject: Acer Aspire 1601LC tempertature & ACPI
Date: Fri, 2 Apr 2004 16:53:59 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404021654.00101.nate@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
this is my first post, I'm sorry for my English (I'm Italian).

Well, my laptop during compilations that take long times shutdown with a=20
kernel message that say "Critical Temperature 86 =B0C" or poweroff whitout=
=20
messages.
I use Gentoo distribution (but the problem happened firstly on FreeBSD, thi=
s=20
the reason I switch on Linux).

I got two questions:

1) Is this problem due to ACPI? (My friend Google lead me here)
2) What can I do?

I paste some system information:

CPU =3D model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
Linux 2.6.4 (ACPI patch)
=2D--------------------------------------
[/proc/acpi][root-hr27OG2WxIw@public.gmane.org] # cat info
version:                 20040311
=2D--------------------------------------
[/proc/acpi/thermal_zone/THRS]
[root-hr27OG2WxIw@public.gmane.org] # cat *
<not supported>
<polling disabled>
state:                   ok
temperature:             52 C
critical (S5):           85 C
=2D--------------------------------------
[/proc/acpi/processor/CPU0]
[root-hr27OG2WxIw@public.gmane.org] # ls
info  limit  power  throttling
[/proc/acpi/processor/CPU0]
[root-hr27OG2WxIw@public.gmane.org] # cat *
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no
<not supported>
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000]=20
usage[00459840]
   *C2:                  promotion[--] demotion[C1] latency[099]=20
usage[04028062]
    C3:                  <not supported>
<not supported>
=2D---------------------------------------


Probably you need more infos, just ask. It's very important, sometimes I=20
cannot see a DVD because system goes down... :=B0(  Ah, last info, this pro=
blem=20
doesn't not appear on WinXP (when it was installed).

Thanks in advance. Bye Bye


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
