From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Mon, 29 Mar 2004 09:01:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403290901.47695.vda@port.imtp.ilyichevsk.odessa.ua>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040329052238.GD1276@alpha.home.local>
To: Willy Tarreau <willy@w.ods.org>, Len Brown <len.brown@intel.com>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Monday 29 March 2004 07:22, Willy Tarreau wrote:
> Hi Len,
>
> On Sun, Mar 28, 2004 at 11:49:15PM -0500, Len Brown wrote:
> > ACPI unconditionally used cmpxchg before this change also -- from asm().
> > The asm() was broken, so we replaced it with C,
> > which invokes the cmpxchg macro, which isn't defined for
> > an 80386 build.
> >
> > I guess it is a build bug that the assembler allowed us
> > to invoke cmpxchg in an asm() for an 80386 build in earlier releases.
> >
> > I'm open to suggestions on the right way to fix this.
> >
> > 1. recommend CONFIG_ACPI=n for 80386 build.
> >
> > 2. force CONFIG_ACPI=n for 80386 build.
> >
> > 3. invoke cmpxchg from acpi even for 80386 build.
> >
> > 4. re-implement locks for the 80386 case.
>
> I like this one, but a simpler way : don't support SMP in this case, so
> that we won't have to play with locks. This would lead to something like
> this :

Yes, SMP makes sense only on 486+

> #ifndef CONFIG_X86_CMPXCHG
> #ifndef CONFIG_SMP
> #define cmpxchg(lock,old,new) ((*lock == old) ? ((*lock = new), old) :
> (*lock)) #else
> #define cmpxchg(lock,old,new) This_System_Is_Not_Supported
> #endif
> #endif
>
> This code (if valid) might be added to asm-i386/system.h so that we don't
> touch ACPI code.
>
> Any comments ?

Inline func please. We definitely don't want to evaluate
lock and old expressions several times.
-- 
vda
