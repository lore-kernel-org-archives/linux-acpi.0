From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
 suspend
Date: Wed, 20 May 2009 14:31:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905201423130.4044-100000@iolanthe.rowland.org>
References: <4A144347.80303@dell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A144347.80303-8PEkshWhKlo@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mario Limonciello <mario_limonciello-8PEkshWhKlo@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 May 2009, Mario Limonciello wrote:

> Hi Alan:
> 
> Alan Stern wrote:
> > On Wed, 20 May 2009, Oliver Neukum wrote:
> >
> >   
> >
> > That's okay.  Inelegant, perhaps, but workable.  Besides, as we see 
> > below, the new rule would have to do more than the old rule.
> >
> >   
> I agree this is a rather inelegant solution. A  new rule would have to
> be added to hid2hci then.  It's much more preferable to be able to fix
> kernel space from mucking up the device.  Is there a way to mark a
> device to /not/ run reset-resume after S3?

	echo 0 >/sys/bus/usb/devices/.../power/persist

This will also prevent reset-resume after hibernation.

> > Does that create the same removal event?  If it does then you wouldd be
> > in an unfortunate state.  The script would have to check somehow
> > whether the removal was deliberate or spontaneous.
> >   
> Yes it does create the same removal event when you switch to HID mode. 
> I don't know of any way that you can calculate if the switch was
> intentional.

You can't.  Instead you have to arrange things so that when the
intentional change was made, it left behind a timestamp indicator.  If
that timestamp if present and not more than a few seconds in the past,
you know the change was intentional.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
