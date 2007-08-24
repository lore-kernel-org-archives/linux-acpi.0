From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 05:12:27 +0100
Message-ID: <20070824041227.GA8002@srcf.ucam.org>
References: <200708240042.l7O0gtEe022838@turbo.physics.adelaide.edu.au> <20070824013220.GA6242@srcf.ucam.org> <1187927741.2691.43.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:54925 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbXHXEMg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Aug 2007 00:12:36 -0400
Content-Disposition: inline
In-Reply-To: <1187927741.2691.43.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

On Fri, Aug 24, 2007 at 11:55:41AM +0800, Zhang Rui wrote:

> I have the same question for ACPI video driver.
> Take KEY_BRIGHTNESSUP/KEY_BRIGHTNESSDOWN for example, if ACPI video
> driver gets such a notification, it will change the brightness level
> first and then send an event to user space.

The X people would prefer that the kernel not change the brightness 
itself, where possible. In the cases where drivers know how to control 
the backlight hardware themselves (most new Intel hardware, nvidia stuff 
since 2005ish, that sort of thing) it's likely that they'll be able to 
provide much more control than the level provided via the ACPI 
interface.

> I'll send a patch to make ACPI video driver do nothing but export the
> events to user space in the notify handler if you guys think it's okay.

I think that's the right thing to do, but you might want to make it a 
module option to begin with. That way you can printk that the behaviour 
will change in the future, and then flip the default in a few months.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
