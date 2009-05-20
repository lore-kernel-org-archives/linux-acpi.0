From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Wed, 20 May 2009 14:29:04 +0200
Message-ID: <200905201429.06113.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0905192212560.7309-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:48788 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbZETM2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2009 08:28:47 -0400
In-Reply-To: <Pine.LNX.4.44L0.0905192212560.7309-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mario Limonciello <mario_limonciello@dell.com>, linux-usb@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Marcel Holtmann <marcel@holtmann.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Mittwoch, 20. Mai 2009 04:17:59 schrieb Alan Stern:
> On Wed, 20 May 2009, Oliver Neukum wrote:

> > Marcel, are the HID devices usable after hid2hci has run? Should we
> > choose to not resume from power loss any hid device which hid2hci
> > operated on?
>
> I'd like to know why the device switches back from HID+bluetooth to
> pure HID during a suspend-resume sequence.  Does it undergo a
> reset-resume?

Yes.

[ =A0111.356035] usb 2-3: reset high speed USB device using ehci_hcd an=
d address 2
[ =A0111.668045] usb 3-4: reset full speed USB device using ohci_hcd an=
d address 2
[ =A0112.177152] usb 3-4.1: reset full speed USB device using ohci_hcd =
and address 3
[ =A0112.361151] usb 3-4.2: reset full speed USB device using ohci_hcd =
and address 4
[ =A0112.471157] pm_op(): usb_dev_resume+0x0/0x10 returns -19
[ =A0112.471160] PM: Device 3-4.3 failed to resume: error -19
[ =A0112.471373] PM: resume devices took 3.256 seconds
[ =A0112.471980] PM: Finishing wakeup.
[ =A0112.471982] Restarting tasks ... <6>usb 3-4.3: USB disconnect, add=
ress 5
[ =A0112.504314] btusb_send_frame: hci0 urb f4520700 submission failed
>
> Here's another question: Since there is a udev removal event for the
> radio device, why not add a udev rule to switch back to HID+bluetooth
> mode every time that event occurs?

1. You'd have two rules doing the same thing (resume & addition)
2. It is unclean, as the removal event doesn't tell you which device to=
 run
hid2hci on
3. The device might really be physically removed
4. You can intentionally run hid2hci to switch back to HID

	Regards
		Oliver

PS: Why, oh why don't people use configurations as they were designed?

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
