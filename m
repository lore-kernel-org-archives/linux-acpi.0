From: Thomas Kosch <t.kosch-7+EO1k1ndLmazgQtNeiOUg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Sun, 22 Sep 2002 10:32:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <microsoft-free.m34rci2zn6.fsf@grisu.cyvermail.de>
References: <E17rvjI-0001mI-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E17rvjI-0001mI-00-HKCwXBn57GynvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org> (acpi-devel-request@lists.sourceforge.net's
 message of "Thu, 19 Sep 2002 00:27:02 -0700")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> I wanted to make a special request for testing of the 2.4 patch (or
> should I say, MEGA-patch).

Here we are...
The computer is a Toschiba Satellite 300-214

> The main issues of importance are:
>
> - DOES IT BOOT?

Yes

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

It looks good

There are still some small errors. Sometimes I get an 'grisu kernel:
ACPI-0323: *** Error: Handler for [Embedded_control] returned AE_TIME'
and there is some trouble which the scsi hostadapter emulation. If i try
to mmount a cd-rom after an S1 sleep the computer freezes. I must reload
the ide-scsi module.

ttyl8er, t.k.

=2D-=20
Slowly and surely the unix crept up on the Nintendo user ...


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
