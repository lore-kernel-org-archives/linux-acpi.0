From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Tue, 30 Mar 2004 22:25:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403302225.33966.arekm@pld-linux.org>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <200403302030.26476.arekm@pld-linux.org> <1080677134.980.166.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1080677134.980.166.camel@dhcppc4>
Content-Disposition: inline
To: Len Brown <len.brown@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Dnia Tuesday 30 of March 2004 22:05, Len Brown napisa=B3:
> I can make sure that ACPI checks implicitly or explicitly
> that CMPXCHG is available -- but I can't make sure that
> some other random part of the kernel which may not have
> been written yet does.  So I'd rather that they not build,
> like ACPI didn't.
Well, I asked for this because there is similar case with some DRI driv=
ers in=20
kernel. These drivers use cmpxchg and some time ago it was not possible=
 to=20
build them for i386 (and of course run on 486+). This AFAIK did not cha=
nge.

These not yet written parts of kernel do not exist so nothing to worry =
about=20
right now. Anyway there always could be #warning for i386 - easy to cat=
ch=20
while compiling and would allow to fix that future kernel code then.

> cheers,
> -Len

> > Wouldn't be better to just remove #ifdef CONFIG_X86_CMPXCHG around
> > __cmpxchg() and cmpxchg macro in ./include/asm-i386/system.h so cmp=
xchg()
> > would be there always even on i386 but leave CONFIG_X86_CMPXCHG mac=
ro if
> > anyone want's to check for it in some code. No code duplication and=
 you
> > get what you need.

--=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
