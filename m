From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Sat, 8 May 2004 13:18:28 +0300
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200405081318.28853.vda@port.imtp.ilyichevsk.odessa.ua>
References: <4069A359.7040908@nortelnetworks.com> <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl> <Pine.LNX.4.53.0404010814420.15020@chaos>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264218AbUEHKS4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0404010814420.15020@chaos>
Content-Disposition: inline
To: root@chaos.analogic.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>, Len Brown <len.brown@intel.com>, Chris Friesen <cfriesen@nortelnetworks.com>, Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arkadiusz Miskiewicz <arekm@pld-linux.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

> In Intel machines ALL memory operations are atomic. What
> the means is that if I make code that does:
>
> 	addl	%eax,(memory)
>
> ... what's in memory will always be the sum of what it was
> before and the value in the EAX register.

Except on SMP.

> A long time ago, somebody invented the 'lock' instruction
> for Intel machines. It turns out that the first ones locked
> the whole bus during an operation. Eventually somebody looked
> at that, and by the time the '486 came out, they no longer
> locked the whole bus. Then somebody else said; "WTF...
> Why do we even need this stuff". It was a throw-back to
> early primitive machines where there were only load and
> store operations in memory. All arithmetic had to be done
> in registers. Now, there are only a couple instructions you
> can use the lock prefix with, or you get an invalid opcode
> trap, and they are really no-ops because the instruction
> itself is atomic.

Not on SMP. On SMP, lock prefix *is needed*.

If you think I'm wrong, point me to the relevant docs.
--
vda
