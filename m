From: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Mon, 29 Mar 2004 11:56:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403291156.38961.arekm@pld-linux.org>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <20040329052238.GD1276@alpha.home.local> <200403290901.47695.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403290901.47695.vda-so6tiL4DrmS23Ynj82S0jdyBExgiH1vWcG62WxB9dV4@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Denis Vlasenko <vda-so6tiL4DrmS23Ynj82S0jdyBExgiH1vWcG62WxB9dV4@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dnia Monday 29 of March 2004 09:01, Denis Vlasenko napisa=B3:

> > > 4. re-implement locks for the 80386 case.
> >
> > I like this one, but a simpler way : don't support SMP in this case, so
> > that we won't have to play with locks. This would lead to something like
> > this :
>
> Yes, SMP makes sense only on 486+
I want to run i386 compiled kernel on 486+ smp machines

> > #ifndef CONFIG_X86_CMPXCHG
> > #ifndef CONFIG_SMP
> > #define cmpxchg(lock,old,new) ((*lock =3D=3D old) ? ((*lock =3D new), o=
ld) :
> > (*lock)) #else
> > #define cmpxchg(lock,old,new) This_System_Is_Not_Supported
> > #endif
> > #endif
and this won't allow me to do that

> > This code (if valid) might be added to asm-i386/system.h so that we don=
't
> > touch ACPI code.
> >
> > Any comments ?
so I preffer 3. invoke cmpxchg from acpi even for 80386 build + cpuid/other=
=20
check to not run this code on 386.

=2D-=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
