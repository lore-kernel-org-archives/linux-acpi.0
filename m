From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Tue, 19 May 2009 08:27:52 +0200
Message-ID: <200905190827.52541.oliver@neukum.org>
References: <4A11C126.1000704@dell.com> <20090519050327.GA22637@srcf.ucam.org> <1242710064.3147.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:60166 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZESG1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 02:27:36 -0400
In-Reply-To: <1242710064.3147.4.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mario Limonciello <mario_limonciello@dell.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, 19. Mai 2009 07:14:24 schrieb Marcel Holtmann:
> > > When coming out of S3 if the killswitch isn't activated, the logi=
cal
> > > USB mouse isn't coldplugged again preventing the udev rule from b=
eing
> > > matched upon. =A0You can manually run hid2hci and the device will=
 switch
> > > modes.
> >
> > Ok. I don't think the right way to implement this is forcing dell-l=
aptop
> > to simulate an unplug. The HCI driver should be responsible for sav=
ing
> > and restoring state of the device in its suspend/resume method.
>
> what do you expect the generic USB driver to do? I don't see anything=
 we
> can do about it, if the device gets removed from underneath us.

In order to do this we'd have to put hid2hci into usbcore and maintain
a list of devices it should operate on.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
