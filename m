From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: semaphore problems resulting in instability
Date: Thu, 1 Apr 2004 13:56:46 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05537F3B9@orsmsx403.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vladislav Yasevich <vladislav.yasevich-VXdhtT5mjnY@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

We recently changed the behavior of the _GL_ mutex to allow a different
thread to release it than the one that acquired it.

Try the latest version of the ACPI CA code.
Bob


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Vladislav
Yasevich
Sent: Thursday, April 01, 2004 12:49 PM
To: acpi-devel
Subject: [ACPI] semaphore problems resulting in instability

Hi All

I have a Compaq N620c laptop that works fairly well
with the exception of a very intersting problem that
shows up often, but inconsitently.

The system is currently running 2.6.3-mm4, but the
problem has been happingin on both 2.4 and 2.6 kernels
since the very beginning.

The problem is triggred the the battery applet in both
Gnome and KDE.  The applet tries to read the battery
info and status every second and after a while (and this
can be anywhere between 10 minutes to 14 hours) I get the
following in the log:

Mar 20 08:36:47 galen exmutex-0245: *** Error: Cannot release Mutex=20
[_GL_], not acquired
Mar 20 08:36:47 galen psparse-1120: *** Error: Method execution failed=20
[\_SB_.C046.C059.C0E6.C142] (Node c156ee28), AE_AML_MUTEX_NOT_ACQUIRED
Mar 20 08:36:47 galen psparse-1120: *** Error: Method execution failed=20
[\_SB_.C046.C059.C0E6.C155] (Node c156dea8), AE_AML_MUTEX_NOT_ACQUIRED
Mar 20 08:36:47 galen psparse-1120: *** Error: Method execution failed=20
[\_SB_.C046.C059.C0E6.C15B] (Node c156db28), AE_AML_MUTEX_NOT_ACQUIRED
Mar 20 08:36:47 galen psparse-1120: *** Error: Method execution failed=20
[\_SB_.C046.C059.C0E6.C162] (Node c156d828), AE_AML_MUTEX_NOT_ACQUIRED
Mar 20 08:36:47 galen psparse-1120: *** Error: Method execution failed=20
[\_SB_.C162] (Node c15651a8), AE_AML_MUTEX_NOT_ACQUIRED
Mar 20 08:36:47 galen psparse-1120: *** Error: Method execution failed=20
[\_SB_.C1B3._BST] (Node c15649a8), AE_AML_MUTEX_NOT_ACQUIRED
Mar 20 08:36:47 galen acpi_battery-0207 [42] acpi_battery_get_statu:=20
Error evaluating _BST
Mar 20 08:36:57 galen osl-0898 [53] os_wait_semaphore     : Failed to=20
acquire semaphore[dffce5c0|1|0], AE_TIME

After this, the applet hangs.  Attempting to get the information
by hand also hangs the input (xterm or kterm).  The system load
starts climing linearly and after about 4 minutes the load goes from
about 0.8 to 15.

You can view the DSDT here:
http://acpi.sourceforge.net/dsdt/tables/Compaq/Evo_N620c/Compaq-Evo_N620
c-F.0A-custom.asl.gz

I saw the posts about bad semaphor waits before, but all my semaphores
are acuired with 0xFFFF (no timeout).  I still applied the patch and it
didn't help as I suspected.

What's interesting is that the \_SB_.C162 method is Serialized, so there
really shouldn't be any kind of preemption.

I've tried enabling semephore debugging, but then the read from battery
status fails and the problem is not reproducable.

So, after all that, I've hit a wall and would appreciate any help.
I would be more then happing to provide any additional information.

Thanks
-- vlad
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Vladislav Yasevich		Linux and Open Source Lab
Hewlett Packard 		Tel: (603) 884-1079
Nashua, NH 03062		ZKO3-3/T07


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
