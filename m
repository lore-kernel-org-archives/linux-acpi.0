From: Pavel Machek <pavel@ucw.cz>
Subject: Something is wrong with acpi_gpe_sleep_prepare
Date: Fri, 24 Aug 2007 11:51:37 +0200
Message-ID: <20070824095137.GA3159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46194 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757905AbXHXVAn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 17:00:43 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, ACPI mailing list <linux-acpi@vger.kernel.org>
Cc: seife@suse.de


...AFAICT noone calls it, and I guess that may be why we are seeing
some "lid open sometimes wake up x60, sometimes does not" fun?

pavel@amd:/data/l/linux/drivers/acpi$ grep -ri  acpi_gpe_sleep_prepare
.
./sleep/wakeup.c:void acpi_gpe_sleep_prepare(u32 sleep_state)
./sleep/sleep.h:extern void acpi_gpe_sleep_prepare(u32 sleep_state);


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
