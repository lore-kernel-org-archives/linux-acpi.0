From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
	hcd
Date: Thu, 12 Nov 2009 14:50:23 +0000
Message-ID: <20091112145023.GA6709@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0911111400370.6882-100000@netrider.rowland.org> <200911112324.58076.rjw@sisk.pl> <200911121131.05935.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47916 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZKLOu0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 09:50:26 -0500
Content-Disposition: inline
In-Reply-To: <200911121131.05935.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Thu, Nov 12, 2009 at 11:31:05AM +0100, Oliver Neukum wrote:
> Am Mittwoch, 11. November 2009 23:24:57 schrieb Rafael J. Wysocki:
> > > Now, this does raise another point, which has been mentioned before.  
> > > To wit: devices really ought to have two remote-wakeup attributes, 
> > > one for runtime PM and one for system sleep.
> > 
> > Yes, they do and there's another reason.  Namely, there apparently are
> > devices which can wake up the system from a sleep state and that are
> > unable to generate runtime wakeup events.
> 
> That is outright disgusting. Which devices do this?

The ability for a device to raise an ACPI GPE and trigger a wakeup does 
not imply that there's runtime handling for that device's GPE in the 
system's ACPI tables. The default GPE handling code I posted for Intel 
helps here, but there's ample opportunity for us to find machines which 
have system wakeup support but no runtime wakeup support.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
