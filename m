From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Thu, 12 Nov 2009 08:41:11 +0100
Message-ID: <200911120841.11263.oliver@neukum.org>
References: <200911112324.58076.rjw@sisk.pl> <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org> <20091112003312.GA27572@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:44987 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZKLHii (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 02:38:38 -0500
In-Reply-To: <20091112003312.GA27572@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Am Donnerstag, 12. November 2009 01:33:12 schrieb Matthew Garrett:
> On Wed, Nov 11, 2009 at 06:09:24PM -0500, Alan Stern wrote:
> > That's okay.  There's no harm in trying to enable remote wakeup on a 
> > device which doesn't support it.
> 
> There's harm if we're using the ability to generate remote waleups as a 
> condition for whether we can perform runtime pm on the device...

That I would consider backwards. If the user enables runtime power management
of a device, he has to live with remote wakeup being enabled. At most
the kernel might resume and switch off remote wakeup on the device,
but we might also leave this to user space.

	Regards
		Oliver
