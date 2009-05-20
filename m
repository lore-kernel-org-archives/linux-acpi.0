From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
 suspend
Date: Wed, 20 May 2009 10:17:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905201010260.2914-100000@iolanthe.rowland.org>
References: <200905201429.06113.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905201429.06113.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Mario Limonciello <mario_limonciello-8PEkshWhKlo@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 May 2009, Oliver Neukum wrote:

> > Here's another question: Since there is a udev removal event for the
> > radio device, why not add a udev rule to switch back to HID+bluetooth
> > mode every time that event occurs?
> 
> 1. You'd have two rules doing the same thing (resume & addition)

That's okay.  Inelegant, perhaps, but workable.  Besides, as we see 
below, the new rule would have to do more than the old rule.

> 2. It is unclean, as the removal event doesn't tell you which device to run
> hid2hci on

I'm sure you could figure it out from the sysfs paths.

> 3. The device might really be physically removed

True.  So you'd want to delay for a second or so before trying to do
the switch and check whether the device is still attached.

> 4. You can intentionally run hid2hci to switch back to HID

Does that create the same removal event?  If it does then you wouldd be
in an unfortunate state.  The script would have to check somehow
whether the removal was deliberate or spontaneous.

> PS: Why, oh why don't people use configurations as they were designed?

I can't answer that.  :-)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
