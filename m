From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Tue, 30 Mar 2004 20:30:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403302030.26476.arekm@pld-linux.org>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1080668673.989.106.camel@dhcppc4>
Content-Disposition: inline
To: Len Brown <len.brown@intel.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Willy Tarreau <willy@w.ods.org>, "Richard B. Johnson" <root@chaos.analogic.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Dnia Tuesday 30 of March 2004 19:44, Len Brown napisa=B3:

> Luming has already taking a swing at this patch here:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D2391
Wouldn't be better to just remove #ifdef CONFIG_X86_CMPXCHG around __cm=
pxchg()=20
and cmpxchg macro in ./include/asm-i386/system.h so cmpxchg() would be =
there=20
always even on i386 but leave CONFIG_X86_CMPXCHG macro if anyone want's=
 to=20
check for it in some code. No code duplication and you get what you nee=
d.

It would be something like:

#ifdef CONFIG_X86_CMPXCHG
#define __HAVE_ARCH_CMPXCHG 1
#endif
static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long=
 old,
                                      unsigned long new, int size)
{
}
#define cmpxchg(ptr,o,n)\
        ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
                                        (unsigned long)(n),sizeof(*(ptr=
))))

instead of current:

#ifdef CONFIG_X86_CMPXCHG
#define __HAVE_ARCH_CMPXCHG 1

static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long=
 old,
                                      unsigned long new, int size)
{
}
#define cmpxchg(ptr,o,n)\
        ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
                                        (unsigned long)(n),sizeof(*(ptr=
))))

#else
/* Compiling for a 386 proper.  Is it worth implementing via cli/sti?  =
*/
#endif

?

> thanks,
> -Len

--=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
