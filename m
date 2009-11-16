From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Mon, 16 Nov 2009 22:26:02 +0100
Message-ID: <200911162226.02569.oliver@neukum.org>
References: <200911112324.58076.rjw@sisk.pl> <200911121800.02383.oliver@neukum.org> <20091112165958.GA9389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091112165958.GA9389-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, 12. November 2009 17:59:58 schrieb Matthew Garrett:
> On Thu, Nov 12, 2009 at 06:00:02PM +0100, Oliver Neukum wrote:
> > Exactly, but that isn't the same as needing two attributes exported to
> > user space. That is an absolute requirement only if we can't tell what a
> > device's capabilities are.
> 
> Right. I don't see any reason for runtime wakeup to be exposed to 
> userspace - it's an entirely orthogonal concept to system wakeup. The 
> relevant userspace policy is whether or not runtime pm is enabled.

That brings me to a possibly useless, wild idea. Do we want to tristate
this? Is there any use in a "don't care" setting?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
