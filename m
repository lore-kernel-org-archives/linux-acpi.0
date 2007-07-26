From: Mattia Dongili <malattia@linux.it>
Subject: Re: [patch 2.6.21-rc5-git 2/3] ACPI driver model flags and
	platform_enable_wake()
Date: Thu, 26 Jul 2007 16:07:39 +0900
Message-ID: <20070726070739.GB3901@inferi.kami.home>
References: <200704051249.10407.david-b@pacbell.net> <200707251304.03191.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:54465 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762072AbXGZHHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2007 03:07:51 -0400
Content-Disposition: inline
In-Reply-To: <200707251304.03191.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>

On Wed, Jul 25, 2007 at 01:04:02PM -0700, David Brownell wrote:
> I'm curious about the status of the appended patch ... without it,
> the new acpi_pm_device_sleep_state() routine isn't really able to
> do anything intelligent.  The patch still applies to 2.6.23-rc1-git;
> my patches-that-still-haven't-merged queue has had this at the very
> top for quite a few months now...
> 
> As I recall, Mattia Dongili <malattia@linux.it> reported an error
> with a Vaio laptop; it would wake immediately after entering STR.
> It didn't reproduce for anyone else.  But that was eventually tracked
> down to a bug in iwl3945, which has since been fixed (yes?).

not exactly. The problem was a pcmcia express card reader disconnecting
itself after suspend and thus triggering the wakeup.
A good summary is this and following posts:
http://marc.info/?l=linux-acpi&m=118250426218485&w=2

AFAICT it is reproducible by simply suspending and disconnecting an usb
mouse, that should trigger the wakeup event :)

...
> On Thursday 05 April 2007, David Brownell wrote:
> > This upgrades the ACPI code to start cooperating with the two driver
> > model wakeup flags and with pci_enable_wake(), based on the previous
> > patch updating that PCI call:

ciao
-- 
mattia
:wq!
