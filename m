From: Martin van Es <mrvanes-jG/AHqQBv7lBDgjK7y7TUQ@public.gmane.org>
Subject: performance mgt and sleep don't work on Acer TM621
Date: Mon, 13 Jan 2003 14:16:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301131416.14923.mrvanes@bigfoot.com>
Reply-To: mrvanes-jG/AHqQBv7lBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
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


 I posted this question to 'support' a while ago, but didn't get much
 feedback. Hope acpi-devel list readers know something more to help me ou=
t.
=20
 ----------------8<---------------
 Hi,

 I've been using ACPI patches to my 2.4.20 kernel for a while since it's
 the only way to get my laptop's IRQ table in order during boot. So far
 so happy!
 (LT: Acer TM 621)
=20
 Recently I started experimenting with the 'write' interface and tried to
 get the performance of my coppermine PIII 1G to switch from 1G to 733MHz
 or vise versa using
 echo -n 1 > /proc/acpi/CPU0/performance
=20
 But both 'cat'ing performance to see what happened and running bogomips
 show my processor is still running @ 1GHz. It is also the other way roun=
d.
 Once booted at 733MHz (because of absence of AC adapter) it cannot be fo=
rced
 into 1G, even with AC attached.
=20
 Info tells me performance management is available:
 cat /proc/acpi/processor/CPU0/info:
 processor id:            0
 acpi id:                 1
 bus mastering control:   yes
 power management:        yes
 throttling control:      no
 performance management:  yes
 limit interface:         yes
=20
 cat /proc/acpi/processor/CPU0/performance:
 state count:             2
 active state:            P0
 states:
    *P0:                  1000 MHz, 20000 mW, 500 uS
     P1:                  733 MHz, 10000 mW, 500 uS
=20
 Am I doing something wrong? Forgot to compile in something?
=20
 Further I echoed 1 to  /proc/acpi/sleep. My laptop perfectly blanked the
 screen, but was unwakeable after. The screen comes back, but no reaction
 to the keyboard in any way. Again:
 Am I doing something wrong?
=20
 If there's anything I can do to help/test please let me know.
=20
 Martin van Es


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
