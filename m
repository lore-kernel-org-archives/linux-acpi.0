From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: 28 Mar 2004 23:49:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080535754.16221.188.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6939-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-03-28 at 10:24, Arkadiusz Miskiewicz wrote:

> ACPI uses cmpxchg so it's not possible to build it for i386 it seems.
>
> +__acpi_release_global_lock (unsigned int *lock)
> +{
> +       unsigned int old, new, val;
> +       do {
> +               old = *lock;
> +               new = old & ~0x3;
> +               val = cmpxchg(lock, old, new);
> +       } while (unlikely (val != old));
> +       return old & 0x1;
> +}
> 

> -o vmlinux
> drivers/acpi/acpi.o(.text+0x4cf4): In function
> `acpi_ev_global_lock_handler':
> : undefined reference to `cmpxchg'
> drivers/acpi/acpi.o(.text+0x4dc6): In function
> `acpi_ev_acquire_global_lock':
> : undefined reference to `cmpxchg'
> drivers/acpi/acpi.o(.text+0x4e4b): In function
> `acpi_ev_release_global_lock':
> : undefined reference to `cmpxchg'

ACPI unconditionally used cmpxchg before this change also -- from asm().
The asm() was broken, so we replaced it with C,
which invokes the cmpxchg macro, which isn't defined for
an 80386 build.

I guess it is a build bug that the assembler allowed us
to invoke cmpxchg in an asm() for an 80386 build in earlier releases.

I'm open to suggestions on the right way to fix this.

1. recommend CONFIG_ACPI=n for 80386 build.

2. force CONFIG_ACPI=n for 80386 build.

3. invoke cmpxchg from acpi even for 80386 build.

4. re-implement locks for the 80386 case.

I guess it depends on why one would build
for 808386 and CONFIG_ACPI=y.  Certainly
there is no risk of 80386 hardware actually
running the CMPXCHG in the ACPI code --
80386 was EOL'd long before ACPI came out
and 2.4.25 (and earlier) would have died on us.

I don't like #1 b/c I don't want to get more
e-mail like this;-)

#2 wouldn't bother me.  But if somebody is
building for i386 for the purpose for de-tuning
the compiler and they really do want ACPI support,
it would bother them.

#3 would be the old behaviour, which also
wouldn't bother me.  I guess we'd duplicate the
macro inside the ACPI code so that others didn't
use it by mistake.

#4 would be an academic exercise, since the code
would never actually execute on an 80386.

suggestions?

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
