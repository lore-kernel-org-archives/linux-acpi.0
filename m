From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Wed, 11 Nov 2009 18:27:14 +0100
Message-ID: <200911111827.14346.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0911111203490.6882-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:48862 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216AbZKKRYl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 12:24:41 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911111203490.6882-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Am Mittwoch, 11. November 2009 18:08:17 schrieb Alan Stern:
> On Wed, 11 Nov 2009, Oliver Neukum wrote:

> > That seems to be a bit harsh. If you do not specify that a device be
> > able to wake the whole system, why would it be good for a request
> > coming from it to abort a system sleep transition?
> 
> The way you specify that a device be able to wake the whole system is
> by enabling its remote wakeup attribute.  If this attribute is not
> enabled then the device will not send remote wakeup requests, so the
> scenario described above will not occur -- no IRQ will be generated.

But what happens if a driver has requested remote wakeup requests
to do runtime power management?

	Regards
		Oliver
