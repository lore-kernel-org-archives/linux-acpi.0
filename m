From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 20:26:03 +0100
Message-ID: <20090730192603.GB22421@srcf.ucam.org>
References: <20090730190716.GB22016@srcf.ucam.org> <Pine.LNX.4.44L0.0907301516100.6087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51142 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZG3T0D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 15:26:03 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0907301516100.6087-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jul 30, 2009 at 03:22:32PM -0400, Alan Stern wrote:

> Seems likely.  What happens if you suspend the UHCI controller but 
> leave the EHCI controller active?  Then the port-switching logic should 
> kick in.

Yeah, I'll give that a go.

> Which reminds me...  One of the things you had to do was enable remote
> wakeup for the host controllers.  The current initial state is
> disabled, for a good reason.  People don't like it if they suspend
> their laptop only to find that the computer wakes back up again when
> they unplug the USB mouse.
> 
> If we do end up implementing runtime power management for USB host
> controllers, something (a userspace program?) will have to turn off
> remote wakeup before system sleeps and turn it back on afterward.

I think we'll probably want a call for "transitioning from runtime 
suspend to system suspend", at which point the driver can clean that up 
itself.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
