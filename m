From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 19:55:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729175556.13645@192.168.4.1>
References: <20020729180037.GB1233@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020729180037.GB1233-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>What races can you see?

Well, existing PM callbacks aren't good enough :) they just don't
deal with dependencies properly. Also, they don't deal that well
with the need for drivers to trigger memory allocations and all
of the issues related to that we discussed during the BOF and
earlier.
driverfs bus-oriented ones would be better here in many regard,
especially since I beleive we found "correct" semantics for the
various steps of device save state & suspend.

>> The problem of saving to disk and of saving to memory (that is
>> machine sleep as I implement it on powerbooks today, RAM content
>> beeing preserved) is pretty similar.
>
>Actually it is quite different.
>
>Saving device state is common code, but suspend-to-ram can be done
>without scheduling, while you need to block for suspend-to-disk.

No. They end up beeing very similar. Suspend to RAM has to schedule
because some underlying device drivers will need to schedule to
properly block their queues as well.

I figured out in the Pmac implementation that I could actually let
the system schedule the whole time up to just before the very last
step of shutting down the CPU. Userland apps will simply block as
they rely on IOs for drivers that have been properly blocked, or
from swap while the swap device may be suspended, etc... CPU
intensive app would still work until it's very last timeslice is
used before suspend.

That's also how I got very fast wakeup times. Basically, processes
start again right away (well, just after a few really important things
like time are restored), and then drivers are kicked back into life,
asynchronously if possible, thus user processes that are blocked by
a given driver will come back to life normally.

>> So you really need to properly do the prepare/save/suspend steps
>> on all devices in proper bus ordering so that any device driver
>> has properly saved state information to memory (which may later
>> be saved to disk with suspend-to-disk) and has properly blocked
>> IO queues.
>> 
>> The specific case of the device which is used as a backstore
>> for the RAM save has to be dealt some specific way. 
>
>No it does not. I have half of RAM free, I just save-state, copy
>memory, continue devices, copy saved memory to swap.

So you resume devices from the "saved state" which isn't the
state the device was when the machine was really suspended,
right ? Which means that typically, on resume, the driver could
end up beeing out of sync with the device if some permanent state
information exist on the device, but I agree this is a rare case,
except for... storage. So I assume you have ways to prevent
filesystems to be touched at all ?

As I see it, for your scheme to work properly, you need to,
somewhat "atomically", save-state all devices so they are
in coherent state one to each other (devices can well be
inter-dependant), backup your RAM, then you can kick back
devices (well, some actually) into life.

This is really only a special case of the generic process I'm
suggesting then ;)

Basically, you still need to run the "block IOs then save state
and suspend" step on all devices in bus ordering. So that
part is common with suspend-to-ram. Actually, you don't need
to prevent scheduling before that point, except maybe for
keeping your "half of RAM free" watermark, but even then, I
don't see how you acheive that since the kernel itself may
allocate memory (see note below)

Then you need to use the explicit device model power
state functions to re-enable power state on the target device
of the backup. It should in turn re-enable parent devices up
to the host bus.

However, that would be inefficient as the net effect would be
to have your hard disk spin down, be eventually powered off,
then back up for suspend to RAM, then the machine powered off
(and so that hard disk as well).

Which is why I beleive it would make more sense to specifically
instruct the target device (and so it's parent) during the
device suspend loop to _not_ go to sleep, just suspend, block
IOs, then resume IOs, but _not_ do actual suspend.

If we stick to the 3 step model we discussed at OLS

 1) prepare for sleep (memory allocation, etc...), stop
    doing _any_ non-ATOMIC (or non-NOIO) memory allocation
    beyond the point, the driver has to pre-allocate what
    it will need from now on, eventually running with degraded
    perfs (serialized)
 2) block IOs & save state. Block drivers should stop their
    request queue, drivers impl. a direct /dev interface should
    block processes calling them until they are resumed, etc...
    typically done easily with a semaphore for most of them.
    then save state informations to pre-allocated memory
 3) suspend (IRQs off) Or optionally 4 steps with 3) suspend_irq_on
    and 4) suspend_irq_off.

Then suspend-to-disk would need to call steps 1 and 2 normally,
but not 3 for devices on the storage chain. Then, after the
RAM is copied, that device can be sent a resume request, though
in this case, you indeed need to make sure no user process or
journaling daemon or whatever will inject requests to your
target device queues that are not specifically your pages
beeing thrown to the backing store.
>
>> I understand (please correct me if I'm wrong) that your mecanism is to
>> implement that at a higher level, though I still fail to see the
>> "big picture" of it, especially how you can properly resume state
>> of all device drivers and other in-kernel state informations. Do you
>> store all pages including kernel pages to disk ? 
>
>Yes I store all pages including kernel ones to disk.
>
>> If not, what about
>> open inodes, sockets, etc... ? How do you resume kernel state information
>> for these ? 
>> How do you deal with device-drivers that are configured in
>> some specific way before suspend and has to come back up the same
>> way ?
>
>I need device support for suspend-to-disk, of course. But I need no
>special support on "suspend" device.

I still think it need to be handled slightly differently (see above),
I'm trying to see what has to be common and what not. Defining (and
then implementing) the proper device support is the biggest issue,
I think we have the semantics approximately right in mind Patrick
and I, it's time to write them down :)

(*note about device mem alloc): Some devices need to allocate memory
to be able to save sate. That can be a significant amount of memory
(some framebuffer may want to backup the fb content, huge !). 

So in your case, I beleive you should probably first send the notification
of step 1 (prepare for sleep) to drivers, then do your memory-crunching
thing, then call step 2 and step 3 for all but swap device.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
