From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 09:57:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730075740.8854@192.168.4.1>
References: <20020729191146.GE13729@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020729191146.GE13729-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Stopping processes is needed (and being used) by suspend-to-ram,
>because anything else is too hard for the drivers (I believe).

I don't agree, and I have this working fairly well on pmac's today,
though that is a limited set of drivers used on these laptops I had
to fix.

>> Actually, I'm considering we could probably do both :) That is
>> suspend-to-disk is actually a superset of suspend-to-RAM. So
>> we could suspend-to-RAM-and-disk, basically allowing us to
>> wakeup fast from RAM, but still be able to wakeup from disk
>> if battery is exhausted.
>
>Good idea. Thinkpads could do that, it was called RediSafe or
>something like that. Disadvantage is that suspend then takes quite
>long time.

Well, if done to a swap partition, with the average throughput of
recent U/DMA disks on things like my laptop, that is about 14Mb/sec,
suspending would indeed take about 20 seconds, which is long, but
still realistic.

>> Anyway, in your scheme, the main thing I'm currently concerned
>> about is the free_some_memory/do_suspend_sync/driver_suspend
>> thing which is nasty. How do you deal with memory beeing
>> re-allocated after free_some_memory ? (typically driver needing
>> RAM for saving state or a non-filesystem-related daemon doing
>> a kmalloc (or a driver from a tasklet). 
>
>I free as much memory as possible. So, if driver allocation fails, it
>would fail on running system, too. If there was anything that could be
>swapped out, I'd already swapped it out.
>
>> Also, do you push
>> as much as possible to swap ? 
>
>Yes.
>
>> Or may such an allocation still
>> cause more swap activity ? 
>
>No.
>
>> This can be nasty especially since
>> swap here can be an mmap'd file, or a swap file, thus possibly
>> racing with the fact you stopped filesystem specific daemons.
>
>swsusp actually suspends right into swap *partition*. So I indeed need
>swap partition and not swap file.
>
>> Then, finally, the drivers_suspend() state must be broken in
>> pieces, that is needed for both suspend-to-RAM and -to-disk,
>> (see my other email).
>
>Well, if you are willing to live with ugly-but-harmless
>spindown-then-spinup and blank-then-unblank, its actually possible to
>keep current system.

Well... why not improve things then ? We are trying to get the proper
semantics of the various suspend steps thrown at drivers and then drivers
fixed, I'd rather see swsusp make use of this as well :)

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
