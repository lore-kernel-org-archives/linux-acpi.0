From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 07:59:07 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302130659.h1D6x7D22714@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: yFMvS/UpVItkI7/U3OfMtA==
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mochel-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I would recommend never, ever doing 'echo 5 > /proc/acpi/sleep',=20
> especially if you're trying to suspend the system.=20

It's not worse than pushing the power button on a normal system
(or hold the power button on an ACPI system).

> ACPI should not allow a user to write '5' to that file. It used to be tha=
t=20
> way, but someone clever decided that that interface should support _all_=
=20
> sleep states. (It might have been me, in one of my finer moments).=20

The regular user can't write anything to that file - this must be
root. He's supposed to know what he's doing. If he wants to turn the
machine off without halting the system, then that's his choice. Think
of something like an embedded system to control a machine. Many=20
machines have an emergency off whith a huge red button. This is the
software version of this red button. Your software can press this
if you thing that's necessary.

> Andy, I recommend removing that from 2.4, and I'll send you a patch for=
=20
> 2.5..

I'd like to have it in. I don't know what I could ever use it for,
but I'd really prefer to have this possibility.


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
