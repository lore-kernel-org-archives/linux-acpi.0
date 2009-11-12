From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Thu, 12 Nov 2009 15:44:19 +0100
Message-ID: <200911121544.19313.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:33744 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbZKLOlq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 09:41:46 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Am Donnerstag, 12. November 2009 00:09:24 schrieb Alan Stern:
> > Yes, they do and there's another reason.  Namely, there apparently are
> > devices which can wake up the system from a sleep state and that are
> > unable to generate runtime wakeup events.
> 
> That's okay.  There's no harm in trying to enable remote wakeup on a 
> device which doesn't support it.

That's a bold statement. If Windows doesn't do it, it is most likely a
false statement.

	Regards
		Oliver
