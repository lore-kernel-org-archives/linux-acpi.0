From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: High pitch noise produced when ACPI processor module loaded
Date: Sun, 5 Oct 2003 12:24:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031005102452.GA321@elf.ucw.cz>
References: <001001c38404_27b959a0_2001a8c0@silverstone> <20030926100512.X64952@root.org> <20031002111232.GC14859@openzaurus.ucw.cz> <000401c38b23$fddef730$2401a8c0@INSPIRON>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000401c38b23$fddef730$2401a8c0-laDPoAWcecs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sander Wichers <wichers-Jdbf3xiKgS8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > My inspiron 8600 (intel centrino/855PM) is producing a strange high
> pitch
> > > > sound which comes from within the machine (definitly not the speakers)
> when
> > > > the acpi processor module get's loaded. When I unload the processor
> module
> > > > the high pitch sound goes away.
> 
> > Try running while1 program, see if it helps.
> Yes!, when there is intensive processor activity the sound goes away.

This unfortunately seems fairly normal; at least all four notebooks I
had for testing produced some kind of cpu-related noise.

> > If so you might want to disable CX sleep states.
> What's the name of the directive? Or do I have to manually remove some
> portions of the code?

Manually remove... [And I'm not sure which portion, either ;-). Look
into acpi's idle loop.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
