From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 20:05:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729180547.20998@192.168.4.1>
References: <20020729183143.GA13729@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020729183143.GA13729-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

>
>(Most comments were added 5 minutes ago).
>
>Does it look understendable now?

Yes, definitely more clear, there are probably interesting bits
in there to re-use for suspend-to-ram as well.
However, the mucking with kernel threads is definitely specific
to your need of keeping the target block device up without getting
nasty filesystem-originated requests.

Actually, I'm considering we could probably do both :) That is
suspend-to-disk is actually a superset of suspend-to-RAM. So
we could suspend-to-RAM-and-disk, basically allowing us to
wakeup fast from RAM, but still be able to wakeup from disk
if battery is exhausted.

Anyway, in your scheme, the main thing I'm currently concerned
about is the free_some_memory/do_suspend_sync/driver_suspend
thing which is nasty. How do you deal with memory beeing
re-allocated after free_some_memory ? (typically driver needing
RAM for saving state or a non-filesystem-related daemon doing
a kmalloc (or a driver from a tasklet). Also, do you push
as much as possible to swap ? Or may such an allocation still
cause more swap activity ? This can be nasty especially since
swap here can be an mmap'd file, or a swap file, thus possibly
racing with the fact you stopped filesystem specific daemons.

Then, finally, the drivers_suspend() state must be broken in
pieces, that is needed for both suspend-to-RAM and -to-disk,
(see my other email).

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
