From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Something is wrong with acpi_gpe_sleep_prepare
Date: Fri, 24 Aug 2007 12:50:33 +0200
Message-ID: <20070824105033.GA2450@elf.ucw.cz>
References: <20070824095137.GA3159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46217 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762204AbXHXVBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 17:01:32 -0400
Content-Disposition: inline
In-Reply-To: <20070824095137.GA3159@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, ACPI mailing list <linux-acpi@vger.kernel.org>
Cc: seife@suse.de

On Fri 2007-08-24 11:51:37, Pavel Machek wrote:
> 
> ...AFAICT noone calls it, and I guess that may be why we are seeing
> some "lid open sometimes wake up x60, sometimes does not" fun?
> 
> pavel@amd:/data/l/linux/drivers/acpi$ grep -ri  acpi_gpe_sleep_prepare
> .
> ./sleep/wakeup.c:void acpi_gpe_sleep_prepare(u32 sleep_state)
> ./sleep/sleep.h:extern void acpi_gpe_sleep_prepare(u32 sleep_state);

Sorry, my fault. I found out that removing acpi_gpe_sleep_prepare
actually _solves_ "thinkpad will not wake by fn key after s2disk"
problem, and forgot about it.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
