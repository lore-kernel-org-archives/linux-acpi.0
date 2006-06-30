From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp problems with 2.6.17-1.2139_FC5
Date: Fri, 30 Jun 2006 20:01:41 +0200
Message-ID: <20060630180141.GC9225@elf.ucw.cz>
References: <m2irmj9937.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36064 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932986AbWF3SDA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 14:03:00 -0400
Content-Disposition: inline
In-Reply-To: <m2irmj9937.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi!

> swsusp has problems resumeing after upgrading my Acer Travelmate
> 4001WLMi from 2.6.16 to 2.6.17. Note that I'm running a Fedora 5
> kernel, with the ATI proprietary video driver.

Stop right here. Can you reproduce the problem without ATI driver?
Reproducing it on vanilla kernel (not -FC5) would be nice, too.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
