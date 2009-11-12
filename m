From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Thu, 12 Nov 2009 18:00:02 +0100
Message-ID: <200911121800.02383.oliver@neukum.org>
References: <200911112324.58076.rjw@sisk.pl> <200911120841.11263.oliver@neukum.org> <20091112145121.GB6709@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091112145121.GB6709-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, 12. November 2009 15:51:22 schrieb Matthew Garrett:
> On Thu, Nov 12, 2009 at 08:41:11AM +0100, Oliver Neukum wrote:

> > That I would consider backwards. If the user enables runtime power
> > management of a device, he has to live with remote wakeup being enabled.
> > At most the kernel might resume and switch off remote wakeup on the
> > device, but we might also leave this to user space.
> 
> My point was that if we don't have remote wakeup support at runtime, we
> can't enable runtime PM of the device. So we need to be able to
> distinguish between runtime remote wakeup and system sleep remote
> wakeup.

Exactly, but that isn't the same as needing two attributes exported to user
space. That is an absolute requirement only if we can't tell what a device's
capabilities are.
We could introduce a second attribute if we want to prevent drivers from
using remote wakeup to do runtime power management, but it is not
required. We could simply not give user space that choice.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
