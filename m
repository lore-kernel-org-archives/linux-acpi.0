From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 21:02:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729190219.GD13729@elf.ucw.cz>
References: <20020729180037.GB1233@elf.ucw.cz> <20020729175556.13645@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020729175556.13645-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
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

> >What races can you see?
> 
> Well, existing PM callbacks aren't good enough :) they just don't
> deal with dependencies properly. Also, they don't deal that well

Yep, I know. I'm using Patrick's devicefs callback.

> >> The problem of saving to disk and of saving to memory (that is
> >> machine sleep as I implement it on powerbooks today, RAM content
> >> beeing preserved) is pretty similar.
> >
> >Actually it is quite different.
> >
> >Saving device state is common code, but suspend-to-ram can be done
> >without scheduling, while you need to block for suspend-to-disk.
> 
> No. They end up beeing very similar. Suspend to RAM has to schedule
> because some underlying device drivers will need to schedule to
> properly block their queues as well.

Okay, true. Still they are different because suspend-to-disk needs
working disk driver to save pages.

> I figured out in the Pmac implementation that I could actually let
> the system schedule the whole time up to just before the very last
> step of shutting down the CPU. Userland apps will simply block as
> they rely on IOs for drivers that have been properly blocked, or
> from swap while the swap device may be suspended, etc... CPU
> intensive app would still work until it's very last timeslice is
> used before suspend.

Being extremely cpu-efficient is not 1-st priority goal of
swsusp. First make it work, then make it faster ;-).

> That's also how I got very fast wakeup times. Basically, processes
> start again right away (well, just after a few really important things
> like time are restored), and then drivers are kicked back into life,
> asynchronously if possible, thus user processes that are blocked by
> a given driver will come back to life normally.

I believe you give way too much responsibility to drivers...

> >> So you really need to properly do the prepare/save/suspend steps
> >> on all devices in proper bus ordering so that any device driver
> >> has properly saved state information to memory (which may later
> >> be saved to disk with suspend-to-disk) and has properly blocked
> >> IO queues.
> >> 
> >> The specific case of the device which is used as a backstore
> >> for the RAM save has to be dealt some specific way. 
> >
> >No it does not. I have half of RAM free, I just save-state, copy
> >memory, continue devices, copy saved memory to swap.
> 
> So you resume devices from the "saved state" which isn't the
> state the device was when the machine was really suspended,
> right ? Which means that typically, on resume, the driver could
> end up beeing out of sync with the device if some permanent state
> information exist on the device, but I agree this is a rare case,
> except for... storage. 

There's power cycle and whole kernel bootup. Device state is
completely lost during suspend to disk.

> So I assume you have ways to prevent
> filesystems to be touched at all ?

There's nothing alive that could touch filesystems. If user boots into
non-suspend-aware kernel and writes to disk disk, his fault.

>From Docs/swsusp.txt:

 * BIG FAT WARNING
*********************************************************
 *
 * If you have unsupported (*) devices using DMA...
 *                              ...say goodbye to your data.
 *
 * If you touch anything on disk between suspend and resume...
 *                              ...kiss your data goodbye.
 *
 * If your disk driver does not support suspend... (IDE does)
 *                              ...you'd better find out how to get along
 *                                 without your data.
 *
 * (*) pm interface support is needed to make it safe.

You need to append resume=/dev/your_swap_partition to kernel command
line. Then you suspend by echo 4 > /proc/acpi/sleep.

> As I see it, for your scheme to work properly, you need to,
> somewhat "atomically", save-state all devices so they are
> in coherent state one to each other (devices can well be
> inter-dependant), backup your RAM, then you can kick back
> devices (well, some actually) into life.

Yep, that's what I'm doing.

> This is really only a special case of the generic process I'm
> suggesting then ;)
> 
> Basically, you still need to run the "block IOs then save state
> and suspend" step on all devices in bus ordering. 

I don't need "block IO" step. I just stop everything that could
possibly ask drivers to do IO.

> So that
> part is common with suspend-to-ram. 

Yep, drivers part is identical with suspend-to-ram. 

> Actually, you don't need
> to prevent scheduling before that point, except maybe for
> keeping your "half of RAM free" watermark, but even then, I
> don't see how you acheive that since the kernel itself may
> allocate memory (see note below)

It is not 100% guaranteed that it is possible to get half of RAM
free. In such case suspend-to-disk fails.

> Then you need to use the explicit device model power
> state functions to re-enable power state on the target device
> of the backup. It should in turn re-enable parent devices up
> to the host bus.

No, I just re-enable everything.

> However, that would be inefficient as the net effect would be
> to have your hard disk spin down, be eventually powered off,
> then back up for suspend to RAM, then the machine powered off
			      ~~~
				\____ I believe you mean disk here.

> (and so that hard disk as well).

Yes, it is not effective (and disk will do ugly
spindown-spinup-powerdown cycle). It is still faster than bios
suspend-to-disk ;-).

> Which is why I beleive it would make more sense to specifically
> instruct the target device (and so it's parent) during the
> device suspend loop to _not_ go to sleep, just suspend, block
> IOs, then resume IOs, but _not_ do actual suspend.

In such case you can as well do suspend-but-don't-sleep for *all*
devices. They are going to be powered down, anyway, so who cares.

> If we stick to the 3 step model we discussed at OLS
> 
>  1) prepare for sleep (memory allocation, etc...), stop
>     doing _any_ non-ATOMIC (or non-NOIO) memory allocation
>     beyond the point, the driver has to pre-allocate what
>     it will need from now on, eventually running with degraded
>     perfs (serialized)
>  2) block IOs & save state. Block drivers should stop their
>     request queue, drivers impl. a direct /dev interface should
>     block processes calling them until they are resumed, etc...
>     typically done easily with a semaphore for most of them.
>     then save state informations to pre-allocated memory

I believe you are putting *way* too much responsibility to the
drivers. With your model each driver needs to be able to stop its
users. Ouch. Remember -- there's lot of drivers. You do not want to
add crap^Wcode to them. Better just stop all user programs so that
drivers don't have to care.

>  3) suspend (IRQs off) Or optionally 4 steps with 3) suspend_irq_on
>     and 4) suspend_irq_off.
> 
> Then suspend-to-disk would need to call steps 1 and 2 normally,
> but not 3 for devices on the storage chain. Then, after the

It is hard to tell which devices are on the storage chain. And it
should *not* be neccessary to treat them differently.

> >> If not, what about
> >> open inodes, sockets, etc... ? How do you resume kernel state information
> >> for these ? 
> >> How do you deal with device-drivers that are configured in
> >> some specific way before suspend and has to come back up the same
> >> way ?
> >
> >I need device support for suspend-to-disk, of course. But I need no
> >special support on "suspend" device.
> 
> I still think it need to be handled slightly differently (see above),
> I'm trying to see what has to be common and what not. Defining (and
> then implementing) the proper device support is the biggest issue,
> I think we have the semantics approximately right in mind Patrick
> and I, it's time to write them down :)

Hehe, I believe I have semantics right, too, and have written it down
in kernel/suspend.c ;-)))).

> (*note about device mem alloc): Some devices need to allocate memory
> to be able to save sate. That can be a significant amount of memory
> (some framebuffer may want to backup the fb content, huge !). 

After free_some_memory(), there's very likely *plenty* of memory
available. If framebuffer wants to backup the fb content, and it runs
out of memory, tough, and suspend fails.

[BTW you don't need/want to backup fb content; either its X or its
text console. Text console knows how to repaint itself. X knows how to
repaint itself.]

> So in your case, I beleive you should probably first send the notification
> of step 1 (prepare for sleep) to drivers, then do your memory-crunching
> thing, then call step 2 and step 3 for all but swap device.

If I do memory-freeing, step 1, step 2, step 3, memory-copy it should
be equivalent, AFAICS. That's what I'm doing (but for all devices).

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
