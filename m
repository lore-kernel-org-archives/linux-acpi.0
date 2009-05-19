From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Tue, 19 May 2009 23:26:46 +0200
Message-ID: <200905192326.46274.oliver@neukum.org>
References: <4A11C126.1000704@dell.com> <200905192158.12784.oliver@neukum.org> <4A131858.3080805@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:57202 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZESV00 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 17:26:26 -0400
In-Reply-To: <4A131858.3080805@dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Marcel Holtmann <marcel@holtmann.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, 19. Mai 2009 22:36:40 schrieb Mario Limonciello:
> [ =A0112.471157] pm_op(): usb_dev_resume+0x0/0x10 returns -19
> [ =A0112.471160] PM: Device 3-4.3 failed to resume: error -19
> [ =A0112.471373] PM: resume devices took 3.256 seconds
> [ =A0112.471980] PM: Finishing wakeup.
> [ =A0112.471982] Restarting tasks ... <6>usb 3-4.3: USB disconnect, a=
ddress 5

This error shouldn't happen. But you do get a disconnection. Please
recheck you see no udev event and please post "lsusb -v" before and
after suspension.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
