From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
 suspend
Date: Mon, 18 May 2009 23:45:12 -0700
Message-ID: <1242715512.3147.6.camel@localhost.localdomain>
References: <4A11C126.1000704@dell.com>
	 <20090519050327.GA22637@srcf.ucam.org>
	 <1242710064.3147.4.camel@localhost.localdomain>
	 <200905190827.52541.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:41555 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZESGp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 02:45:26 -0400
In-Reply-To: <200905190827.52541.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Mario Limonciello <mario_limonciello@dell.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Oliver,

> > > > When coming out of S3 if the killswitch isn't activated, the logical
> > > > USB mouse isn't coldplugged again preventing the udev rule from being
> > > > matched upon.  You can manually run hid2hci and the device will switch
> > > > modes.
> > >
> > > Ok. I don't think the right way to implement this is forcing dell-laptop
> > > to simulate an unplug. The HCI driver should be responsible for saving
> > > and restoring state of the device in its suspend/resume method.
> >
> > what do you expect the generic USB driver to do? I don't see anything we
> > can do about it, if the device gets removed from underneath us.
> 
> In order to do this we'd have to put hid2hci into usbcore and maintain
> a list of devices it should operate on.

you know that hid2hci is a user space utility.

Regards

Marcel


