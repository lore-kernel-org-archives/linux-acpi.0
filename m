From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
	hcd
Date: Thu, 12 Nov 2009 00:33:12 +0000
Message-ID: <20091112003312.GA27572@srcf.ucam.org>
References: <200911112324.58076.rjw@sisk.pl> <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45243 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759760AbZKLAdQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 19:33:16 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oliver@neukum.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Wed, Nov 11, 2009 at 06:09:24PM -0500, Alan Stern wrote:

> That's okay.  There's no harm in trying to enable remote wakeup on a 
> device which doesn't support it.

There's harm if we're using the ability to generate remote waleups as a 
condition for whether we can perform runtime pm on the device...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
