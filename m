From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Sun, 29 Feb 2004 08:20:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040229072031.GA209@elf.ucw.cz>
References: <4038F499.2060302@verizon.net> <20040225182030.GG1214@elf.ucw.cz> <40410A69.3070800@verizon.net> <20040228220435.GD10530@elf.ucw.cz> <4041136B.9000904@verizon.net> <20040228230941.GA488@elf.ucw.cz> <1950.66.108.215.112.1078013994.squirrel@webmail.localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1950.66.108.215.112.1078013994.squirrel-2RFepEojUI20LjuDPgauC1aTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org
Cc: nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> >>I tried playing with suspend to disk in kernel 2.6.3. It was a no
> >> >>go. I  have highmem enabled on this machine which has 1 gig of RAM.
> >> >>Going to try pmdisk.
> >> >>
> >> >>
> >> >
> >> >Forget pmdisk, that will not work anyway. Try running without highmem
> >> >(at least for a test).
> >
> >> Should I also disable preemption?
> >
> > Yes.
> 
> WHY???

Why shouting and 3x"?"?

It should work with preemption, but preemptive kernel is slightly
harder than usual. If he wants to get it to work, it is best to
disable preemption.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
