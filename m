From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Various Lockups with IBM T30
Date: Wed, 9 Oct 2002 17:43:05 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF1D@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: 'Ti Leggett' <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Ti Leggett [mailto:leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org] 

> Are my messages getting through to the list? Does anyone have *any*
> suggestions for this? Has anyone had similar experience? Does anyone
> have anything I should try? Does anyone think I'm crazy?

I am trying linux-2.5-bk-latest on a T30 I borrowed, and I am not seeing an
oops after the power resource, but I am seeing it...kinda hang..., after the
xxxK memory freed. Weird.

Let me investigate some more.

-- Andy

> 
> 
> On Fri, 2002-10-04 at 12:20, Ti Leggett wrote:
> > I forgot to mention that passing "pci=noacpi" has no effect on the
> > outcome.
> > 
> > On Fri, 2002-10-04 at 11:51, Ti Leggett wrote:
> > > I'm still trying to get my IBM T30 to even boot with ACPI 
> enabled. I've
> > > managed to output my console over serial so I can capture 
> the output and
> > > here's what happens.
> > > 
> > > 2.4.20-pre8 (with 20021002 patch):
> > >   - hangs trying to initialize NET4
> > > 2.4.20-pre8-ac3 (no acpi patch applied)
> > >   - Oopses at some point during init but spews out a bunch of ACPI
> > > errors before
> > > 2.5.40 (with 20021002 patch):
> > >   - Oopses right after ACPI Power Resource
> > > 
> > > I'm attaching the ouputs of each of these logs. I've also 
> managed to
> > > dump my DSDT so if that's needed (because I really don't 
> know what to do
> > > with it) I'll send it as well.
> > > 
> > > -- 
> > > Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
> > -- 
> > Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
> > 
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> -- 
> Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
