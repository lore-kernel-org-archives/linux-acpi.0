From: "Sander Wichers" <wichers-Jdbf3xiKgS8@public.gmane.org>
Subject: Re: High pitch noise produced when ACPI processor module loaded
Date: Sun, 5 Oct 2003 11:35:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000401c38b23$fddef730$2401a8c0@INSPIRON>
References: <001001c38404_27b959a0_2001a8c0@silverstone> <20030926100512.X64952@root.org> <20031002111232.GC14859@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel, thanks for your reply!

> > > My inspiron 8600 (intel centrino/855PM) is producing a strange high
pitch
> > > sound which comes from within the machine (definitly not the speakers)
when
> > > the acpi processor module get's loaded. When I unload the processor
module
> > > the high pitch sound goes away.

> Try running while1 program, see if it helps.
Yes!, when there is intensive processor activity the sound goes away.

> If so you might want to disable CX sleep states.
What's the name of the directive? Or do I have to manually remove some
portions of the code?

thanks,

--Sander



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
