From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:29:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730182921.GD7567@atrey.karlin.mff.cuni.cz>
References: <20020729190219.GD13729@elf.ucw.cz> <20020730075329.26474@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730075329.26474-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >I believe you are putting *way* too much responsibility to the
> >drivers. With your model each driver needs to be able to stop its
> >users. Ouch. Remember -- there's lot of drivers. You do not want to
> >add crap^Wcode to them. Better just stop all user programs so that
> >drivers don't have to care.
> 
> Well, you do have to deal with drivers. Users programs is not enough,
> drivers can be kicked by things going on in the kernel as well.

Well, so that "thing" that could kick it has to be found and made
suspend-aware. Better than touching 1000 drivers.

> Also, in most case, it's not that difficult to implement.

Wrong level of abstraction.

>  - Network drivers just need to drop packets, pretty easily done

Why? You should modify network stack not to post any packets to them.

>  - Block drivers just need to stop their queue

Block layer should not attempt to pass anything to driver when
suspended. (Theres one block layer, but 100 block drivers; which one
would you like to modify?)

[Currently I'm stopping it at even higher level by stopping
processes. I still think stopping everything is easiest solution, and
probably only one doable for 2.6.]

>  - Things like serial drivers usually don't have to do anything
>    terrific, just stop the chip interrupt and users will be blocked
>    (or will timeout, but that is not a problem at this point)
>  - For pmac sound driver, I choose to have a mutex that cause users
>    to be blocked, but that was the "easy" way to quickly get that
>    done, a more subtle mecanism could be done, dropping samples at
>    approximately the output rate. The mutex makes it easy to make
>    the whole driver SMP safe as well regarding mixer tweaks though.

Why don't you just put that mutex into sys_read etc? Or why not system
stopping? There's just too much drivers.

> >>  3) suspend (IRQs off) Or optionally 4 steps with 3) suspend_irq_on
> >>     and 4) suspend_irq_off.
> >> 
> >> Then suspend-to-disk would need to call steps 1 and 2 normally,
> >> but not 3 for devices on the storage chain. Then, after the
> >
> >It is hard to tell which devices are on the storage chain. And it
> >should *not* be neccessary to treat them differently.
> 
> Well... I would prefer then broadcasting a "save_state/block" to
> all of them, then no suspend, and a wakeup. That keeps the existing
> semantics valid.

That's probably doable.

> >> (*note about device mem alloc): Some devices need to allocate memory
> >> to be able to save sate. That can be a significant amount of memory
> >> (some framebuffer may want to backup the fb content, huge !). 
> >
> >After free_some_memory(), there's very likely *plenty* of memory
> >available. If framebuffer wants to backup the fb content, and it runs
> >out of memory, tough, and suspend fails.
> >
> >[BTW you don't need/want to backup fb content; either its X or its
> >text console. Text console knows how to repaint itself. X knows how to
> >repaint itself.]
> 
> Sure, though some fb apps don't. Though here, I agree we need those to
> get notified as part of the process (which I do on pmac before doing the
> device notification, as part of my /dev/apm_bios emulation) so they can
> actually do that repainting properly.

Kernel tells them that console is being switched away; so it is their
responsibility. Surprise, special console for suspend is not only
pretty but also usefull ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
