From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 03 Nov 2004 10:46:58 +0100
Message-ID: <yzomzxzgt7x.fsf@cern.ch>
References: <20041018020816.48673359@localhost.localdomain>
	<20041018112632.GB4400@openzaurus.ucw.cz>
	<20041021001331.69c6c965@localhost.localdomain>
	<20041020225334.GC29863@elf.ucw.cz>
	<20041101145410.GB12006@tate.loria.fr>
	<20041101154127.GB1056@elf.ucw.cz>
	<20041102220034.GA31435@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041102220034.GA31435-xkTd+U360DcAs8EywTwl9A@public.gmane.org> (Emmanuel
 =?iso-8859-1?q?Thom=C3's?= message of "Tue, 2 Nov 2004 23:00:34 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?q?Emmanuel_Thom=C3=A9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> Uff, this looks pretty ugly. But I guess it is i386 being ugly...

E.> The present version does the indirection once and for all, it's
E.> more readable. I've documented a bit the segment descriptor stuff,
E.> so that it's not so mystifying. I can do most of it in C, using
E.> asm/processor.h and asm/desc.h if you prefer.

As it is a one-off, I'd vote for keeping it in assembly. And your
documentation has made it a lot clearer what is going on.

E.> Ole, while digging up what happens with your real mode / pmode
E.> switch, I discovered that it turns out you're _not_ initializing
E.> the segment descriptor for the data segment. It does not matter
E.> too much, since the wakeup code (once in real mode) hooks ds to
E.> the same place as cs anyway, and sets up the stack accordingly,
E.> but is there a reason for doing so ?  I've initialized the
E.> descriptor, to make things more clear.

I must have thought it was not necessary to touch the data segment, or
I might just have missed it. What you have now seems complete and
correct.

E.> In fact, I hoped that this was a key explaining vgabios crashes:
E.> the es segment point into nowhere (the wakeup code does not touch
E.> it), but maybe the ROM code uses it (who knows). Unfortunately,
E.> movw %ax, %es does not improve things.

So it doesn't help on machines that haven't been able to use the
real-mode POST? 

I guess there could still be things about how the segments are set up
that are carried over to real mode. IIRC, the pm segment limit
determines the meaning of real mode 32-bit offsets. Someone might want
to play with this...

Ole




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
