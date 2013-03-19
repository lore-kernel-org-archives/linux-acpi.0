From: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: gm45 intel gfx can generate non-MSI irq# in MSI mode (was Re:
 [PATCH] drm/i915: stop using GMBUS IRQs on Gen4 chips (was Re: [3.9-rc1] irq
 16: nobody cared (was [3.9-rc1] very poor interrupt responses
Date: Tue, 19 Mar 2013 12:14:39 -0700
Message-ID: <CAE9FiQUyr4Tjw9F6o8FMf0+WMSFuucanskTT7e=eqjvRqi0HPQ@mail.gmail.com>
References: <CAKMK7uGnZFaLQaZtoQ0Fz0ViNNjBvmf0Ak=qPmdAcm2mRBD7rA@mail.gmail.com>
	<Pine.LNX.4.44L0.1303191136020.15684-100000@netrider.rowland.org>
	<CAKMK7uGtLcuSsoumAgdB7ri+fR5ReNYcZELbqDcSueXVsewppg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKMK7uGtLcuSsoumAgdB7ri+fR5ReNYcZELbqDcSueXVsewppg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Harald Arnesen <skogtun.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Arkadiusz Miskiewicz <a.miskiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 19, 2013 at 9:54 AM, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org> wrote:

> I guess I should have phrased it more precisely, but that's exactly
> what I expect is happening on my machine: I don't have anything on
> irq16 (i.e. in non-msi mode the gfx interrupt isn't shared) and hence
> the irq is completely disabled. Which obviously makes it impossible
> for me to reproduce the issue. To test that theory, is there a quick
> way to force-enable a given interrupt, short of just hacking up a 2nd
> dummy irq handler in my driver?

You may try to add another request_irq()
after i915_load_modeset_init==>drm_irq_install.
That could install one dummy action for ioapic irq for i915.

Also you may need to add one quirk that does not disable intx during
msi enabling like:
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,
                        0x2e22,
                        quirk_msi_intx_disable_bug);

Thanks

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
