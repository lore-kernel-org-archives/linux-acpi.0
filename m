From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 21:38:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730193857.GC12091@atrey.karlin.mff.cuni.cz>
References: <20020730182921.GD7567@atrey.karlin.mff.cuni.cz> <20020730181810.30687@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730181810.30687-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
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


> >[Currently I'm stopping it at even higher level by stopping
> >processes. I still think stopping everything is easiest solution, and
> >probably only one doable for 2.6.]
> 
> Well, it could be done stopping process first, until all drivers are
> safe enouh. That mean keeping the IO blocking semantics for drivers
> while having the process stopped to help deal with drivers not
> implementing that at first, but I'd prefer doing it the right way
> first.

I'd not call it right way. 

What you propose is adding test into *fast* path of every driver. I'm
not touching fast path at all, I just stop all processes. That way
suspend takes longer but system normally runs faster.

> >>  - Things like serial drivers usually don't have to do anything
> >>    terrific, just stop the chip interrupt and users will be blocked
> >>    (or will timeout, but that is not a problem at this point)
> >>  - For pmac sound driver, I choose to have a mutex that cause users
> >>    to be blocked, but that was the "easy" way to quickly get that
> >>    done, a more subtle mecanism could be done, dropping samples at
> >>    approximately the output rate. The mutex makes it easy to make
> >>    the whole driver SMP safe as well regarding mixer tweaks though.
> >
> >Why don't you just put that mutex into sys_read etc? Or why not system
> >stopping? There's just too much drivers.
> 
> sys_read, sys_ioctl, etc... ? well, drivers can be kicked by other
> means than just syscalls. And if you tear down subsystems, you take
> the risk of stopping a subsystem before a driver that need it for
> proper suspend had a chance to use it.

Do you have example of such subsystem?

Certainly no driver depends on userspace so we may stop userspace.

Hardware drivers do not depend on IP stack, etc...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
