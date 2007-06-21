From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 13:32:22 -0700
Message-ID: <200706211332.23466.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org> <200706212219.52699.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:34444 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753097AbXFUUcX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 16:32:23 -0400
In-Reply-To: <200706212219.52699.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>

On Thursday 21 June 2007, Rafael J. Wysocki wrote:

> platform->lowest_power_state_the_device_can_be_in(dev, wakeup)
> 
> and
> 
> platform->highest_power_state_the_device_can_be_in(dev)
> 
> where 'wakeup' tells the platform whether we want this device to be able to
> wake up the system.

That won't work well except with ACPI, since few systems centralize
that knowledge.  Like ACPI does with AML ... but mostly for PCI.

Look at your average SOC chip spec and you'll see a lot of information
that lives most naturally in the device drivers, or sometimes in the
clock framework.



> pm_ops->prepare() is now called after the drivers' .suspend() routines have
> been executed, so the ACPI core, for example, has no means of learning what
> the next system state will be until all devices have been suspended.

Well that's a design mistake.  Remember that those suspend() methods
need to know the target system states, so that they can call the right
"_SxD" and "_SxW" methods.  There needs to be *SOME* call into the
platform code that can be used to track "x" for ACPI ... or whatever
is needed on other platforms.

What is "now" by the way ... something in the MM tree?  Or did that
sneak in while I wasn't looking?

- Dave

