From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Mon, 29 Mar 2004 07:22:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040329052238.GD1276@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1080535754.16221.188.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,

On Sun, Mar 28, 2004 at 11:49:15PM -0500, Len Brown wrote:
 
> ACPI unconditionally used cmpxchg before this change also -- from asm().
> The asm() was broken, so we replaced it with C,
> which invokes the cmpxchg macro, which isn't defined for
> an 80386 build.
> 
> I guess it is a build bug that the assembler allowed us
> to invoke cmpxchg in an asm() for an 80386 build in earlier releases.
> 
> I'm open to suggestions on the right way to fix this.
> 
> 1. recommend CONFIG_ACPI=n for 80386 build.
> 
> 2. force CONFIG_ACPI=n for 80386 build.
> 
> 3. invoke cmpxchg from acpi even for 80386 build.
> 
> 4. re-implement locks for the 80386 case.

I like this one, but a simpler way : don't support SMP in this case, so that
we won't have to play with locks. This would lead to something like this :

#ifndef CONFIG_X86_CMPXCHG
#ifndef CONFIG_SMP
#define cmpxchg(lock,old,new) ((*lock == old) ? ((*lock = new), old) : (*lock))
#else
#define cmpxchg(lock,old,new) This_System_Is_Not_Supported
#endif
#endif

This code (if valid) might be added to asm-i386/system.h so that we don't
touch ACPI code.

Any comments ?

Willy



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
