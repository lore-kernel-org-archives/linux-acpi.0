From: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Subject: Re: Laptop does not reboot
Date: Fri, 27 Feb 2004 09:07:23 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GHP.4.44.0402270907080.7274-100000@elektron.its.tudelft.nl>
References: <200402270209.04355.bernd-schubert@web.de>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402270209.04355.bernd-schubert-S0/GAf8tV78@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernd Schubert <bernd-schubert-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Dieter Rohlfing <u490248-uKKRHEr75Vc@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Try apt-get.org for a backport of module-init-tools maybe.

On Fri, 27 Feb 2004, Bernd Schubert wrote:

> > I've deleted the remaining lines, because I think it's not relevant. As
> > you can see, I played with some kernel options. Among those were:
> > acpi=on/off/force/ht, apm=on/off, reboot=[cbhw],
> > pci=bios/nobios/conf1/conf2/nosort/biosirq/noacpi. But whatever
> > combination I tried, I never had success with rebooting the laptop. The
> > only way to get a working reboot is with a kernel 2.2.x. Other 2.4.x
> > kernels (x=18,20,22,24,25) always failed to reboot the machine.
> >
>
> Hi,
>
> maybe you should also give 2.6.x a try? Well, woody is too old for that, you
> would have to upgrade to unstable (don't know if there are already backports
> or if all required stuff is also already in Sarge).
>
>
> Also, have you already tried to reboot via magic-sysrq (needs to be enabled in
> kernel configuration, of course). So either <alt+print+b> or
> "echo "b" > /proc/sysrq-trigger". Of course thats not a clean reboot, but
> might be interesting for testing.
>
> Mayby even the reboot command from the sysvinit package is too old, don't
> know. IMHO woody is too much outdated and shouldn't be used for anything
> except servers any more.
>
>
> Cheers,
> 	Bernd
>
>
> PS: Whats about giving Knoppix a try, if it works there, then its either a
> problem with too much outdated woody packages or wrong kernel configuration.
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
