From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Tue, 19 May 2009 14:47:33 +0200
Message-ID: <200905191447.34000.oliver@neukum.org>
References: <4A11C126.1000704@dell.com> <1242710064.3147.4.camel@localhost.localdomain> <20090519090610.GA29967@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:59727 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZESMrO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 08:47:14 -0400
In-Reply-To: <20090519090610.GA29967@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mario Limonciello <mario_limonciello@dell.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, 19. Mai 2009 11:06:12 schrieb Matthew Garrett:
> On Mon, May 18, 2009 at 10:14:24PM -0700, Marcel Holtmann wrote:
> > Hi Matthew,
> >
> > > Ok. I don't think the right way to implement this is forcing
> > > dell-laptop to simulate an unplug. The HCI driver should be responsible
> > > for saving and restoring state of the device in its suspend/resume
> > > method.
> >
> > what do you expect the generic USB driver to do? I don't see anything we
> > can do about it, if the device gets removed from underneath us.
>
> If the device is getting removed from underneath you, why isn't hid2hci
> being run again when it reappears as the hid device?

udev triggers exactly that.

	Regards
		Oliver

