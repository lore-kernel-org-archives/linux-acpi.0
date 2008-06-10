From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [patch 06/11] misc,acpi,backlight: compal Laptop Extras
Date: Tue, 10 Jun 2008 22:28:59 +0100
Message-ID: <1213133339.5013.56.camel@dax.rpnet.com>
References: <200806092322.m59NMNs9013970@imap1.linux-foundation.org>
	 <alpine.LFD.1.10.0806101253390.14381@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:53545 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYFJWDc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jun 2008 18:03:32 -0400
In-Reply-To: <alpine.LFD.1.10.0806101253390.14381@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, cezary.jackiewicz@gmail.com, aystarik@gmail.com, hmh@hmh.eng.br

On Tue, 2008-06-10 at 12:55 -0400, Len Brown wrote:
> 
> On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:
> 
> > From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> > 
> > This is driver for Compal Laptop: FL90/IFL90, based on MSI driver.
> > 
> > This driver exports a few files in /sys/devices/platform/compal-laptop/:
> >  lcd_level - screen brightness: contains a single integer in the range 0..7 (rw)
> 
> why is it a good idea to implement this platform specific lcd_level API
> and at the same time implement the generic backlight API?

I've asked about this before and suggested the lcd_level attribute be
removed since the backlight API does everything that attribute does in a
standardised way. I never did get a response.

Cheers,

Richard

