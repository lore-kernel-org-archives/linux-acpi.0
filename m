From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:39:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730183941.6386@192.168.4.1>
References: <20020730193857.GC12091@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730193857.GC12091-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
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

>I'd not call it right way. 
>
>What you propose is adding test into *fast* path of every driver. I'm
>not touching fast path at all, I just stop all processes. That way
>suspend takes longer but system normally runs faster. 

Hrm... most of the time that test already exist. Network & block
drivers already have blocking semantics. Serial-like drivers will
only need to switch their interrupt source off if any or timer
or whatever. The only case on pmac where I had to touch the normal
path was some ioctl() path (which aren't really fast path anyway
like preventing some ioctl's to network drivers from banging sleeping
hardware), and the sound driver, but I needed that already for SMP
safety.

>> >>  - Things like serial drivers usually don't have to do anything
>> >>    terrific, just stop the chip interrupt and users will be blocked
>> >>    (or will timeout, but that is not a problem at this point)
>> >>  - For pmac sound driver, I choose to have a mutex that cause users
>> >>    to be blocked, but that was the "easy" way to quickly get that
>> >>    done, a more subtle mecanism could be done, dropping samples at
>> >>    approximately the output rate. The mutex makes it easy to make
>> >>    the whole driver SMP safe as well regarding mixer tweaks though.
>> >
>> >Why don't you just put that mutex into sys_read etc? Or why not system
>> >stopping? There's just too much drivers.
>> 
>> sys_read, sys_ioctl, etc... ? well, drivers can be kicked by other
>> means than just syscalls. And if you tear down subsystems, you take
>> the risk of stopping a subsystem before a driver that need it for
>> proper suspend had a chance to use it.
>
>Do you have example of such subsystem?

i2c, usb, ieee1394, then all the possibilities of stacking things
on top of each other...

>Certainly no driver depends on userspace so we may stop userspace.

Well, I know at least a DSL softmodem driver that relies on userspace
(or will soon) as the core softmodem code is moved out of the kernel ;)

>Hardware drivers do not depend on IP stack, etc...

_device_ driver include stacked devices. It includes a scsi-over-IP
device if any on which you have perfect right to want to send a command
before suspending.

Ben.





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
