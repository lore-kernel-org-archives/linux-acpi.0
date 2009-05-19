From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Wed, 20 May 2009 00:16:48 +0200
Message-ID: <200905200016.49110.oliver@neukum.org>
References: <4A11C126.1000704@dell.com> <200905192326.46274.oliver@neukum.org> <4A1328D6.5090404@dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1328D6.5090404-8PEkshWhKlo@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mario Limonciello <mario_limonciello-8PEkshWhKlo@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Dienstag, 19. Mai 2009 23:47:02 schrieb Mario Limonciello:
> Hi Oliver:

> Attached are both the lsusb listings.  As you can see, the missing
> device post-suspend is that Bluetooth radio device (which is why I
> proposed this patch in the first place).

This explains the error in your log.

> There is a udev removal event for this device, but as I said, there are
> no add/remove/change events for the keyboard or mouse devices.  I'm
> attaching udevadm monitor ran from right before the suspend to right after.

That is correct the devices have been successfully resumed and thus are
present. Generally the idea of suspened/resume is to have the same system
after resumption. It is correct to not generate events. Usbcore cannot know
that you use udev to switch the device from pure HID to HID + bluetooth.

> Sending the appropriate hid report to the mouse device will re-attach
> this Bluetooth radio device to the bus.

Yes, the question is whether it is the clean thing to do.

Marcel, are the HID devices usable after hid2hci has run? Should we
choose to not resume from power loss any hid device which hid2hci
operated on?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
