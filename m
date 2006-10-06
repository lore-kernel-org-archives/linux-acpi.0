From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Sat, 7 Oct 2006 00:44:36 +0200
Message-ID: <20061006224436.GD29690@elf.ucw.cz>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002003908.GA18707@lists.us.dell.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38549 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161069AbWJFWpS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Oct 2006 18:45:18 -0400
Content-Disposition: inline
In-Reply-To: <20061006211751.GA31887@lists.us.dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

Hi!

> > Please move it into the kernel where it belongs, and use lcd
> > brightness subsystem like everyone else.
> 
> We've been through this before.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114067198323596&w=2
> 
> In addition, the SMI call used to change the backlight level *may*
> require (if configured by the sysadmin in BIOS), a password be
> entered.

This is crazy, password-protected backlight level?

Can you make sure this crazyness does not infect newer models?

> This begs for a common userspace app that can grok libsmbios and
> kernel interfaces both, and use the appropriate method on each, rather
> than just putting it all in the kernel.

Kernel is expected to provide hardware abstraction. libsmbios will
mean person able to change backlight will be able to do lots of
strange stuff...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
