From: Dieter Rohlfing <u490248-uKKRHEr75Vc@public.gmane.org>
Subject: Re: Laptop does not reboot
Date: Sun, 29 Feb 2004 16:53:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40420AEA.63D1586C@imail.de>
References: <403E59FF.990E2CD0@imail.de>
 <200402270209.04355.bernd-schubert@web.de>
Reply-To: u490248-uKKRHEr75Vc@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernd Schubert <bernd-schubert-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Bernd,

> maybe you should also give 2.6.x a try? Well, woody is too old for that, you
> would have to upgrade to unstable (don't know if there are already backports
> or if all required stuff is also already in Sarge).

Yesterday I made a try with Knoppix 3.4 (c't edition), it has kernel
2.6.1. And ... the laptop properly rebooted. So, I'll give the latest
2.6.x a chance. As far as I know I have to update my module utilities
too.

> Mayby even the reboot command from the sysvinit package is too old, don't
> know. IMHO woody is too much outdated and shouldn't be used for anything
> except servers any more.

I don't think, it's a matter of the reboot command in woody. This
command just tells the kernel to reboot or to halt. The necessary
commands in order to reboot/halt are sent by the kernel. That's my
conclusion from a look into the kernel sources.

> PS: Whats about giving Knoppix a try, if it works there, then its either a
> problem with too much outdated woody packages or wrong kernel configuration.

See above. Wrong kernel configuration: that's a suspicion I have too.
The kernel in question is a 'one-fits-all' kernel for all my PCs, so it
contains some drivers for devices, which are not in my laptop. As
another try a built a kernel, which included only the necessary drivers
for my laptop. Result: no proper rebooting.

I must confess, I'm really at my wit's end. :-(

Dieter

-- 
Every mail not from this mailing list will be deleted.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
