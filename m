From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 21:51:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730195149.GI12091@atrey.karlin.mff.cuni.cz>
References: <20020730193857.GC12091@atrey.karlin.mff.cuni.cz> <20020730183941.6386@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730183941.6386-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
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

> >I'd not call it right way. 
> >
> >What you propose is adding test into *fast* path of every driver. I'm
> >not touching fast path at all, I just stop all processes. That way
> >suspend takes longer but system normally runs faster. 
> 
> Hrm... most of the time that test already exist. Network & block
> drivers already have blocking semantics. Serial-like drivers will
> only need to switch their interrupt source off if any or timer
> or whatever. The only case on pmac where I had to touch the normal
> path was some ioctl() path (which aren't really fast path anyway
> like preventing some ioctl's to network drivers from banging sleeping
> hardware), and the sound driver, but I needed that already for SMP
> safety.

Okay, if impact is minimal.... I can probably live with that. I still
do not know if slightly faster suspend is worth the effort.

> >Do you have example of such subsystem?
> 
> i2c, usb, ieee1394, then all the possibilities of stacking things
> on top of each other...
> 
> >Certainly no driver depends on userspace so we may stop userspace.
> 
> Well, I know at least a DSL softmodem driver that relies on userspace
> (or will soon) as the core softmodem code is moved out of the kernel ;)
> 
> >Hardware drivers do not depend on IP stack, etc...
> 
> _device_ driver include stacked devices. It includes a scsi-over-IP
> device if any on which you have perfect right to want to send a command
> before suspending.

I believe device drivers do not need to know. If you are running
scsi-over-IP you don't need to inform other side you are
suspending. It is similar to your NFS server; you don't tell your NFS
server that you are suspending. scsi-over-IP device should not need to
know.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
