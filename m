From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 21:53:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730195348.GJ12091@atrey.karlin.mff.cuni.cz>
References: <1028061979.7974.40.camel@irongate.swansea.linux.org.uk> <20020730183448.20582@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730183448.20582-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> Benjamin Herrenschmidt was arguing for doing driver_suspend() while
> >> userspace is still running. If you assumed stopped userspace, you
> >> don't have to add semaphore into device read() etc...
> >
> >Having been around this a few times for embedded devices I've found
> >nothing that cleanly solves the problems except
> >
> >Call all the devices "suspend ready irq on" methods
> >Disable interrupts
> >Call all the devices "final suspend" method
> 
> Yes, I remember you telling me about it, which simply involves
> breaking the 3rd (ie. "suspend") PM notification into a
> "suspend_irq_on" and a "suspend_irq_off". Drivers that don't
> care will use only one of them. But that's not a real issue,
> the problems are really around the "save_state & block IOs"
> step which is step 2.
> 
>  step 1: prepare (that is allocate any memory needed, make sure
>          the driver can still operate without allocating more
>          memory, or eventually only ATOMIC or NOIO).
> 
>  step 2: save_state & block IOs, that is make sure the saved state
>          is consistent with the last IOs and that no more IO will
>          be processed. The driver don't need to wait for completion
>          of pending IOs at this stage I beleive if those don't
>          impact the saved state, but it may be better to wait for
>          them at first.

I really need all DMAs to be off after step 2; so I need all drivers
doing DMA to wait for completion. [I can not do atomic copy of memory
with DMA writing over it behind my back.]
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
