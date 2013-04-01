From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH] dummy-irq: introduce a dummy IRQ handler driver (was Re:
 gm45 intel gfx can generate non-MSI irq# in MSI mode (was Re: [PATCH]
 drm/i915: stop using GMBUS IRQs on Gen4 chips (was Re: [3.9-rc1] irq 16:
 nobody cared (was [3.9-rc1] very poor interrupt respo))
Date: Mon, 1 Apr 2013 20:30:13 +0200
Message-ID: <CAKMK7uFvbbUXZ4NGSWTMiqFEPxX+5CBnJE7t_A35vosxODVR9Q@mail.gmail.com>
References: <Pine.LNX.4.44L0.1303201319190.1208-100000@iolanthe.rowland.org>
	<alpine.LNX.2.00.1303210018430.16237@pobox.suse.cz>
	<20130321144526.GR9021@phenom.ffwll.local>
	<alpine.LNX.2.00.1303312153520.22069@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1303312153520.22069-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Harald Arnesen <skogtun.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Arkadiusz Miskiewicz <a.miskiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Mar 31, 2013 at 9:55 PM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Thu, 21 Mar 2013, Daniel Vetter wrote:
>
>> Indeed, this is pretty useful and allowed me to quickly reproduce that
>> phantom irq on my gm45. Thanks to module reloading we can even reset the
>> kernel's irq disabling logic and so test different tricks quickly without
>> rebooting. Really useful.
>
> Daniel,
>
> out of curiosity, have you been able to make some sense of the phantom
> legacy IRQs on GM45 systems, or are we just staying with my original
> bandaid (disabling GMBUS IRQs), declaring GM45 broken in this respect?

I've played around with dummy-irq on my own gm45 and afaict every
gmbus interrupt generates both an msi and a legacy pci interrupt when
msi is enabled. Everything else (= other interrupt sources) seems to
work as expected, and disabling msi also papers over the issue.
There's also scary comments in our gm45 irq handler that we need msi
to paper over some other races.

So I've decided that I don't want to dwell any longer in this
particular dungeon and that your bandaid (of just disabling this mess)
is the real fix.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
