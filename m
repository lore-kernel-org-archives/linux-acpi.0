From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 09:53:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730075329.26474@192.168.4.1>
References: <20020729190219.GD13729@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020729190219.GD13729-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

>I believe you are putting *way* too much responsibility to the
>drivers. With your model each driver needs to be able to stop its
>users. Ouch. Remember -- there's lot of drivers. You do not want to
>add crap^Wcode to them. Better just stop all user programs so that
>drivers don't have to care.

Well, you do have to deal with drivers. Users programs is not enough,
drivers can be kicked by things going on in the kernel as well.
 
Also, in most case, it's not that difficult to implement.

 - Network drivers just need to drop packets, pretty easily done
 - Block drivers just need to stop their queue
 - Things like serial drivers usually don't have to do anything
   terrific, just stop the chip interrupt and users will be blocked
   (or will timeout, but that is not a problem at this point)
 - For pmac sound driver, I choose to have a mutex that cause users
   to be blocked, but that was the "easy" way to quickly get that
   done, a more subtle mecanism could be done, dropping samples at
   approximately the output rate. The mutex makes it easy to make
   the whole driver SMP safe as well regarding mixer tweaks though.

I implemented this in a whole bunch of drivers used on Apple laptops
and in the end, the most code is _not_ doing the above properly in
drivers, but doing the actual state save/suspend & resume on the
chip (here you have to deal with broken HW, subtle timing issues, etc...)

So drivers _has_ to be done the right way. If a driver doesn't, then
it will be unsuitable for PM (be it suspend to RAM or to disk). No
problem with that ;)

>>  3) suspend (IRQs off) Or optionally 4 steps with 3) suspend_irq_on
>>     and 4) suspend_irq_off.
>> 
>> Then suspend-to-disk would need to call steps 1 and 2 normally,
>> but not 3 for devices on the storage chain. Then, after the
>
>It is hard to tell which devices are on the storage chain. And it
>should *not* be neccessary to treat them differently.

Well... I would prefer then broadcasting a "save_state/block" to
all of them, then no suspend, and a wakeup. That keeps the existing
semantics valid.

>Hehe, I believe I have semantics right, too, and have written it down
>in kernel/suspend.c ;-)))).

Hrm... not sure about those ;) Anyway, Patrick will probably write down
something precising what we came up with during OLS.

>> (*note about device mem alloc): Some devices need to allocate memory
>> to be able to save sate. That can be a significant amount of memory
>> (some framebuffer may want to backup the fb content, huge !). 
>
>After free_some_memory(), there's very likely *plenty* of memory
>available. If framebuffer wants to backup the fb content, and it runs
>out of memory, tough, and suspend fails.
>
>[BTW you don't need/want to backup fb content; either its X or its
>text console. Text console knows how to repaint itself. X knows how to
>repaint itself.]

Sure, though some fb apps don't. Though here, I agree we need those to
get notified as part of the process (which I do on pmac before doing the
device notification, as part of my /dev/apm_bios emulation) so they can
actually do that repainting properly.

>> So in your case, I beleive you should probably first send the notification
>> of step 1 (prepare for sleep) to drivers, then do your memory-crunching
>> thing, then call step 2 and step 3 for all but swap device.
>
>If I do memory-freeing, step 1, step 2, step 3, memory-copy it should
>be equivalent, AFAICS. That's what I'm doing (but for all devices).

Not sure. step 1 will affect memory allocation, swap etc... I'd rather
have that done before you start doing the memory freeing. Well, that's
mostly a matter of taste though.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
