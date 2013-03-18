From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [3.9-rc1] irq 16: nobody cared (was [3.9-rc1] very poor
 interrupt responses)
Date: Mon, 18 Mar 2013 20:19:03 +0100
Message-ID: <20130318191903.GS9021@phenom.ffwll.local>
References: <Pine.LNX.4.44L0.1303141050310.1983-100000@iolanthe.rowland.org>
 <1460519.ejNFI1DrGk@vostro.rjw.lan>
 <1363280764.26318.4.camel@thor.lan>
 <5657408.cYX6iimiA4@vostro.rjw.lan>
 <alpine.LNX.2.00.1303150851020.9529@pobox.suse.cz>
 <5142E7F0.4020002@gmail.com>
 <alpine.LNX.2.00.1303151424140.9529@pobox.suse.cz>
 <alpine.LNX.2.00.1303151609480.9529@pobox.suse.cz>
 <CAE9FiQUqPTUqPOzANnxpdfoRYPr+OiU5pFEoLKRiOFHd9Py4XQ@mail.gmail.com>
 <alpine.LNX.2.00.1303181010080.9529@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1303181010080.9529-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Harald Arnesen <skogtun.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 18, 2013 at 10:12:49AM +0100, Jiri Kosina wrote:
> On Fri, 15 Mar 2013, Yinghai Lu wrote:
> 
> > > Just a datapoint -- I have put a trivial debugging patch in place, and it
> > > reveals that "nobody cared" for irq 16 happens long after last
> > >
> > >         I915_WRITE(GMBUS4 + reg_offset, 0);
> > >
> > > has been performed in gmbus_wait_hw_status(). On the other hand, if I
> > > comment out both GMBUS4 register offset writes in gmbus_wait_hw_status(),
> > > then it of course falls back to GPIO bit-banging, but the "nobody cared"
> > > for irq 16 is gone.
> > >
> > > So it seems like something gets severely confused by the I915_WRITE to
> > > GMBUS4 + reg_offset. So far this seems to have been reported solely on
> > > Lenovos as far as I can see (although a completely different types), so it
> > > might be some platform-specific quirk?
> > >
> > > Honestly, I still don't understand how all the GMBUS stuff relates to IRQ
> > > 16 at all.
> > 
> > that device is using
> > i915 0000:00:02.0: irq 44 for MSI/MSI-X
> > 
> > so can you try to boot with pci=nomsi?
> 
> Yes, switching from MSI to IO-APIC-fasteoi makes the report about lost 
> interrupts go away.
> 
> My understanding from the other mail is that DAniel Vetter already has an 
> idea what might be going wrong with IRQ acking on GM45 chipsets; hopefully 
> this datapoint regarding MSI will fit into it.

Yep, there's a big comment in the irq handler for that chipset that we
have a gaping race with when using MSI interrupts. Although the comment
bodly claims that the race is small enough to avoid the dreaded "nobody
cared" message. Looks like gmbus is good at hitting that race - on newer
chips it already brought up a similar race in handling pch interrupts.

Can you please give the below patch a whirl? It removes the probably race
msi race avoidance code and replaces it with the same trick Paulo used to
fix pch irq handling races.

Thanks, Daniel
---
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 3c7bb04..13de12e 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -2684,7 +2684,7 @@ static irqreturn_t i965_irq_handler(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *) arg;
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
-	u32 iir, new_iir;
+	u32 iir, new_iir, ier;
 	u32 pipe_stats[I915_MAX_PIPES];
 	unsigned long irqflags;
 	int irq_received;
@@ -2692,9 +2692,14 @@ static irqreturn_t i965_irq_handler(int irq, void *arg)
 
 	atomic_inc(&dev_priv->irq_received);
 
+	/* irq race avoidance, copy&pasta from Paulo's PCH irq fix */
+	ier = I915_READ(IER);
+	I915_WRITE(IER, 0);
+	POSTING_READ(IER);
+
 	iir = I915_READ(IIR);
 
-	for (;;) {
+	do {
 		bool blc_event = false;
 
 		irq_received = iir != 0;
@@ -2792,7 +2797,10 @@ static irqreturn_t i965_irq_handler(int irq, void *arg)
 		 * stray interrupts.
 		 */
 		iir = new_iir;
-	}
+	} while (0);
+
+	I915_WRITE(IER, ier);
+	POSTING_READ(IER);
 
 	i915_update_dri1_breadcrumb(dev);
 
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
