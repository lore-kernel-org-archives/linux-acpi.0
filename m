From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Thu, 12 Nov 2009 11:31:05 +0100
Message-ID: <200911121131.05935.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0911111400370.6882-100000@netrider.rowland.org> <200911112324.58076.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:41504 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZKLK2d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 05:28:33 -0500
In-Reply-To: <200911112324.58076.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Am Mittwoch, 11. November 2009 23:24:57 schrieb Rafael J. Wysocki:
> > Now, this does raise another point, which has been mentioned before.  
> > To wit: devices really ought to have two remote-wakeup attributes, 
> > one for runtime PM and one for system sleep.
> 
> Yes, they do and there's another reason.  Namely, there apparently are
> devices which can wake up the system from a sleep state and that are
> unable to generate runtime wakeup events.

That is outright disgusting. Which devices do this?

It seems to me that if the kernel cannot tell in these cases, we
really need two attributes and there's no alternative.

	Regards
		Oliver
