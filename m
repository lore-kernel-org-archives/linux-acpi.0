From: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: 30 Mar 2004 15:05:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1080677134.980.166.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
	 <200403302030.26476.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200403302030.26476.arekm@pld-linux.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Willy Tarreau <willy@w.ods.org>, "Richard B. Johnson" <root@chaos.analogic.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

I can make sure that ACPI checks implicitly or explicitly
that CMPXCHG is available -- but I can't make sure that
some other random part of the kernel which may not have
been written yet does.  So I'd rather that they not build,
like ACPI didn't.

BTW. CMPXCHG (486 and above) doesn't seem to be in CPUID,
CMPXCHG8B is, but that starts with Pentium and above.
Maybe simpler to rely on the implicit "check" that we
did in previous releases...  Earliest known ACPI
implementation as on Pentium-1.

cheers,
-Len

On Tue, 2004-03-30 at 13:30, Arkadiusz Miskiewicz wrote:
> Dnia Tuesday 30 of March 2004 19:44, Len Brown napisa=B3:
>=20
> > Luming has already taking a swing at this patch here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D2391
> Wouldn't be better to just remove #ifdef CONFIG_X86_CMPXCHG around __=
cmpxchg()=20
> and cmpxchg macro in ./include/asm-i386/system.h so cmpxchg() would b=
e there=20
> always even on i386 but leave CONFIG_X86_CMPXCHG macro if anyone want=
's to=20
> check for it in some code. No code duplication and you get what you n=
eed.
>=20
> It would be something like:
>=20
> #ifdef CONFIG_X86_CMPXCHG
> #define __HAVE_ARCH_CMPXCHG 1
> #endif
> static inline unsigned long __cmpxchg(volatile void *ptr, unsigned lo=
ng old,
>                                       unsigned long new, int size)
> {
> }
> #define cmpxchg(ptr,o,n)\
>         ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>                                         (unsigned long)(n),sizeof(*(p=
tr))))
>=20
> instead of current:
>=20
> #ifdef CONFIG_X86_CMPXCHG
> #define __HAVE_ARCH_CMPXCHG 1
>=20
> static inline unsigned long __cmpxchg(volatile void *ptr, unsigned lo=
ng old,
>                                       unsigned long new, int size)
> {
> }
> #define cmpxchg(ptr,o,n)\
>         ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>                                         (unsigned long)(n),sizeof(*(p=
tr))))
>=20
> #else
> /* Compiling for a 386 proper.  Is it worth implementing via cli/sti?=
  */
> #endif
>=20
> ?
>=20
> > thanks,
> > -Len
