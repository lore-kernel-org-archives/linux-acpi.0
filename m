From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: High pitch noise produced when ACPI processor module
 loaded
Date: Mon, 6 Oct 2003 09:41:19 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031006093904.K3158@root.org>
References: <001001c38404_27b959a0_2001a8c0@silverstone> <20030926100512.X64952@root.org>
 <20031002111232.GC14859@openzaurus.ucw.cz> <000401c38b23$fddef730$2401a8c0@INSPIRON>
 <20031005102452.GA321@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031005102452.GA321-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Sun, 5 Oct 2003, Pavel Machek wrote:
> > > > > My inspiron 8600 (intel centrino/855PM) is producing a strange high
> > pitch
> > > > > sound which comes from within the machine (definitly not the speakers)
> > when
> > > > > the acpi processor module get's loaded. When I unload the processor
> > module
> > > > > the high pitch sound goes away.
> >
> > > Try running while1 program, see if it helps.
> > Yes!, when there is intensive processor activity the sound goes away.
>
> This unfortunately seems fairly normal; at least all four notebooks I
> had for testing produced some kind of cpu-related noise.

It's a *feature*.  I've implemented a Cx driver for FreeBSD and it's
useful to be able to tell if the code really is entering the desired state
by holding the laptop up to my ear.  I can differentiate all the Cx states
but not in the Px states.  :)

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
