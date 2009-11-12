From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
	hcd
Date: Thu, 12 Nov 2009 16:59:58 +0000
Message-ID: <20091112165958.GA9389@srcf.ucam.org>
References: <200911112324.58076.rjw@sisk.pl> <200911120841.11263.oliver@neukum.org> <20091112145121.GB6709@srcf.ucam.org> <200911121800.02383.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53890 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbZKLRAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 12:00:12 -0500
Content-Disposition: inline
In-Reply-To: <200911121800.02383.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Thu, Nov 12, 2009 at 06:00:02PM +0100, Oliver Neukum wrote:

> Exactly, but that isn't the same as needing two attributes exported to user
> space. That is an absolute requirement only if we can't tell what a device's
> capabilities are.

Right. I don't see any reason for runtime wakeup to be exposed to 
userspace - it's an entirely orthogonal concept to system wakeup. The 
relevant userspace policy is whether or not runtime pm is enabled.

> We could introduce a second attribute if we want to prevent drivers from
> using remote wakeup to do runtime power management, but it is not
> required. We could simply not give user space that choice.

Absolutely.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
